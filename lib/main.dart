import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' show ScreenUtilInit;
import 'package:flutterapp1/achievement.dart';
import 'package:flutterapp1/homepage.dart';
//import 'package:flutterapp1/homepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
        430,
        932,
      ), // Use your design's size (e.g. iPhone 14 Pro Max)
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            //'/': (context) => const BadgeWithConcentricBackground(),
            '/': (context) => HomePageScreen(),
            // '/companymotto': (context) => CompanyMottoPage(),
            // '/signin_signupsage': (context) => SignIn_SignUpPage(),
            // '/signupblankpage': (context) => SignUpBlankPage(),
            // '/signin': (context) => SignInPage(),
            // '/forgotpassword': (context) => ForgotPassword(),
            // '/personalinfo': (context) => PersonalInfoPage(),
            // '/otpscreen': (context) => OtpScreen(),
            // '/loadingscreen': (context) => LoadingPage(),
            // '/dailygoalpage': (context) => DailyGoalPage(),
            // '/lifestyleinfo': (context) => LifeStyleInfoPage(),
            // '/forgotpasswordotp': (context) => ForgotPwdOtpPage(),
            // '/newpasswordscreen': (context) => NewPasswordScreen(),
            // '/newpasswordupdate': (context) => PasswordUpdatedScreen(),
            // '/homepage': (context) => HomePageScreen(),
            // '/profilescreen': (context) => ProfileScreenPage(),
            // '/personalinfoinprofile': (context) => PersonalInfoInProfile(),
            // '/preferences': (context) => PreferencesPage(),
            // '/linked_accounts': (context) => LinkAccountsPage(),
            // '/support': (context) => HelpAndSupportPage(),
            // '/contact_support': (context) => CustomerSupportPage(),
            // '/account_security': (context) => AccountAndSecurityPage(),
            //'/analysis': (context) => HomeAnalysisPage(),
            // '/achievement': (context) => BadgeWithConcentricBackground(),
          },
        );
      },
    );
  }
}
