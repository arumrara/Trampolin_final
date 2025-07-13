import 'package:get/get.dart';

import '../modules/Jump_drop/bindings/jump_drop_binding.dart';
import '../modules/Jump_drop/views/jump_drop_view.dart';
import '../modules/Pike_Jump/bindings/pike_jump_binding.dart';
import '../modules/Pike_Jump/views/pike_jump_view.dart';
import '../modules/Seat_Drop/bindings/seat_drop_binding.dart';
import '../modules/Seat_Drop/views/seat_drop_view.dart';
import '../modules/Straddle_Jump/bindings/straddle_jump_binding.dart';
import '../modules/Straddle_Jump/views/straddle_jump_view.dart';
import '../modules/Tuck_jump/bindings/tuck_jump_binding.dart';
import '../modules/Tuck_jump/views/tuck_jump_view.dart';
import '../modules/article/bindings/article_binding.dart';
import '../modules/article/views/article_view.dart';
import '../modules/deteksi/bindings/deteksi_binding.dart';
import '../modules/deteksi/views/deteksi_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/guide/bindings/guide_binding.dart';
import '../modules/guide/views/guide_view.dart';
import '../modules/history/bindings/history_binding.dart';
import '../modules/history/views/history_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/streamlit_result/bindings/streamlit_result_binding.dart';
import '../modules/streamlit_result/views/streamlit_result_view.dart';
import '../modules/welcome/bindings/welcome_binding.dart';
import '../modules/welcome/views/welcome_view.dart';

// Import semua binding dan view yang dibutuhkan

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // UBAH INI: default route dari LOGIN -> WELCOME
  static const INITIAL = Routes.WELCOME;

  static final routes = <GetPage>[
    GetPage(
      name: Routes.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.WELCOME,
      page: () => const WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: Routes.GUIDE,
      page: () => const GuideView(),
      binding: GuideBinding(),
    ),
    GetPage(
      name: Routes.ARTICLE,
      page: () => const ArticleView(),
      binding: ArticleBinding(),
    ),
    GetPage(
      name: Routes.DETEKSI,
      page: () => const DeteksiView(),
      binding: DeteksiBinding(),
    ),
    GetPage(
      name: Routes.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: Routes.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: Routes.OTP,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: Routes.JUMP_DROP,
      page: () => const JumpDropView(),
      binding: JumpDropBinding(),
    ),
    GetPage(
      name: Routes.SEAT_DROP,
      page: () => const SeatDropView(),
      binding: SeatDropBinding(),
    ),
    GetPage(
      name: Routes.PIKE_JUMP,
      page: () => const PikeJumpView(),
      binding: PikeJumpBinding(),
    ),
    GetPage(
      name: Routes.TUCK_JUMP,
      page: () => const TuckJumpView(),
      binding: TuckJumpBinding(),
    ),
    GetPage(
      name: Routes.STRADDLE_JUMP,
      page: () => const StraddleJumpView(),
      binding: StraddleJumpBinding(),
    ),
    GetPage(
      name: Routes.STREAMLIT_RESULT,
      page: () => const StreamlitResultView(),
      binding: StreamlitResultBinding(),
    ),
    GetPage(
      name: Routes.HISTORY,
      page: () => const HistoriView(),
      binding: HistoryBinding(),
    ),
  ];
}
