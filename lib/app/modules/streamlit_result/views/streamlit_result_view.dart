import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StreamlitResultView extends StatefulWidget {
  const StreamlitResultView({Key? key}) : super(key: key);

  @override
  State<StreamlitResultView> createState() => _StreamlitResultViewState();
}

class _StreamlitResultViewState extends State<StreamlitResultView> {
  late final WebViewController _controller;

  final String streamlitUrl = 'https://appe-qpn68nwzogwxoapatjh2yg.streamlit.app/';

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(streamlitUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Analisis'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
