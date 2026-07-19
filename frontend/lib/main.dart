import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/api/api_client.dart';
import 'core/storage/secure_storage.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize secure storage
  final secureStorage = SecureStorage();

  // Initialize API client
  final apiClient = ApiClient();
  await apiClient.init(secureStorage: secureStorage);

  runApp(
    ProviderScope(
      child: App(secureStorage: secureStorage),
    ),
  );
}
