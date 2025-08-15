// // reminder_time_bottom_sheet.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutterapp1/cubit/reminder_time_cubit.dart';
// import 'package:flutterapp1/widgets/cycleitemwidget.dart'; // <-- add this

// class ReminderTimeBottomSheet extends StatelessWidget {
//   ReminderTimeBottomSheet({super.key});

//   final List<String> intervals = const ["30 Minutes", "1 Hour", "2 Hours"];

//   @override
//   Widget build(BuildContext context) {
//     final selected = context.watch<ReminderTimeCubit>().state.selectedInterval;

//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: const BoxDecoration(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [Color(0xFF9B5DE5), Color(0xFF000000)],
//         ),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Reminder Time",
//                 style: TextStyle(
//                   fontFamily: 'Urbanist-SemiBold',
//                   fontSize: 24.sp,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.white,
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () => Navigator.pop(context),
//                 child: const Icon(Icons.close, color: Colors.white),
//               ),
//             ],
//           ),
//           SizedBox(height: 24.h),
//           Text(
//             "Select Sip Interval",
//             style: TextStyle(
//               fontFamily: 'Urbanist-SemiBold',
//               fontSize: 20.sp,
//               fontWeight: FontWeight.w600,
//               color: Colors.white,
//             ),
//           ),
//           SizedBox(height: 12.h),

//           // use CycleItem for each option
//           ...intervals.map((interval) {
//             final isSelected = interval == selected;
//             return CycleItem(
//               title: interval,
//               value: isSelected ? "Selected" : "Tap to Select",
//               onTap: () {
//                 context.read<ReminderTimeCubit>().updateInterval(interval);
//                 Navigator.pop(context);
//               },
//             );
//           }),
//         ],
//       ),
//     );
//   }
// }
