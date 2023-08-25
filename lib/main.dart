import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/attendance/attendance_cubit.dart';
import 'cubit/auth/auth_cubit.dart';
import 'cubit/class/class_cubit.dart';
import 'cubit/student/student_cubit.dart';
import 'firebase_options.dart';
import 'ui/pages/home/main_page.dart';
import 'ui/pages/sign_in_page.dart';
import 'ui/pages/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => ClassCubit(),
        ),
        BlocProvider(
          create: (context) => StudentCubit(),
        ),
        BlocProvider(
          create: (context) => AttendanceCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
          useMaterial3: true,
        ),
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const SignInPage(),
          '/main': (context) => const MainPage(),
        },
      ),
    );
  }
}
