import 'package:flutter/material.dart';
import '../../core/styles/colors.dart';
import '../../core/styles/radius.dart';
import '../../core/styles/spacing.dart';
import '../text_field/search_text_field.dart';
import '../search_result_item.dart';

class SearchDialogItem {
  final String title;
  final String? subtitle;
  final String? imageUrl;
  final IconData? icon;
  final Map<String, dynamic>? additionalData;
  final bool isSelected;
  final String? group;

  const SearchDialogItem({
    required this.title,
    this.subtitle,
    this.imageUrl,
    this.icon,
    this.additionalData,
    this.isSelected = false,
    this.group,
  });
}

class SearchDialog extends StatelessWidget {
  final String title;
  final TextEditingController? searchController;
  final Function(String)? onSearch;
  final VoidCallback? onClose;
  final List<SearchDialogItem> items;
  final Function(SearchDialogItem) onItemSelected;
  final String? hintText;
  final Widget Function(SearchDialogItem)? itemBuilder;
  final double? maxHeight;
  final double? maxWidth;
  final EdgeInsets? contentPadding;
  final bool showDivider;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final bool showSearchLabel;

  const SearchDialog({
    Key? key,
    required this.title,
    this.searchController,
    this.onSearch,
    this.onClose,
    required this.items,
    required this.onItemSelected,
    this.hintText,
    this.itemBuilder,
    this.maxHeight,
    this.maxWidth = 600,
    this.contentPadding,
    this.showDivider = true,
    this.backgroundColor,
    this.borderRadius,
    this.showSearchLabel = false,
  }) : super(key: key);

  static Future<void> show(
    BuildContext context, {
    required String title,
    TextEditingController? searchController,
    Function(String)? onSearch,
    VoidCallback? onClose,
    required List<SearchDialogItem> items,
    required Function(SearchDialogItem) onItemSelected,
    String? hintText,
    Widget Function(SearchDialogItem)? itemBuilder,
    double? maxHeight,
    double? maxWidth,
    EdgeInsets? contentPadding,
    bool showDivider = true,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    bool showSearchLabel = false,
  }) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: SearchDialog(
          title: title,
          searchController: searchController,
          onSearch: onSearch,
          onClose: onClose,
          items: items,
          onItemSelected: onItemSelected,
          hintText: hintText,
          itemBuilder: itemBuilder,
          maxHeight: maxHeight,
          maxWidth: maxWidth,
          contentPadding: contentPadding,
          showDivider: showDivider,
          backgroundColor: backgroundColor,
          borderRadius: borderRadius,
          showSearchLabel: showSearchLabel,
        ),
      ),
    );
  }

  Widget _buildGroupedItems(BuildContext context) {
    final groups = <String, List<SearchDialogItem>>{};
    for (var item in items) {
      final group = item.group ?? '';
      if (!groups.containsKey(group)) {
        groups[group] = [];
      }
      groups[group]!.add(item);
    }

    final children = <Widget>[];
    groups.forEach((group, groupItems) {
      if (group.isNotEmpty) {
        children.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              group,
              style: TextStyle(
                color: AppColors.gray500,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }

      children.addAll(
        groupItems.map((item) =>
            itemBuilder?.call(item) ??
            SearchResultItem(
              title: item.title,
              imageUrl: item.imageUrl,
              icon: item.icon,
              isFree: item.additionalData?['isFree'] ?? false,
              isSelected: item.isSelected,
              onTap: () {
                onItemSelected(item);
                Navigator.of(context).pop();
              },
            )),
      );
    });

    return ListView(
      padding: contentPadding ??
          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shrinkWrap: true,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: maxHeight ?? MediaQuery.of(context).size.height * 0.8,
        maxWidth: maxWidth ?? 600,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.white,
        borderRadius: borderRadius ?? AppRadius.lgRadius,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showSearchLabel)
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          Padding(
            padding: EdgeInsets.only(
              top: showSearchLabel ? 0 : 10,
              left: 16,
              right: 16,
            ),
            child: SearchTextField(
              controller: searchController,
              onChanged: onSearch,
              hintText: hintText ?? 'Search $title',
            ),
          ),
          if (showDivider)
            Divider(
              height: 1,
              thickness: 1,
              color: AppColors.gray200,
            ),
          Flexible(
            child: Container(
              constraints: BoxConstraints(maxHeight: maxHeight ?? 400),
              child: _buildGroupedItems(context),
            ),
          ),
        ],
      ),
    );
  }
}
