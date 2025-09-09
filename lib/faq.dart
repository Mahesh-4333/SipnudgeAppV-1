// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutterapp1/constants/app_colors.dart';
// import 'package:flutterapp1/constants/app_dimensions.dart';
// import 'package:flutterapp1/constants/app_font_styles.dart';
// import 'package:flutterapp1/helpers/navigation_helper.dart';
// import 'package:flutterapp1/widgets/level_widgets/bottom_nav_bar.dart';

// class FAQ_Page extends StatefulWidget {
//   const FAQ_Page({super.key});

//   @override
//   State<FAQ_Page> createState() => _FAQ_PageState();
// }

// class _FAQ_PageState extends State<FAQ_Page>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   final TextEditingController _searchController = TextEditingController();
//   String selected = 'General';

//   Map<String, List<Map<String, String>>> faqData = {
//     'General': [
//       {
//         'question': 'What is Sipnudge?',
//         'answer':
//             'Sipnudge is a smart hydration bottle designed to help you stay properly hydrated throughout the day...',
//       },
//       {
//         'question': 'What makes SipNudge different from other water bottles?',
//         'answer':
//             'Unlike regular water bottles, SipNudge actively encourages you to drink through personalized reminders...',
//       },
//     ],
//     // Other categories...
//   };

//   // Track expansion state
//   Map<String, List<bool>> isExpandedMap = {};

//   final List<String> allFAQs = [
//     "How to use SipNudge?",
//     "How to clean the bottle?",
//     "Battery life of the device?",
//   ];

//   List<String> filteredFAQs = [];

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(vsync: this);

//     for (var key in faqData.keys) {
//       isExpandedMap[key] = List.generate(faqData[key]!.length, (_) => false);
//     }
//     filteredFAQs = List.from(allFAQs);

//     _searchController.addListener(() {
//       filterSearchResults(_searchController.text);
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void filterSearchResults(String query) {
//     setState(() {
//       if (query.isEmpty) {
//         filteredFAQs = List.from(allFAQs);
//       } else {
//         filteredFAQs =
//             allFAQs
//                 .where((faq) => faq.toLowerCase().contains(query.toLowerCase()))
//                 .toList();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [AppColors.gradientStart, AppColors.gradientEnd],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               Expanded(
//                 child: SingleChildScrollView(
//                   physics: const BouncingScrollPhysics(),
//                   child: Padding(
//                     padding: EdgeInsets.only(bottom: AppDimensions.dim20.h),
//                     child: Column(
//                       children: [
//                         /// Header
//                         Padding(
//                           padding: EdgeInsets.only(
//                             top: AppDimensions.dim50.h,
//                             left: AppDimensions.dim24.w,
//                             right: AppDimensions.dim20.w,
//                           ),
//                           child: Row(
//                             children: [
//                               SizedBox(
//                                 width: AppDimensions.dim40.w,
//                                 height: AppDimensions.dim40.h,
//                                 child: IconButton(
//                                   onPressed: () => Navigator.pop(context),
//                                   icon: Icon(
//                                     Icons.arrow_back,
//                                     color: AppColors.raisinblack,
//                                     size: AppFontStyles.fontSize_30.sp,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: AppDimensions.dim120.w),
//                               Text(
//                                 'FAQ',
//                                 style: TextStyle(
//                                   color: AppColors.white,
//                                   fontSize: AppFontStyles.fontSize_24.sp,
//                                   fontFamily: AppFontStyles.urbanistFontFamily,
//                                   fontVariations: [
//                                     AppFontStyles.boldFontVariation,
//                                   ],
//                                   //fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),

//                         SizedBox(height: AppDimensions.dim24.h),

//                         /// Search Box
//                         Container(
//                           width: AppDimensions.dim380.w,
//                           height: AppDimensions.dim65.h,
//                           padding: EdgeInsets.symmetric(
//                             horizontal: AppDimensions.dim20.w,
//                           ),
//                           decoration: BoxDecoration(
//                             color: AppColors.white,
//                             borderRadius: BorderRadius.circular(40.r),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: AppColors.black.withOpacity(0.25),
//                                 offset: Offset(
//                                   AppDimensions.radius_4.r,
//                                   AppDimensions.radius_4.r,
//                                 ),
//                                 blurRadius: AppDimensions.radius_4.r,
//                               ),
//                             ],
//                           ),
//                           child: Row(
//                             children: [
//                               Image.asset(
//                                 'assets/searchicon.png',
//                                 width: AppDimensions.dim16.w,
//                                 height: AppDimensions.dim16.h,
//                                 color: const Color(0xFFBDBDBD),
//                               ),
//                               SizedBox(width: AppDimensions.dim12.w),
//                               Expanded(
//                                 child: TextField(
//                                   controller: _searchController,
//                                   onChanged: filterSearchResults,
//                                   decoration: InputDecoration(
//                                     hintText: 'Search',
//                                     hintStyle: TextStyle(
//                                       fontFamily:
//                                           AppFontStyles.urbanistFontFamily,
//                                       fontVariations: [
//                                         AppFontStyles.regularFontVariation,
//                                       ],
//                                       //fontWeight: FontWeight.w400,
//                                       color: const Color(0xFFBDBDBD),
//                                       fontSize: AppFontStyles.fontSize_18.sp,
//                                       letterSpacing: 0.2.sp,
//                                     ),
//                                     border: InputBorder.none,
//                                     suffixIcon:
//                                         _searchController.text.isNotEmpty
//                                             ? IconButton(
//                                               icon: const Icon(
//                                                 Icons.clear,
//                                                 color: Colors.grey,
//                                               ),
//                                               onPressed: () {
//                                                 _searchController.clear();
//                                                 filterSearchResults('');
//                                               },
//                                             )
//                                             : null,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),

//                         SizedBox(height: AppDimensions.dim24.h),

//                         /// Category Selector
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 24.w),
//                           child: SingleChildScrollView(
//                             scrollDirection: Axis.horizontal,
//                             child: Row(
//                               children: [
//                                 _buildToggleButton('General'),
//                                 SizedBox(width: AppDimensions.dim12.w),
//                                 _buildToggleButton('Usage'),
//                                 SizedBox(width: AppDimensions.dim12.w),
//                                 _buildToggleButton('App'),
//                                 SizedBox(width: AppDimensions.dim12.w),
//                                 _buildToggleButton('Tracking'),
//                                 SizedBox(width: AppDimensions.dim12.w),
//                                 _buildToggleButton('Troubleshooting'),
//                                 SizedBox(width: AppDimensions.dim12.w),
//                                 _buildToggleButton('Support'),
//                               ],
//                             ),
//                           ),
//                         ),

