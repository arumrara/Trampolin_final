import 'dart:math';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class DeteksiController extends GetxController {
  late Interpreter interpreter;
  List<String> labels = [];
  List<List<double>> labelLandmarks = []; // Simpan landmarks untuk setiap label

  CameraController? cameraController;
  List<CameraDescription> cameras = [];
  int selectedCameraIndex = 0;

  var isCameraInitialized = false.obs;
  var isDetectionEnabled = false.obs;
  final poseDetector = PoseDetector(
    options: PoseDetectorOptions(mode: PoseDetectionMode.stream),
  );

  var predictedLabel = 'unknown'.obs;
  bool isDetecting = false;

  int frameCounter = 0;

  @override
  void onInit() {
    super.onInit();
    loadModel(); // ✅ Hanya load model, tidak langsung nyalakan kamera
  }

  @override
  void onClose() {
    stopCamera();
    interpreter.close();
    super.onClose();
  }

  Future<void> loadModel() async {
    try {
      debugPrint('🔄 Memuat model...');
      interpreter = await Interpreter.fromAsset('assets/models/pose_cnn_model.tflite');
      debugPrint('✅ Model berhasil dimuat');

      final labelData = await rootBundle.loadString('assets/models/labels/labels.txt');
      labels = labelData.split('\n').where((e) => e.trim().isNotEmpty).toList();
      debugPrint('✅ Labels dimuat (${labels.length} label)');

      // Simpan landmark label untuk setiap label
      await loadLabelLandmarks();
    } catch (e) {
      debugPrint("❌ Error loading model: $e");
    }
  }

  Future<void> loadLabelLandmarks() async {
    // Anda perlu memuat landmark untuk setiap label, bisa berupa landmark yang sudah disiapkan sebelumnya
    // Untuk keperluan contoh, kita akan menyimpan landmark dummy
    // Misalnya, misalnya kita punya vektor landmark untuk setiap label
    labelLandmarks = List.generate(
      labels.length,
      (index) => List.generate(99, (i) => Random().nextDouble()), // Dummy random landmark
    );
  }

  Future<void> startCamera() async {
    try {
      cameras = await availableCameras();
      await initializeCamera(selectedCameraIndex);
    } catch (e) {
      debugPrint("❌ Error starting camera: $e");
    }
  }

  Future<void> stopCamera() async {
    try {
      await cameraController?.stopImageStream();
      await cameraController?.dispose();
    } catch (_) {}
    cameraController = null;
    isCameraInitialized.value = false;
    predictedLabel.value = 'unknown';
    isDetectionEnabled.value = false;
  }

  Future<void> switchCamera() async {
    if (cameras.isEmpty) {
      cameras = await availableCameras();
    }
    selectedCameraIndex = (selectedCameraIndex + 1) % cameras.length;
    await stopCamera();
    await initializeCamera(selectedCameraIndex);
  }

  void toggleDetection() {
    isDetectionEnabled.value = !isDetectionEnabled.value;
    predictedLabel.value = 'unknown';
  }

  Future<void> initializeCamera(int cameraIndex) async {
    try {
      final selectedCamera = cameras[cameraIndex];
      cameraController = CameraController(
        selectedCamera,
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.nv21,
      );

      await cameraController!.initialize();
      await cameraController!.startImageStream(processCameraImage);
      isCameraInitialized.value = true;
      debugPrint("✅ Kamera berhasil diinisialisasi");
    } catch (e) {
      debugPrint('❌ Camera init error: $e');
    }
  }

  double calculateCosineSimilarity(List<double> vec1, List<double> vec2) {
    double dotProduct = 0.0;
    double magnitudeVec1 = 0.0;
    double magnitudeVec2 = 0.0;

    for (int i = 0; i < vec1.length; i++) {
      dotProduct += vec1[i] * vec2[i];
      magnitudeVec1 += vec1[i] * vec1[i];
      magnitudeVec2 += vec2[i] * vec2[i];
    }

    return dotProduct / (sqrt(magnitudeVec1) * sqrt(magnitudeVec2));
  }

  void processCameraImage(CameraImage image) async {
    if (!isDetectionEnabled.value || isDetecting || labels.isEmpty || cameraController == null) return;
    isDetecting = true;

    frameCounter++; 

    if (frameCounter % 30 != 0) {
      isDetecting = false;
      return;
    }

    try {
      final WriteBuffer allBytes = WriteBuffer();
      for (final Plane plane in image.planes) {
        allBytes.putUint8List(plane.bytes);
      }
      final bytes = allBytes.done().buffer.asUint8List();

      final rotation = InputImageRotationValue.fromRawValue(
            cameraController!.description.sensorOrientation,
          ) ?? InputImageRotation.rotation0deg;

      final format = InputImageFormatValue.fromRawValue(image.format.raw);
      if (format == null) {
        debugPrint("❌ Format tidak didukung: ${image.format.raw}");
        isDetecting = false;
        return;
      }

      final inputImage = InputImage.fromBytes(
        bytes: bytes,
        metadata: InputImageMetadata(
          size: Size(image.width.toDouble(), image.height.toDouble()),
          rotation: rotation,
          format: format,
          bytesPerRow: image.planes[0].bytesPerRow,
        ),
      );

      final poses = await poseDetector.processImage(inputImage);
      debugPrint("✅ Positions Detected: ${poses.length}");

      if (poses.isNotEmpty) {
        final pose = poses.first;

        if (pose.landmarks.length == 33) {
          final List<double> keypoints = [];
          for (var lmType in PoseLandmarkType.values) {
            final lm = pose.landmarks[lmType];
            keypoints.addAll(lm != null ? [lm.x, lm.y, lm.z] : [0.0, 0.0, 0.0]);
          }

          debugPrint("✅ Keypoints length: ${keypoints.length}");
          if (keypoints.length == 99) {
            // Cari label yang paling mirip
            double maxSimilarity = -1;
            int bestLabelIndex = -1;

            for (int i = 0; i < labelLandmarks.length; i++) {
              double similarity = calculateCosineSimilarity(keypoints, labelLandmarks[i]);
              if (similarity > maxSimilarity) {
                maxSimilarity = similarity;
                bestLabelIndex = i;
              }
            }

            // Tentukan label berdasarkan similarity tertinggi
            if (maxSimilarity > 0.6) { // Threshold similarity
              predictedLabel.value = labels[bestLabelIndex];
              debugPrint("✅ Gerakan terdeteksi: ${predictedLabel.value} (Similarity: ${(maxSimilarity * 100).toStringAsFixed(1)}%)");
            } else {
              predictedLabel.value = 'unknown';
              debugPrint("⚠️ Gerakan tidak dikenali dengan tingkat kesamaan tinggi");
            }
          }
        } else {
          debugPrint("⚠️ Landmark tidak lengkap (terdeteksi ${pose.landmarks.length})");
        }
      } else {
        debugPrint("❌ Tidak ada pose yang terdeteksi.");
      }
    } catch (e) {
      debugPrint("❌ Pose detection error: $e");
    } finally {
      isDetecting = false;
    }
  }
}
