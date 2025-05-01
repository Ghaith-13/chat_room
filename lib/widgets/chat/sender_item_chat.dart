import 'package:flutter/material.dart';
import '../../core/styles/colors.dart';

class SenderItemChat extends StatelessWidget {
  final String message;
  final String userName;
  final VoidCallback? onRegenerate;
  final VoidCallback? onCopy;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  final VoidCallback? onCode;

  const SenderItemChat({
    Key? key,
    required this.message,
    required this.userName,
    this.onRegenerate,
    this.onCopy,
    this.onDelete,
    this.onEdit,
    this.onCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              userName,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: AppColors.gray500,
              radius: 16,
              child: Text(
                userName[0].toLowerCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.8,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF4285F4),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (onRegenerate != null)
              _buildActionButton(
                icon: Icons.refresh,
                onTap: onRegenerate,
              ),
            if (onCopy != null)
              _buildActionButton(
                icon: Icons.copy_outlined,
                onTap: onCopy,
              ),
            if (onDelete != null)
              _buildActionButton(
                icon: Icons.delete_outline,
                onTap: onDelete,
              ),
            if (onEdit != null)
              _buildActionButton(
                icon: Icons.edit_outlined,
                onTap: onEdit,
              ),
            if (onCode != null)
              _buildActionButton(
                icon: Icons.code,
                onTap: onCode,
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(
            icon,
            size: 20,
            color: AppColors.gray600,
          ),
        ),
      ),
    );
  }
}
