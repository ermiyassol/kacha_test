import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kacha_test/core/app.dart';
import 'package:kacha_test/di/Injector.dart';
import 'package:kacha_test/core/observers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize dependencies
  await initSingletons();
  provideDataSources();
  provideRepositories();
  provideUseCases();

  // Set device orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(ProviderScope(observers: [Observers()], child: const MyApp()));
}
