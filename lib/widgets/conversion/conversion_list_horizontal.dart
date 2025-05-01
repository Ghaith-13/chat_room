import 'package:flutter/material.dart';
import 'conversion_item.dart';

class ConversionListHorizontal extends StatelessWidget {
  final List<ConversionData> items;

  const ConversionListHorizontal({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = items[index];
          return SizedBox(
            width: 300,
            child: ConversionItem(
              title: item.title,
              subtitle: item.subtitle,
              onTap: item.onTap,
            ),
          );
        },
      ),
    );
  }
}

class ConversionData {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ConversionData({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
}
