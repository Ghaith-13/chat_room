import 'package:flutter/material.dart';
import '../core/styles/colors.dart';

class ParameterSlider extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final int? decimals;
  final Function(double) onChanged;

  const ParameterSlider({
    Key? key,
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.decimals,
  }) : super(key: key);

  String get formattedValue {
    if (decimals != null) {
      return value.toStringAsFixed(decimals!);
    }
    return value.round().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label and Value
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: AppColors.gray900,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: AppColors.gray100,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                formattedValue,
                style: TextStyle(
                  color: AppColors.gray900,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Slider
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 8,
            activeTrackColor: AppColors.gray200,
            inactiveTrackColor: AppColors.gray200,
            thumbColor: AppColors.white,
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 8,
              elevation: 2,
            ),
            overlayColor: AppColors.gray200.withOpacity(0.2),
            overlayShape: const RoundSliderOverlayShape(
              overlayRadius: 16,
            ),
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
