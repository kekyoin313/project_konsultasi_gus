import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_preview/device_preview.dart';
import 'firebase_options.dart';
import 'Models/Models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Run the app within DevicePreview if in debug mode
  runApp(
    DevicePreview(
      enabled: !kReleaseMode, // Enable DevicePreview only in debug mode
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder, // Builder for DevicePreview
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Splashscreen(),
        '/HomeScreen': (context) => HomeScreen(),
        '/Schedule': (context) => ScheduleScreen(),
        '/viewSchedules': (context) => ViewSchedulesScreen(),
      },
      title: 'TanyaGus',
      theme: ThemeData(primarySwatch: Colors.blue),
      darkTheme: ThemeData.dark(),
    );
  }
}
