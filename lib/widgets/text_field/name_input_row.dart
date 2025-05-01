import 'package:flutter/material.dart';
import '../../core/styles/colors.dart';

class NameInputRow extends StatelessWidget {
  final String imageUrl;
  final bool isEnabled;
  final Function(bool)? onToggleChanged;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  const NameInputRow({
    Key? key,
    required this.imageUrl,
    this.isEnabled = false,
    this.onToggleChanged,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Circle Image
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.network(
              imageUrl,
              width: 32,
              height: 32,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Text Input
        Expanded(
          child: Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.gray100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              decoration: const InputDecoration(
                  hintText: 'Name',
                  hintStyle: TextStyle(
                    color: Color(0xFF868E96),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  fillColor: AppColors.gray100),
              style: const TextStyle(
                color: Color(0xFF1A1A1A),
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        // Toggle Switch
        Transform.scale(
          scale: 0.8,
          child: Switch(
            value: isEnabled,
            onChanged: onToggleChanged,
            activeColor: Colors.white,
            activeTrackColor: const Color(0xFF6366F1),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: const Color(0xFFDEE2E6),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ],
    );
  }
}
