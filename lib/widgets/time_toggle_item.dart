// import 'package:flutter/material.dart';

// class TimeToggleItem extends StatelessWidget {
//   final String time;
//   final bool isActive;
//   final VoidCallback onToggle;

//   const TimeToggleItem({
//     Key? key,
//     required this.time,
//     required this.isActive,
//     required this.onToggle,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 6),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(24),
//         color: Colors.purple.withOpacity(0.25),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.3),
//             offset: Offset(0, 2),
//             blurRadius: 4,
//           ),
//         ],
//       ),
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             time,
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//           Switch(
//             value: isActive,
//             onChanged: (_) => onToggle(),
//             activeColor: Colors.white,
//             activeTrackColor: Colors.purpleAccent,
//             inactiveThumbColor: Colors.white,
//             inactiveTrackColor: Colors.grey.shade600,
//           ),
//         ],
//       ),
//     );
//   }
// }
