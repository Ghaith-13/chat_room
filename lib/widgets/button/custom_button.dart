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
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.variant = CustomButtonVariant.primary,
    this.isFullWidth = false,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define styles based on variant
    Color defaultBackgroundColor;
    Color defaultTextColor;

    switch (variant) {
      case CustomButtonVariant.primary:
        defaultBackgroundColor = const Color(0xFFF8F9FA);
        defaultTextColor = const Color(0xFF1A1A1A);
        break;
      case CustomButtonVariant.secondary:
        defaultBackgroundColor = const Color(0xFFF8F9FA);
        defaultTextColor = const Color(0xFF1A1A1A);
        break;
      case CustomButtonVariant.danger:
        defaultBackgroundColor = const Color(0xFFEF4444);
        defaultTextColor = Colors.white;
        break;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Ink(
          decoration: BoxDecoration(
            color: backgroundColor ?? defaultBackgroundColor,
            borderRadius: BorderRadius.circular(8),
            border:
                borderColor != null ? Border.all(color: borderColor!) : null,
          ),
          child: Container(
            width: isFullWidth ? double.infinity : null,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor ?? defaultTextColor,
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
