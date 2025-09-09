//import 'package:flutter/services.dart';

class AppStrings {
  static const goodMorning = "Good Morning,";
  static const itsA = "It's a ";
  static const sunnyDay = "Sunny";
  static const today = " today!";
  static const pleaseWait = "Please wait";
  static const loginAgain = "Login again";
  static const waterBottleReminder =
      "Remember to stay hydrated throughout the day";
  static const analysis = "Analysis";
  static const analyingYourData =
      "Analyzing your data to create a personalized hydration plan...";
  static const almostThere =
      "Almost there! Your personalized hydration plan is coming right up.";
  static const home = "Home";
  static const setting = "Settings";
  static const drinkCompletion = "Drink Completion";
  static const drinkTypes = "Drink Types";
  static const done = "Done";
  static const upgradePlan2 =
      "Enjoy all the benefits and explore more possibilities";
  static const upgradePlan = "Upgrade Plan Now!";
  static const waterIntake = "Water Intake";
  static const continueAsGuest = "Continue as a guest";
  static const authenticate = "Authenticate";
  static const errorLoadingData = "Error loading data";
  static const noDataAvailable = "No data available";
  static const noGoalCompletionDataAvailable =
      "No goal completion data available";
  static const createAnAccount =
      "Create an account to track your water intake, set reminders, and unlock achievements.";
  static const submit = "Submit";
  static const email = "Email";
  static const password = "Password";
  static const iAgree = "I agree to Sipnudge ";
  static const goToHome = "Go to Homepage";
  static const termsAndConditions = "T&C.";
  static const clickToContinue = " Click to continue.";
  static const alreadyHaveAnAccount = "Already have an account? ";
  static const getStartedWithSipnudge = "Get started with SipNudge ✨";
  static const gladToSeeYou = "Glad to see you again! 👋";
  static const forgotYourPassword = "Forgot Your Password? 🔑";
  static const noWorries =
      "No worries! Enter your registered email below to reset your password.";
  static const registeredEmail = "Your Registered Email";
  static const sendOTP = "Send OTP Code";
  static const enterOTP = "Enter OTP Code 🔐";
  static const secureYourAccount = "Secure Your Account 🔒";
  static const chooseNewPass =
      "Choose a new password for your Hydrify account. Make sure it's strong and memorable.";
  static const newPass = "New Password";
  static const confirmNewPass = "Confirm New Password";
  static const saveNewPass = "Save New Password";
  static const weHaveSentOTP =
      "We've sent an OTP code to your email. Please check your inbox and enter the code below.";
  static const resendOTP = "Resend code";

  static const pleaseEnterRegisteredEmail =
      "Please enter your registered email";
  static const emailIsNotValid = "Email is not valid";

  static const signinToYourAccount =
      "Sign in to your account to continue your journey towards a healthier you.";
  static const forgotPassword = "Forgot Password?";
  static const rememberMe = "Remember me";

  static const or = "or";
  static const beginYourJourney = "Begin your journey";
  static const letsDive = "Let's dive in into your account";
  static const continueWithGoogle = "Continue with Google";
  static const continueWithApple = "Continue with Apple";
  static const signIn = "Sign in";
  static const signUp = "Sign up";
  static const privacyPolicy = "Privacy Policy";
  static const termsOfService = "Terms of Service";

  static const noDrinkTypeDataAvailable = "No drink type data available";
  static const youCanResendTheCodeIn = "You can resend the code in ";
  static const seconds = " seconds";
  static const verifyingOtp = "Verifying OTP";
  static const allSet = "You're All Set!";
  static const personalInformation = "Personal Information";
  static const sleepAndLifecycle = "Sleep and Lifestyle Information";
  static const whatsBedTime = "What's your bedtime?";
  static const whenDoYouWakeup = "What's your wake-up?";
  static const whatsYourGender = "What's your gender?";
  static const whatsYourActivityLevel = "What's your activity level?";
  static const sedentary = "Sedentary";
  static const sedentaryDes = "less than 5000 steps";
  static const lightActivityDes = "5,000 - 7,500 steps";
  static const midActivityDes = "7,500 - 10,000 steps";
  static const veryActivityDes = "More than 10,000 steps";
  static const lightlyActive = "Lightly active";
  static const moderatelyActive = "Moderately active";
  static const veryActive = "Very active";

