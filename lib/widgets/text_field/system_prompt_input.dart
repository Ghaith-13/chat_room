import 'package:flutter/material.dart';
import '../../core/styles/colors.dart';

class SystemPromptInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Function(String)? onChanged;
  final int? maxLines;
  final double? height;

  const SystemPromptInput({
    Key? key,
    this.controller,
    this.hintText = 'System Prompt',
    this.onChanged,
    this.maxLines = 5,
    this.height = 120,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'System Prompt',
          style: TextStyle(
            color: AppColors.gray900,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.gray200,
              width: 1,
            ),
          ),
          padding: const EdgeInsets.all(3),
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: AppColors.gray400,
                fontSize: 14,
              ),
              contentPadding: const EdgeInsets.all(16),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            style: TextStyle(
              color: AppColors.gray900,
              fontSize: 14,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              '~0 tokens',
              style: TextStyle(
                color: AppColors.gray500,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
