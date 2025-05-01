import 'package:flutter/material.dart';
import '../core/styles/colors.dart';
import '../core/styles/radius.dart';

class SearchResultItem extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final IconData? icon;
  final bool isSelected;
  final bool isFree;
  final VoidCallback? onTap;

  const SearchResultItem({
    Key? key,
    required this.title,
    this.imageUrl,
    this.icon,
    this.isSelected = false,
    this.isFree = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.lgRadius,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.gray100 : Colors.transparent,
          borderRadius: AppRadius.lgRadius,
        ),
        child: Row(
          children: [
            // Icon or Image
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: AppRadius.mdRadius,
                color: AppColors.gray100,
              ),
              clipBehavior: Clip.antiAlias,
              child: imageUrl != null
                  ? Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.image_not_supported,
                          color: AppColors.gray400,
                          size: 20,
                        );
                      },
                    )
                  : Icon(
                      icon ?? Icons.extension,
                      color: AppColors.gray400,
                      size: 24,
                    ),
            ),
            const SizedBox(width: 12),

            // Title and Free text
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: title,
                            style: TextStyle(
                              color: AppColors.gray900,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (isFree)
                            TextSpan(
                              text: ' (free)',
                              style: TextStyle(
                                color: AppColors.gray900,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                        ],
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            // Selection indicator
            if (isSelected)
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.gray900,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
