import 'package:flutter/material.dart';

class ChartTabSelector extends StatefulWidget {
  final dynamic isChartActive;

  final dynamic onTabChanged;

  const ChartTabSelector({
    super.key,
    required this.isChartActive,
    required this.onTabChanged,
  });
  @override
  State<ChartTabSelector> createState() => _ChartTabSelectorState();
}

class _ChartTabSelectorState extends State<ChartTabSelector> {
  bool isChartActive = true;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _chartIcon(
          screenWidth: screenWidth,
          icon: Icons.bar_chart_rounded,
          isActive: isChartActive,
          onTap: () {
            setState(() => isChartActive = true);
          },
        ),
        const SizedBox(width: 8),
        _chartIcon(
          screenWidth: screenWidth,
          icon: Icons.insert_chart_outlined_rounded,
          isActive: !isChartActive,
          onTap: () {
            setState(() => isChartActive = false);
          },
        ),
      ],
    );
  }

  Widget _chartIcon({
    required double screenWidth,
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth * 0.23,
        height: screenWidth * 0.13 * 0.6,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF7C00FF) : const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(screenWidth * 0.035),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Stack(
            children: [
              Center(
                child: Icon(
                  icon,
                  color: isActive ? Colors.white : const Color(0xFF9D9D9D),
                  size: screenWidth * 0.06,
                ),
              ),
              if (!isActive)
                Positioned(
                  right: screenWidth * 0.025,
                  top: screenWidth * 0.012,
                  child: Container(
                    width: screenWidth * 0.018,
                    height: screenWidth * 0.018,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF7C00FF),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