  static const whatsYourDiet = "What's your diet type?";
  static const balanced = "Standard Balanced Diet";
  static const veg = "Vegetarian";
  static const vegan = "Vegan";
  static const highProtein = "High Protein Diet";
  static const processedDiet = "High Sodium Processed Diet";
  static const male = "Male";
  static const female = "Female";
  static const preferNotToSay = "Prefer not to say";
  static const howTall = "How tall are you?";
  static const enterHeight = "Enter your height";
  static const enterYourWeight = "Enter your weight";
  static const whatIsYourAge = "What's your age?";
  static const enterYourAge = "Enter your age in years";
  static const next = "Next";
  static const howMuchWeight = "How much do you weigh?";

  static const weightSelection = "Weight selection";
  static const heightSelection = "Height selection";
  static const ageSelection = "Age selection";
  static const yourDailyGoalIs = "Your Daily goal is ";
  static const passwordResetSuccess =
      "Your password has been successfully updated.";
  static const goalProgress =
      "You got 50% of today's goal, keep focus on your health!";

  static const letsHitHydrationGoals = "Let's hit our hydration goals";
  static getGoalString(double goalPercent) {
    return "You got ${goalPercent.toInt()}% of today's goal, keep focusing on your health!";
  }

  static setResendOtpTimerString(int seconds) {
    return "You can resend the code in $seconds seconds";
  }

  // Below contents are added by Dhananjay
  static const accountremove =
      "Permanently remove your account and data. Proceed with caution.";
  static const deleteaccount = "Delete Account";
  static const congratulations =
      "Congratulations! You've reached goal of 350 water intake. Keep up the incredible effort!";
  static const levelreach = "You've Reached Level";
  static const customersupport = "Customer Support";
  static const privacyandpolicy = "Privacy & Policy";
  static const termsandservices = "Terms & Services";
  static const helpandsupport = "Help & Support";
  static const faq = "F&Q";
  static const contactus = "Contact Us";
  static const aboutus = "About Us";
  static const linkyouraccounts = "Link Your Accounts";
  static const linkaccounts = "Link Accounts";
  static const reminder = "Reminder";
  static const reminderMode = "Reminder Mode";
  static const smartSkip = "Smart Skip";
  static const alarmRepeat = "Alarm Repeat";
  static const stopWhen100 = "Stop When 100%";
  static const remindersetting = "Reminder Settings";
  static const waterintaketimeline = "Water Intake Timeline";
  static const profileinfo = "Profile Info";
  static const editprofile = "Edit Profile";
  static const preferences = "Preferences";
  static const personalinfo = "Personal Info";
  static const profile = "Profile";
  static const achievement = "Achievement";
  static const drinkreminder = "Drink Reminder";
  static const accountandsecurity = "Account & Security";
  static const changePassword = "Change Password";
  static const helpandsupportpage = "Help & Support";
  static const contactsupport = "Contact Support";
  static const restartalltracking = "Restart All Tracking";
  static const hapticFeedback = "Haptic Feedback";
  static const wakeUpTimeAsAlarm = "Wake-up Time as Alarm";
  static const ledFeedback = "LED Feedback";
  static const cupUnits = "Cup Units";
  static const weightUnit = "Weight Unit";
  static const heightUnit = "Height Unit";
  static const waterIntakeGoal = "Water Intake Goal";
  static const sipnudgebottle = "Sipnudge Bottle";
  static const dataAnalytics = "Data & Analytics";
  static const logout = "Logout";
  static const areYouSureYouWantToLogout = "Are you sure you want to logout?";
  static const cancel = "Cancel";
  static const confirm = "Confirm";
  static const yes = "Yes";
  static const no = "No";
  static const loggedOutSuccessfully = "Logged out successfully";
  static const newtonsingh = "Newton Singh";
  static const searchquestions = "Search questions...";
  static const question = "question";
  static const answer = "answer";
  static const noFaqDataAvailable = "No FAQ data available";
  static const selectReminderMode = "Select Reminder Mode";
  static const interval = "Interval";
  static const specificTimes = "Specific Times";
  static const reminderTime = "Reminder Time";
  static const aiDrivenSmartReminder = "AI-Driven Smart Reminder";
  static const predictiveHydration = "Predictive Hydration";
  static const adaptsToYourScheduleWeatherAndActivity =
      "Adapts to your schedule, weather, and activity";
  static const syncsWithGoogleCalender = "Syncs with Google Calendar";
  static const smartSnoozeAndPersonalizedTips =
      "Smart snooze and personalized tips";
  static const steadySipReminder = "Steady Sip Reminder";
  static const fixedIntervals = "Fixed intervals (e.g., every 2 hours)";
  static const simpleHydrationAlerts = "Simple hydration alerts";
  static const biomatricsID = "Biomatrics ID";
  static const faceID = "Face ID";
  static const downloadMyData = "Download My Data";
  static const requestaCopyOfYourDataYourInformationYourControl =
      "Request a copy of your data. Your information, your control.";
}
