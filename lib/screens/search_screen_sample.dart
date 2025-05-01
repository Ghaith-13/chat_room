import 'package:flutter/material.dart';
import '../core/styles/colors.dart';
import '../widgets/search_dialog/modal_search_dialog.dart';
import '../widgets/dialog/sort_dialog.dart';
import '../widgets/text_field/system_prompt_input.dart';
import '../widgets/text_field/name_input_row.dart';
import '../widgets/expandable_parameter_section.dart';
import '../widgets/button/custom_button.dart';
import '../widgets/button/selection_button.dart';
import '../widgets/search_dialog/provider_search_dialog.dart';
import '../widgets/add_model_dialog/add_model_dialog.dart';
import '../widgets/add_model_button.dart';
import '../widgets/conversion/conversion_list_horizontal.dart';

class SearchScreenSample extends StatefulWidget {
  const SearchScreenSample({Key? key}) : super(key: key);

  @override
  State<SearchScreenSample> createState() => _SearchScreenSampleState();
}

class _SearchScreenSampleState extends State<SearchScreenSample> {
  SortBy _currentSort = SortBy.default_;
  final TextEditingController _promptController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _isNameEnabled = false;

  // Add state variables for parameters
  double _maxTokens = 0;
  double _temperature = 0.7;
  double _topP = 0.9;

  // State for model selection
  SelectionButtonData _selectedModel = const SelectionButtonData(
    imageUrl:
        'https://i.namu.wiki/i/MIhJKlK5yVR3axxgE7_gHL-rsKjliShJKd3asUqg5KDdEsdOGut-9mCW4Ti1x7i2y8zCkxeZHQFR00sQg6BfYA.webp',
    text: 'Microsoft: MAI DS R1',
    isFree: true,
  );

  // State for provider selection
  SelectionButtonData _selectedProvider = const SelectionButtonData(
    imageUrl: '', // Empty for default icon
    text: 'Auto',
    isFree: false,
  );

  final List<ConversionData> conversions = [
    ConversionData(
      title: 'Educational Advertisement',
      subtitle: 'Plan for higher education marketing',
      onTap: () => print('Educational ad tapped'),
    ),
    ConversionData(
      title: 'Business Strategy',
      subtitle: 'Develop growth and expansion plans',
      onTap: () => print('Business strategy tapped'),
    ),
    ConversionData(
      title: 'Marketing Campaign',
      subtitle: 'Create social media marketing strategy',
      onTap: () => print('Marketing campaign tapped'),
    ),
    ConversionData(
      title: 'Product Launch',
      subtitle: 'Plan new product launch timeline',
      onTap: () => print('Product launch tapped'),
    ),
  ];

  void _showSearchDialog(BuildContext context) {
    final searchController = TextEditingController();

    ModalSearchDialog.show(
      context,
      searchController: searchController,
      onSearch: (query) {
        // Handle search query
        print('Searching for: $query');
      },
      onClose: () {
        // Handle dialog close
        print('Dialog closed');
      },
    );
  }

  void _showAddModelDialog(BuildContext context) {
    final nameController = TextEditingController();
    final promptController = TextEditingController();

    AddModelDialog.show(
      context,
      nameController: nameController,
      promptController: promptController,
      onSave: (name, prompt, maxTokens, temperature, topP) {
        // Handle saving the new model
        print('Saving model: $name');
      },
      onClose: () {
        // Handle dialog close
        print('Dialog closed');
      },
    );
  }

  void _handleKeyboardShortcut() {
    // Implement keyboard shortcut functionality
    _showAddModelDialog(context);
  }

  void _handleSettings() {
    // Implement settings functionality
    print('Opening settings...');
  }

  @override
  void dispose() {
    _promptController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Model Settings'),
            backgroundColor: AppColors.white,
            elevation: 0,
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AddModelButton(
                    onAddTap: () => _showAddModelDialog(context),
                  ),
                  const SizedBox(height: 24),
                  ConversionListHorizontal(items: conversions),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
