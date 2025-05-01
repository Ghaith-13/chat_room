import 'package:flutter/material.dart';
import '../../core/styles/colors.dart';

enum SortBy {
  default_,
  price,
  throughput,
}

class SortDialog extends StatelessWidget {
  final SortBy currentSort;
  final Function(SortBy) onSortSelected;

  const SortDialog({
    Key? key,
    required this.currentSort,
    required this.onSortSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SortBy>(
      offset: const Offset(0, 10),
      position: PopupMenuPosition.under,
      constraints: const BoxConstraints(minWidth: 180),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.white,
      elevation: 3,
      onSelected: onSortSelected,
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<SortBy>(
          enabled: false,
          height: 40,
          child: Text(
            'Sort By',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        _buildMenuItem('Default', SortBy.default_),
        _buildMenuItem('Price', SortBy.price),
        _buildMenuItem('Throughput', SortBy.throughput),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.gray200,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Sort By',
              style: TextStyle(
                color: AppColors.gray600,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.expand_more,
              size: 20,
              color: AppColors.gray600,
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<SortBy> _buildMenuItem(String title, SortBy value) {
    final isSelected = currentSort == value;
    return PopupMenuItem<SortBy>(
      value: value,
      height: 40,
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          if (isSelected)
            Icon(
              Icons.check,
              size: 20,
              color: Colors.black87,
            ),
        ],
      ),
    );
  }

  static Future<void> show(
    BuildContext context, {
    required SortBy currentSort,
    required Function(SortBy) onSortSelected,
  }) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: SortDialog(
          currentSort: currentSort,
          onSortSelected: onSortSelected,
        ),
      ),
    );
  }
}
