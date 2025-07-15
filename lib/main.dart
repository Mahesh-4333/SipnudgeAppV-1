import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' show ScreenUtilInit;
import 'package:flutterapp1/account&security.dart';
import 'package:flutterapp1/achievement.dart';
import 'package:flutterapp1/contactsupport.dart';
import 'package:flutterapp1/forgotpassword.dart' show ForgotPassword;
import 'package:flutterapp1/forgotpwdotppage.dart' show ForgotPwdOtpPage;
import 'package:flutterapp1/help&support.dart' show HelpAndSupportPage;
import 'package:flutterapp1/homeanalysis.dart';
import 'package:flutterapp1/homepage.dart';
//import 'package:flutterapp1/homepage.dart';
import 'package:flutterapp1/lifestyleinfoscreen.dart' show LifeStyleInfoPage;
import 'package:flutterapp1/linkedaccounts.dart' show LinkAccountsPage;
import 'package:flutterapp1/loadingscreen.dart' show LoadingPage;
import 'package:flutterapp1/companymotto.dart' show CompanyMottoPage;
import 'package:flutterapp1/logoscreen.dart';
import 'package:flutterapp1/otpscreen.dart' show OtpScreen;
import 'package:flutterapp1/passwordupdatepage.dart' show PasswordUpdatedScreen;
import 'package:flutterapp1/personalinfo.dart';
import 'package:flutterapp1/personalinfoinprofile.dart'
    show PersonalInfoInProfile;
import 'package:flutterapp1/preferences.dart' show PreferencesPage;
import 'package:flutterapp1/profilescreen.dart' show ProfileScreenPage;
import 'package:flutterapp1/setnewpasswordscreen.dart';
import 'package:flutterapp1/signin.dart' show SignInPage;
import 'package:flutterapp1/signin_signup.dart' show SignIn_SignUpPage;
import 'package:flutterapp1/signupblankpage.dart' show SignUpBlankPage;

import 'dailygoalpage.dart';

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
            
             '/': (context) => LogoScreenPage(),
            '/companymotto': (context) => CompanyMottoPage(),
            '/signin_signupsage': (context) => SignIn_SignUpPage(),
            '/signupblankpage': (context) => SignUpBlankPage(),
            '/signin': (context) => SignInPage(),
            '/forgotpassword': (context) => ForgotPassword(),
            '/personalinfo': (context) => PersonalInfoPage(),
            '/otpscreen': (context) => OtpScreen(),
            '/loadingscreen': (context) => LoadingPage(),
            '/dailygoalpage': (context) => DailyGoalPage(),
            '/lifestyleinfo': (context) => LifeStyleInfoPage(),
            '/forgotpasswordotp': (context) => ForgotPwdOtpPage(),
            '/newpasswordscreen': (context) => NewPasswordScreen(),
            '/newpasswordupdate': (context) => PasswordUpdatedScreen(),
            '/homepage': (context) => HomePageScreen(),
            '/profilescreen': (context) => ProfileScreenPage(),
            '/personalinfoinprofile': (context) => PersonalInfoInProfile(),
            '/preferences': (context) => PreferencesPage(),
            '/linked_accounts': (context) => LinkAccountsPage(),
            '/support': (context) => HelpAndSupportPage(),
            '/contact_support': (context) => CustomerSupportPage(),
            '/account_security': (context) => AccountAndSecurityPage(),
            '/analysis': (context) => HomeAnalysisPage(),
            '/achievement': (context) => const BadgeWithConcentricBackground(),
          },
        );
      },
    );
  }
}
