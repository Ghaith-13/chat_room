import 'package:flutter/material.dart';
import '../core/styles/colors.dart';
import '../core/styles/radius.dart';
import 'search_text_field.dart';
import 'search_result_item.dart';

enum SearchDialogType {
  model,
  provider,
}

class SearchDialogItem {
  final String title;
  final String? imageUrl;
  final IconData? icon;
  final bool isFree;
  final bool isSelected;
  final String? group;

  const SearchDialogItem({
    required this.title,
    this.imageUrl,
    this.icon,
    this.isFree = false,
    this.isSelected = false,
    this.group,
  });
}

class SearchDialog extends StatelessWidget {
  final SearchDialogType type;
  final TextEditingController? searchController;
  final Function(String)? onSearch;
  final VoidCallback? onClose;
  final List<SearchDialogItem> items;
  final Function(SearchDialogItem) onItemSelected;
  final String? hintText;

  const SearchDialog({
    Key? key,
    required this.type,
    this.searchController,
    this.onSearch,
    this.onClose,
    required this.items,
    required this.onItemSelected,
    this.hintText,
  }) : super(key: key);

  static Future<void> show(
    BuildContext context, {
    required SearchDialogType type,
    TextEditingController? searchController,
    Function(String)? onSearch,
    VoidCallback? onClose,
    required List<SearchDialogItem> items,
    required Function(SearchDialogItem) onItemSelected,
    String? hintText,
  }) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: SearchDialog(
          type: type,
          searchController: searchController,
          onSearch: onSearch,
          onClose: onClose,
          items: items,
          onItemSelected: onItemSelected,
          hintText: hintText,
        ),
      ),
    );
  }

  Widget _buildGroupedItems(BuildContext context) {
    // Group items by their group property
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
        groupItems.map((item) => SearchResultItem(
              title: item.title,
              imageUrl: item.imageUrl,
              icon: item.icon,
              isFree: item.isFree,
              isSelected: item.isSelected,
              onTap: () {
                onItemSelected(item);
                Navigator.of(context).pop();
              },
            )),
      );
    });

    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: type == SearchDialogType.provider ? 8 : 0,
      ),
      shrinkWrap: true,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
        maxWidth: 600,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppRadius.lgRadius,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search widget
          Padding(
            padding: EdgeInsets.only(
              top: type == SearchDialogType.provider ? 0 : 10,
            ),
            child: SearchTextField(
              controller: searchController,
              onChanged: onSearch,
              hintText: hintText ??
                  (type == SearchDialogType.model
                      ? 'Search models'
                      : 'Search providers'),
            ),
          ),

          // Divider
          Divider(
            height: 1,
            thickness: 1,
            color: AppColors.gray200,
          ),

          // Content area
          Flexible(
            child: Container(
              constraints: const BoxConstraints(maxHeight: 400),
              child: _buildGroupedItems(context),
            ),
          ),
        ],
      ),
    );
  }
}
