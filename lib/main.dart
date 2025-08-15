import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp1/account&security.dart';
import 'package:flutterapp1/achievement.dart';
import 'package:flutterapp1/companymotto.dart';
import 'package:flutterapp1/contactsupport.dart';
import 'package:flutterapp1/cubit/reminder_cubit.dart';
import 'package:flutterapp1/cubit/reminder_mode_cubit.dart';
import 'package:flutterapp1/cubit/reminder_time_cubit.dart';
import 'package:flutterapp1/cubit/water_intake_timeline_cubit.dart';
import 'package:flutterapp1/dailygoalpage.dart';
import 'package:flutterapp1/drink_reminder.dart';
import 'package:flutterapp1/forgotpassword.dart';
import 'package:flutterapp1/forgotpwdotppage.dart';
import 'package:flutterapp1/help&support.dart';
import 'package:flutterapp1/homeanalysis.dart';
import 'package:flutterapp1/homepage.dart';
import 'package:flutterapp1/lifestyleinfoscreen.dart';
import 'package:flutterapp1/linkedaccounts.dart';
import 'package:flutterapp1/loadingscreen.dart';
import 'package:flutterapp1/otpscreen.dart';
import 'package:flutterapp1/passwordupdatepage.dart';
import 'package:flutterapp1/personalinfo.dart';
import 'package:flutterapp1/personalinfoinprofile.dart';
import 'package:flutterapp1/preferences.dart';
import 'package:flutterapp1/profilescreen.dart';
import 'package:flutterapp1/setnewpasswordscreen.dart';
import 'package:flutterapp1/signin.dart';
import 'package:flutterapp1/signin_signup.dart';
import 'package:flutterapp1/signupblankpage.dart';
import 'package:flutterapp1/water_intake_timeline.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<HydrationCubit>(create: (context) => HydrationCubit()),
            BlocProvider(create: (context) => ReminderCubit()),
            BlocProvider(create: (context) => ReminderTimeCubit()),
            BlocProvider(create: (context) => ReminderIntervalCubit()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (context) => DrinkReminder(),
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
              '/achievement': (context) => BadgeWithConcentricBackground(),
              '/waterintaketimeline': (context) => WaterIntakeTimeline(),
            },
          ),
        );
      },
    );
  }
}
