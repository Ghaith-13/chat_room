import 'package:flutter/material.dart';
import '../../core/styles/colors.dart';
import '../../core/styles/radius.dart';
import '../../core/styles/spacing.dart';
import '../text_field/search_text_field.dart';
import '../search_result_item.dart';

class ModalSearchDialog extends StatelessWidget {
  final TextEditingController? searchController;
  final Function(String)? onSearch;
  final VoidCallback? onClose;

  const ModalSearchDialog({
    Key? key,
    this.searchController,
    this.onSearch,
    this.onClose,
  }) : super(key: key);

  static Future<void> show(
    BuildContext context, {
    TextEditingController? searchController,
    Function(String)? onSearch,
    VoidCallback? onClose,
  }) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: ModalSearchDialog(
          searchController: searchController,
          onSearch: onSearch,
          onClose: onClose,
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
          // Search widget
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SearchTextField(
              controller: searchController,
              onChanged: onSearch,
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
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shrinkWrap: true,
                children: [
                  // May 2025 section
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'May 2025',
                      style: TextStyle(
                        color: AppColors.gray500,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  // Qwen models
                  SearchResultItem(
                    title: 'Qwen: Qwen3 0.6B',
                    imageUrl:
                        'https://i.namu.wiki/i/MIhJKlK5yVR3axxgE7_gHL-rsKjliShJKd3asUqg5KDdEsdOGut-9mCW4Ti1x7i2y8zCkxeZHQFR00sQg6BfYA.webp',
                    isFree: true,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),

                  SearchResultItem(
                    title: 'Inception: Mercury Coder Small Beta',
                    imageUrl: null, // Will show default icon
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),

                  SearchResultItem(
                    title: 'Qwen: Qwen3 1.7B',
                    imageUrl:
                        'https://i.namu.wiki/i/MIhJKlK5yVR3axxgE7_gHL-rsKjliShJKd3asUqg5KDdEsdOGut-9mCW4Ti1x7i2y8zCkxeZHQFR00sQg6BfYA.webp',
                    isFree: true,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),

                  SearchResultItem(
                    title: 'Qwen: Qwen3 4B',
                    imageUrl:
                        'https://i.namu.wiki/i/MIhJKlK5yVR3axxgE7_gHL-rsKjliShJKd3asUqg5KDdEsdOGut-9mCW4Ti1x7i2y8zCkxeZHQFR00sQg6BfYA.webp',
                    isFree: true,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),

                  // April 2025 section
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'April 2025',
                      style: TextStyle(
                        color: AppColors.gray500,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  SearchResultItem(
                    title: 'OpenGVLab: InternVL3 14B',
                    imageUrl: null,
                    isFree: true,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),

                  SearchResultItem(
                    title: 'OpenGVLab: InternVL3 2B',
                    imageUrl: null,
                    isFree: true,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),

                  SearchResultItem(
                    title: 'DeepSeek: DeepSeek Prover V2',
                    imageUrl: null,
                    isFree: true,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
