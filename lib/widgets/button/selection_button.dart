import 'package:flutter/material.dart';

class SelectionButtonData {
  final String imageUrl;
  final String text;
  final bool isFree;

  const SelectionButtonData({
    required this.imageUrl,
    required this.text,
    this.isFree = false,
  });
}

class SelectionButton extends StatelessWidget {
  final String label;
  final SelectionButtonData data;
  final VoidCallback onTap;
  final double? labelFontSize;
  final Color? labelColor;

  const SelectionButton({
    Key? key,
    required this.label,
    required this.data,
    required this.onTap,
    this.labelFontSize = 20,
    this.labelColor = const Color(0xFF6B7280),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                color: labelColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          child: Container(
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFFE5E7EB),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    image: data.imageUrl.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(data.imageUrl),
                            fit: BoxFit.cover,
                          )
                        : null,
                    color:
                        data.imageUrl.isEmpty ? const Color(0xFFF1F3F5) : null,
                  ),
                  child: data.imageUrl.isEmpty
                      ? const Icon(
                          Icons.auto_awesome,
                          size: 20,
                          color: Color(0xFF6B7280),
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    data.text + (data.isFree ? ' (free)' : ''),
                    style: const TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFF6B7280),
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
