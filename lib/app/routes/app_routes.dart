part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const HOME = '/home';
  static const PROFILE = '/profile';
  static const WELCOME = '/welcome'; // Pastikan ini ada
  static const GUIDE = '/guide';
  static const ARTICLE = '/article';
  static const DETEKSI = '/deteksi';
  static const FORGOT_PASSWORD = '/forgot-password';
  static const EDIT_PROFILE = '/edit-profile';
  static const OTP = '/otp';

  static const JUMP_DROP = '/jump-drop';
  static const SEAT_DROP = '/seat-drop';
  static const PIKE_JUMP = '/pike-jump';
  static const TUCK_JUMP = '/tuck-jump';
  static const STRADDLE_JUMP = '/straddle-jump';
  static const STREAMLIT_RESULT = '/streamlit-result';
  static const HISTORY = '/history';
}
