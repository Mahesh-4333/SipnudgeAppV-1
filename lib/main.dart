import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp1/about_us.dart';
import 'package:flutterapp1/companymotto.dart';
import 'package:flutterapp1/cubit/account&security/account&security_cubit.dart';
import 'package:flutterapp1/cubit/help&support/help&support_cubil.dart';
import 'package:flutterapp1/cubit/level/level_cubit.dart';
import 'package:flutterapp1/cubit/linkaccounts/link_accounts_cubit.dart';
import 'package:flutterapp1/cubit/profile_screen_in_setting/profile_cubit.dart';
import 'package:flutterapp1/cubit/reminder time&mode/reminder_cubit.dart';
import 'package:flutterapp1/cubit/reminder time&mode/reminder_mode_cubit.dart';
import 'package:flutterapp1/cubit/reminder time&mode/reminder_time_cubit.dart';
import 'package:flutterapp1/cubit/reminder time&mode/water_intake_timeline_cubit.dart';
import 'package:flutterapp1/dailygoalpage.dart';
import 'package:flutterapp1/forgotpassword.dart';
import 'package:flutterapp1/forgotpwdotppage.dart';
import 'package:flutterapp1/homeanalysis.dart';
import 'package:flutterapp1/homepage.dart';
import 'package:flutterapp1/lifestyleinfoscreen.dart';
import 'package:flutterapp1/loadingscreen.dart';
import 'package:flutterapp1/otpscreen.dart';
import 'package:flutterapp1/passwordupdatepage.dart';
import 'package:flutterapp1/personalinfo.dart';
import 'package:flutterapp1/privacy_policy.dart';
import 'package:flutterapp1/screens/account&security_page.dart';
import 'package:flutterapp1/screens/achievement.dart';
import 'package:flutterapp1/screens/customer_support_page.dart';
import 'package:flutterapp1/screens/drink_reminder_page.dart';
import 'package:flutterapp1/screens/faq_page.dart';
import 'package:flutterapp1/screens/help&support_page.dart';
import 'package:flutterapp1/screens/link_accounts_page.dart';
import 'package:flutterapp1/screens/personal_info_in_profile_page.dart';
import 'package:flutterapp1/screens/preferences_page.dart';
import 'package:flutterapp1/screens/profile_screen_page.dart';
import 'package:flutterapp1/setnewpasswordscreen.dart';
import 'package:flutterapp1/signin.dart';
import 'package:flutterapp1/signin_signup.dart';
import 'package:flutterapp1/signupblankpage.dart';
import 'package:flutterapp1/trems_of_services.dart';
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
            BlocProvider(create: (context) => LevelCubit()),
            BlocProvider(create: (context) => ProfileCubit()),
            BlocProvider(create: (context) => LinkAccountsCubit()),
            BlocProvider(create: (context) => AccountSecurityCubit()),
            BlocProvider(create: (context) => HelpAndSupportCubit()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (context) => BadgeWithConcentricBackground(),
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
              '/personalinfoinprofile':
                  (context) => PersonalInfoScreenInProfile(),
              '/drinkreminder': (context) => DrinkReminder(),
              '/preferences': (context) => PreferencesPage(),
              '/linked_accounts': (context) => LinkAccountsPage(),
              '/support': (context) => HelpAndSupportPage(),
              '/contact_support': (context) => CustomerSupportPage(),
              '/account_security': (context) => AccountAndSecurityPage(),
              '/analysis': (context) => HomeAnalysisPage(),
              '/achievement': (context) => BadgeWithConcentricBackground(),
              '/waterintaketimeline': (context) => WaterIntakeTimeline(),
              '/faq': (context) => FAQPage(),
              '/privacypolicy': (context) => PrivacyPolicy(),
              '/termsofservices': (context) => TermsOfServices(),
              '/aboutus': (context) => AboutUs(),
            },
          ),
        );
      },
    );
  }
}
