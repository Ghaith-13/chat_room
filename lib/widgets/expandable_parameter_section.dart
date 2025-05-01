import 'package:flutter/material.dart';
import '../core/styles/colors.dart';
import 'slide/parameter_slider.dart';

class SliderParameter {
  final String label;
  final double value;
  final double min;
  final double max;
  final int? decimals;
  final Function(double) onChanged;

  SliderParameter({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.decimals,
  });
}

class ExpandableParameterSection extends StatefulWidget {
  final String title;
  final List<SliderParameter> parameters;

  const ExpandableParameterSection({
    Key? key,
    required this.title,
    required this.parameters,
  }) : super(key: key);

  @override
  State<ExpandableParameterSection> createState() =>
      _ExpandableParameterSectionState();
}

class _ExpandableParameterSectionState
    extends State<ExpandableParameterSection> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Transform.rotate(
                  angle: _isExpanded ? 3.14159 : 0,
                  child: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFF6B7280),
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Parameters
        if (_isExpanded) ...[
          const SizedBox(height: 8),
          ...widget.parameters
              .map((param) => Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: ParameterSlider(
                      label: param.label,
                      value: param.value,
                      min: param.min,
                      max: param.max,
                      decimals: param.decimals,
                      onChanged: param.onChanged,
                    ),
                  ))
              .toList(),
        ],
      ],
    );
  }
}
