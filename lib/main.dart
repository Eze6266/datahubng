// ignore_for_file: prefer_const_constructors

import 'package:datahub/AuthScreens/login_screen.dart';
import 'package:datahub/AuthScreens/sign_up_screen.dart';
import 'package:datahub/Providers/auth_providers.dart';
import 'package:datahub/Providers/cable_provider.dart';
import 'package:datahub/Providers/data_providers.dart';
import 'package:datahub/Providers/electricty_provider.dart';
import 'package:datahub/Utilities/app_colors.dart';
import 'package:datahub/navbar.dart';
import 'package:datahub/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  await FlutterConfig.loadEnvVariables();
  WidgetsFlutterBinding.ensureInitialized();

  //WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ); // Lock the app to PortraitUp mode

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryColor,
        statusBarBrightness: Brightness.light,
      ),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<DataProvider>(
            create: (context) => DataProvider(),
          ),
          ChangeNotifierProvider<AuthProvider>(
            create: (context) => AuthProvider(),
          ),
          ChangeNotifierProvider<CableProvider>(
            create: (context) => CableProvider(),
          ),
          ChangeNotifierProvider<ElectricityProvider>(
            create: (context) => ElectricityProvider(),
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DATAHUBNG',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
