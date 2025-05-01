import 'package:flutter/material.dart';

enum CustomButtonVariant {
  primary,
  secondary,
  danger,
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final CustomButtonVariant variant;
  final bool isFullWidth;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.variant = CustomButtonVariant.primary,
    this.isFullWidth = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define styles based on variant
    Color backgroundColor;
    Color textColor;

    switch (variant) {
      case CustomButtonVariant.primary:
        backgroundColor = const Color(0xFFF8F9FA);
        textColor = const Color(0xFF1A1A1A);
        break;
      case CustomButtonVariant.secondary:
        backgroundColor = const Color(0xFFF8F9FA);
        textColor = const Color(0xFF1A1A1A);
        break;
      case CustomButtonVariant.danger:
        backgroundColor = const Color(0xFFEF4444);
        textColor = Colors.white;
        break;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Ink(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            width: isFullWidth ? double.infinity : null,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Example usage row widget
class ActionButtonsRow extends StatelessWidget {
  final VoidCallback onApplyToAll;
  final VoidCallback onReset;
  final VoidCallback onRemove;

  const ActionButtonsRow({
    Key? key,
    required this.onApplyToAll,
    required this.onReset,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomButton(
          text: 'Apply to All',
          onPressed: onApplyToAll,
          variant: CustomButtonVariant.primary,
        ),
        const SizedBox(width: 8),
        CustomButton(
          text: 'Reset',
          onPressed: onReset,
          variant: CustomButtonVariant.secondary,
        ),
        const SizedBox(width: 8),
        CustomButton(
          text: 'Remove',
          onPressed: onRemove,
          variant: CustomButtonVariant.danger,
        ),
      ],
    );
  }
}
