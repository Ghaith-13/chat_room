import 'package:flutter/material.dart';
import '../core/styles/colors.dart';
import '../core/styles/radius.dart';
import 'search_text_field.dart';
import 'search_result_item.dart';

class ProviderSearchDialog extends StatelessWidget {
  final TextEditingController? searchController;
  final Function(String)? onSearch;
  final VoidCallback? onClose;
  final String selectedProvider;
  final Function(String) onProviderSelected;

  const ProviderSearchDialog({
    Key? key,
    this.searchController,
    this.onSearch,
    this.onClose,
    required this.selectedProvider,
    required this.onProviderSelected,
  }) : super(key: key);

  static Future<void> show(
    BuildContext context, {
    TextEditingController? searchController,
    Function(String)? onSearch,
    VoidCallback? onClose,
    required String selectedProvider,
    required Function(String) onProviderSelected,
  }) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: ProviderSearchDialog(
          searchController: searchController,
          onSearch: onSearch,
          onClose: onClose,
          selectedProvider: selectedProvider,
          onProviderSelected: onProviderSelected,
        ),
      ),
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
          // Search widget with label
          SearchTextField(
            controller: searchController,
            onChanged: onSearch,
            hintText: 'Search providers',
          ),

          // Divider
          Divider(
            height: 1,
            thickness: 1,
            color: AppColors.gray200,
          ),

          // Provider list
          Flexible(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              shrinkWrap: true,
              children: [
                SearchResultItem(
                  title: 'Auto',
                  icon: Icons.auto_awesome,
                  isSelected: selectedProvider == 'Auto',
                  onTap: () {
                    onProviderSelected('Auto');
                    Navigator.of(context).pop();
                  },
                ),
                SearchResultItem(
                  title: 'Chutes',
                  icon: Icons.rocket_launch,
                  isSelected: selectedProvider == 'Chutes',
                  onTap: () {
                    onProviderSelected('Chutes');
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
