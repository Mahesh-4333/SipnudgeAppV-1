import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalInfoApp extends StatelessWidget {
  const PersonalInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => const MaterialApp(
        home: PersonalInfoPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  String selectedGender = 'Male';
  String heightUnit = 'in';
  String weightUnit = 'kg';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFB586BE), Color(0xFF131313)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 25.h),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: Offset(4.w, 4.h),
                  blurRadius: 4.r,
                  color: const Color(0x40000000),
                ),
              ],
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB889D2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 20.h),
                elevation: 0,
              ),
              child: Text(
                "Next",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                  fontFamily: 'Urbanist-SemiBold',
                  shadows: const [
                    Shadow(
                      offset: Offset(0, 4),
                      blurRadius: 10,
                      color: Color(0x40000000),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Text(
                    'Personal Information',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontFamily: 'Urbanist-ExtraBold',
                      color: Colors.white,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildLabel("What's your gender?"),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        genderButton('Male'),
                        SizedBox(width: 10.w),
                        genderButton('Female'),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    genderButton('Prefer not to say', width: 180.w),
                  ],
                ),
                buildInputWithUnit(
                  label: "How tall are you?",
                  hint: 'Enter your height',
                  unit1: "in",
                  unit2: "cm",
                  selectedUnit: heightUnit,
                  onUnitChanged: (val) => setState(() => heightUnit = val),
                ),
                buildInputWithUnit(
                  label: "How much do you weigh?",
                  hint: 'Enter your weight',
                  unit1: "kg",
                  unit2: "lbs",
                  selectedUnit: weightUnit,
                  onUnitChanged: (val) => setState(() => weightUnit = val),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildLabel("What's your age?"),
                    SizedBox(height: 8.h),
                    buildInputField(hint: "Enter your age", suffix: "in years"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLabel(String text) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontFamily: 'Urbanist-SemiBold',
          shadows: const [
            Shadow(
              offset: Offset(0, 4),
              blurRadius: 6,
              color: Color(0x40000000),
            )
          ],
        ),
      ),
    );
  }

  Widget genderButton(String gender, {double? width}) {
    bool isSelected = selectedGender == gender;
    String? genderImage;

    if (gender == 'Male') genderImage = 'assets/male.png';
    if (gender == 'Female') genderImage = 'assets/female.png';

    return Container(
      width: width ?? 180.w,
      height: 92.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: const [
          BoxShadow(offset: Offset(4, 4), blurRadius: 4, color: Color(0x40000000)),
        ],
      ),
      child: ElevatedButton(
        onPressed: () => setState(() => selectedGender = gender),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          padding: EdgeInsets.zero,
          backgroundColor: isSelected ? const Color(0xFF59386C) : const Color(0xFF735E7F),
          side: BorderSide(
            color: isSelected ? const Color(0xFFB889D2) : const Color(0xFF9982A6),
            width: isSelected ? 3.w : 1.w,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 16.h,
              left: 16.w,
              child: Text(
                gender,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                  fontFamily: 'Urbanist-Medium',
                ),
              ),
            ),
            if (genderImage != null)
              Positioned(
                bottom: 10.h,
                right: 14.w,
                child: Image.asset(
                  genderImage,
                  color: const Color(0xFFC7A2DC),
                  width: 24.w,
                  height: 28.h,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildInputWithUnit({
    required String label,
    required String hint,
    required String unit1,
    required String unit2,
    required String selectedUnit,
    required Function(String) onUnitChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildLabel(label),
        SizedBox(height: 20.h),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(color: Color(0x40000000), blurRadius: 4, offset: Offset(0, 4)),
                  ],
                  borderRadius: BorderRadius.circular(50.r),
                  border: Border.all(color: const Color(0xFF9982A6), width: 1),
                ),
                child: buildInputField(hint: hint),
              ),
            ),
            SizedBox(width: 16.w),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF735E7F),
                borderRadius: BorderRadius.circular(50.r),
                border: Border.all(color: const Color(0xFF9982A6), width: 1),
                boxShadow: const [
                  BoxShadow(offset: Offset(4, 4), blurRadius: 4, color: Color(0x40000000)),
                ],
              ),
              child: Row(
                children: [unit1, unit2].map((unit) {
                  bool isSelected = selectedUnit == unit;
                  return GestureDetector(
                    onTap: () => onUnitChanged(unit),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFC7A2DC) : Colors.transparent,
                        borderRadius: BorderRadius.circular(360.r),
                      ),
                      child: Text(
                        unit,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildInputField({required String hint, String? suffix}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF735E7F),
        borderRadius: BorderRadius.circular(50.r),
        boxShadow: const [
          BoxShadow(color: Color(0x40000000), blurRadius: 6, offset: Offset(4, 4)),
        ],
      ),
      child: TextField(
        style: TextStyle(color: Colors.white, fontSize: 16.sp),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(fontSize: 16.sp, color: Colors.white.withOpacity(0.5)),
          suffixText: suffix,
          suffixStyle: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 16.sp),
          filled: true,
          fillColor: const Color(0xFF735E7F),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.r),
            borderSide: const BorderSide(color: Color(0xFF9982A6), width: 1),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        ),
      ),
    );
  }
}
