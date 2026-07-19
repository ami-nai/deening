import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static final String baseUrl = dotenv.env['BASEURL'] ?? 'http://localhost:8000';
  static const String apiPrefix = '/api/v1';

  // Auth endpoints
  static const String authRegister = '$apiPrefix/auth/register';
  static const String authLogin = '$apiPrefix/auth/login';
  static const String authRefresh = '$apiPrefix/auth/refresh';
  static const String authRecover = '$apiPrefix/auth/recover';
  static const String authReset = '$apiPrefix/auth/reset';
  static const String authMe = '$apiPrefix/auth/me';

  // Prayer endpoints
  static const String prayerLog = '$apiPrefix/prayers/log';
  static const String prayerUnlog = '$apiPrefix/prayers/unlog';
  static const String prayerMonth = '$apiPrefix/prayers/month';

  // Stats endpoints
  static const String stats = '$apiPrefix/stats';

  // Request timeout
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);
}