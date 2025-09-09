import 'package:flutter/material.dart';

class CustomToggleSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final double width;
  final double height;
  final Duration duration;
  final Color activeTrackColor;
  final Color inactiveTrackColor;
  final Color thumbColor;

  const CustomToggleSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.width = 120,
    this.height = 68,
    this.duration = const Duration(milliseconds: 220),
    this.activeTrackColor = const Color(0xFF6C5CE7), // AppColors.violetBlue
    this.inactiveTrackColor = const Color(0xFF2F2F36), // AppColors.tuna
    this.thumbColor = Colors.white, // same for active/inactive
  }) : super(key: key);

  @override
  State<CustomToggleSwitch> createState() => _CustomToggleSwitch();
}

class _CustomToggleSwitch extends State<CustomToggleSwitch> {
  late double _thumbSize;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Thumb always same size
    _thumbSize = widget.height - 16;
  }

  @override
  Widget build(BuildContext context) {
    final isOn = widget.value;
    final horizontalInset = 8.0;
    final leftPosition = horizontalInset;
    final rightPosition = widget.width - _thumbSize - horizontalInset;

    return Semantics(
      container: true,
      button: true,
      toggled: isOn,
      child: GestureDetector(
        onTap: widget.onChanged == null ? null : () => widget.onChanged!(!isOn),
        child: AnimatedContainer(
          duration: widget.duration,
          width: widget.width,
          height: widget.height,
          padding: EdgeInsets.symmetric(horizontal: horizontalInset),
          decoration: BoxDecoration(
            color: isOn ? widget.activeTrackColor : widget.inactiveTrackColor,
            borderRadius: BorderRadius.circular(widget.height / 2),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // thumb (same for active/inactive)
              AnimatedPositioned(
                duration: widget.duration,
                curve: Curves.easeInOut,
                left: isOn ? rightPosition : leftPosition,
                top: (widget.height - _thumbSize) / 2,
                child: Container(
                  width: _thumbSize,
                  height: _thumbSize,
                  decoration: BoxDecoration(
                    color: widget.thumbColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFE6E6E8),
                      width: 1.6,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.22),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
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