//                         SizedBox(height: 24.h),

//                         /// FAQ Items
//                         Column(
//                           children: List.generate(faqData[selected]!.length, (
//                             index,
//                           ) {
//                             final question =
//                                 faqData[selected]![index]['question']!;
//                             final answer = faqData[selected]![index]['answer']!;
//                             final isExpanded = isExpandedMap[selected]![index];

//                             return Column(
//                               children: [
//                                 Container(
//                                   width: AppDimensions.dim380.w,
//                                   padding: EdgeInsets.all(
//                                     AppDimensions.dim20.w,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: const Color(0xFF735E7F),
//                                     borderRadius: BorderRadius.circular(
//                                       AppDimensions.radius_16.r,
//                                     ),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: AppColors.black.withOpacity(
//                                           0.25,
//                                         ),
//                                         blurRadius: AppDimensions.radius_4.r,
//                                         offset: Offset(
//                                           AppDimensions.radius_4.r,
//                                           AppDimensions.radius_4.r,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Text(
//                                               question,
//                                               style: TextStyle(
//                                                 fontFamily:
//                                                     AppFontStyles
//                                                         .urbanistFontFamily,
//                                                 fontVariations: [
//                                                   AppFontStyles
//                                                       .fontWeightVariation600,
//                                                 ],
//                                                 fontSize:
//                                                     AppFontStyles
//                                                         .fontSize_18
//                                                         .sp,
//                                                 color: AppColors.white,
//                                               ),
//                                             ),
//                                           ),
//                                           GestureDetector(
//                                             onTap: () {
//                                               setState(() {
//                                                 isExpandedMap[selected]![index] =
//                                                     !isExpandedMap[selected]![index];
//                                               });
//                                             },
//                                             child: Icon(
//                                               isExpanded
//                                                   ? Icons.expand_less
//                                                   : Icons.expand_more,
//                                               color: AppColors.white,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(height: AppDimensions.dim10.h),
//                                       if (isExpanded) ...[
//                                         const Divider(color: AppColors.white),
//                                         SizedBox(height: AppDimensions.dim10.h),
//                                         Text(
//                                           answer,
//                                           style: TextStyle(
//                                             fontFamily:
//                                                 AppFontStyles
//                                                     .urbanistFontFamily,
//                                             fontVariations: [
//                                               AppFontStyles
//                                                   .semiBoldFontVariation,
//                                             ],
//                                             fontSize:
//                                                 AppFontStyles.fontSize_16.sp,
//                                             color: AppColors.white,
//                                             letterSpacing: 0.2.sp,
//                                             height: 1.5,
//                                           ),
//                                         ),
//                                       ],
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(height: AppDimensions.dim20.h),
//                               ],
//                             );
//                           }),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),

//               /// Bottom Navigation
//               Padding(
//                 padding: EdgeInsets.only(
//                   left: AppDimensions.dim6.w,
//                   right: AppDimensions.dim6.w,
//                   bottom: AppDimensions.dim6.h,
//                 ),
//                 child: CustomBottomNavBar(
//                   activeTab: 'Home',
//                   onTabSelected: (label) {
//                     NavigationHelper.navigate(context, label);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildToggleButton(String label) {
//     final bool isSelected = selected == label;

//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selected = label;
//         });
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(
//           horizontal: AppDimensions.dim28.w,
//           vertical: AppDimensions.dim12.h,
//         ),
//         decoration: BoxDecoration(
//           color: isSelected ? const Color(0xFF369FFF) : Colors.transparent,
//           borderRadius: BorderRadius.circular(30.r),
//           border:
//               isSelected
//                   ? null
//                   : Border.all(
//                     color: AppColors.white,
//                     width: AppDimensions.dim1.w,
//                   ),
//         ),
//         child: Text(
//           label,
//           style: TextStyle(
//             fontSize: AppFontStyles.fontSize_16.sp,
//             color: AppColors.white,
//             fontFamily: AppFontStyles.urbanistFontFamily,
//             fontVariations: [AppFontStyles.fontWeightVariation600],
//             letterSpacing: 0.2.sp,
//           ),
//         ),
//       ),
//     );
//   }
// }
