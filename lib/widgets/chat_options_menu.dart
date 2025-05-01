import 'package:flutter/material.dart';

class ChatOptionsMenu extends StatelessWidget {
  final Function()? onRename;
  final Function()? onDuplicate;
  final Function()? onDelete;

  const ChatOptionsMenu({
    super.key,
    this.onRename,
    this.onDuplicate,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOption(
            context,
            icon: Icons.edit_outlined,
            label: 'Rename',
            onTap: onRename,
            iconColor: Colors.grey[700],
          ),
          Divider(height: 1, thickness: 0.5, color: Colors.grey[100]),
          _buildOption(
            context,
            icon: Icons.copy_outlined,
            label: 'Duplicate',
            onTap: onDuplicate,
            iconColor: Colors.grey[700],
          ),
          Divider(height: 1, thickness: 0.5, color: Colors.grey[100]),
          _buildOption(
            context,
            icon: Icons.delete_outline,
            label: 'Delete',
            onTap: onDelete,
            iconColor: Colors.red,
            textColor: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Function()? onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Row(
          children: [
            Icon(icon, size: 18, color: iconColor),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color:
                    textColor ?? Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
