import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' show ScreenUtilInit;
import 'package:flutterapp1/forgotpassword.dart' show ForgotPassword;
import 'package:flutterapp1/logoscreen.dart' show LogoScreenPage;
import 'package:flutterapp1/companymotto.dart' show CompanyMottoPage;
import 'package:flutterapp1/otpscreen.dart' show OtpScreen;
import 'package:flutterapp1/personalinfo.dart';
import 'package:flutterapp1/signin.dart' show SignInPage;
import 'package:flutterapp1/signin_signup.dart' show SignIn_SignUpPage;
import 'package:flutterapp1/signupblankpage.dart' show SignUpBlankPage;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932), // Use your design's size (e.g. iPhone 14 Pro Max)
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => LogoScreenPage(),
            '/companymotto': (context) => CompanyMottoPage(),
            '/signin_signupsage': (context) => SignIn_SignUpPage(),
            '/signupblankpage': (context) => SignUpBlankPage(),
            '/signin': (context) => SignInPage(),
            '/forgotpassword': (context) => ForgotPassword(),
            '/personalinfo' : (context) => PersonalInfoPage(),
            '/otpscreen' : (context) => OtpScreen(),
          },
        );
      },
    );
  }
}


