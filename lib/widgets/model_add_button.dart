import 'package:flutter/material.dart';

class ModelAddButton extends StatelessWidget {
  final VoidCallback onTap;
  final String? label;
  final IconData? icon;
  final String? shortcutKey;
  final EdgeInsetsGeometry? padding;

  const ModelAddButton({
    Key? key,
    required this.onTap,
    this.label = 'Add model',
    this.icon = Icons.add,
    this.shortcutKey = 'K',
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4.0),
        child: Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(4.0),
            color: Colors.transparent,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 18.0,
                color: Colors.grey[700],
              ),
              const SizedBox(width: 8.0),
              Text(
                label ?? 'Add model',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (shortcutKey != null) ...[
                const SizedBox(width: 8.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6.0, vertical: 1.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  child: Text(
                    shortcutKey!,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
