import 'package:flutter/material.dart';
import '../core/styles/colors.dart';
import '../widgets/modal_search_dialog.dart';
import '../widgets/sort_dialog.dart';
import '../widgets/system_prompt_input.dart';
import '../widgets/name_input_row.dart';
import '../widgets/expandable_parameter_section.dart';
import '../widgets/custom_button.dart';
import '../widgets/selection_button.dart';
import '../widgets/provider_search_dialog.dart';
import '../widgets/add_model_dialog.dart';

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

  @override
  void dispose() {
    _promptController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Model Settings'),
        backgroundColor: AppColors.white,
        elevation: 0,
        actions: [
          // Add Model Button
          IconButton(
            onPressed: () => _showAddModelDialog(context),
            icon: const Icon(
              Icons.add_circle_outline,
              color: Color(0xFF6B7280),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Top section with white background
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 8),
                // Model selection
                SelectionButton(
                  label: 'Model',
                  data: _selectedModel,
                  onTap: () => _showSearchDialog(context),
                ),
                const SizedBox(height: 24),
                // Provider selection
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: SelectionButton(
                        label: 'Provider',
                        data: _selectedProvider,
                        onTap: () {
                          ProviderSearchDialog.show(
                            context,
                            selectedProvider: _selectedProvider.text,
                            onProviderSelected: (provider) {
                              setState(() {
                                _selectedProvider = SelectionButtonData(
                                  imageUrl: '', // Empty for default icon
                                  text: provider,
                                  isFree: false,
                                );
                              });
                            },
                          );
                        },
                      ),
                    ),
                    SortDialog(
                      currentSort: _currentSort,
                      onSortSelected: (sortBy) {
                        setState(() {
                          _currentSort = sortBy;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Name Input Row
                NameInputRow(
                  imageUrl:
                      'https://i.namu.wiki/i/MIhJKlK5yVR3axxgE7_gHL-rsKjliShJKd3asUqg5KDdEsdOGut-9mCW4Ti1x7i2y8zCkxeZHQFR00sQg6BfYA.webp',
                  isEnabled: _isNameEnabled,
                  controller: _nameController,
                  onToggleChanged: (value) {
                    setState(() {
                      _isNameEnabled = value;
                    });
                  },
                  onChanged: (value) {
                    print('Name changed: $value');
                  },
                ),
              ],
            ),
          ),

          // Divider
          Divider(
            height: 1,
            thickness: 1,
            color: AppColors.gray200,
          ),

          // Bottom section with gray background
          Expanded(
            child: Container(
              color: const Color(0xFFF8F9FA),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SystemPromptInput(
                              controller: _promptController,
                              onChanged: (value) {
                                print('Prompt changed: $value');
                              },
                            ),
                            const SizedBox(height: 24),
                            ExpandableParameterSection(
                              title: "Reasoning Parameters",
                              parameters: [
                                SliderParameter(
                                  label: "Max Tokens",
                                  value: _maxTokens,
                                  min: 0,
                                  max: 2000,
                                  onChanged: (value) {
                                    setState(() {
                                      _maxTokens = value;
                                    });
                                  },
                                ),
                                SliderParameter(
                                  label: "Temperature",
                                  value: _temperature,
                                  min: 0,
                                  max: 1,
                                  decimals: 2,
                                  onChanged: (value) {
                                    setState(() {
                                      _temperature = value;
                                    });
                                  },
                                ),
                                SliderParameter(
                                  label: "Top P",
                                  value: _topP,
                                  min: 0,
                                  max: 1,
                                  decimals: 2,
                                  onChanged: (value) {
                                    setState(() {
                                      _topP = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          offset: const Offset(0, -1),
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    child: ActionButtonsRow(
                      onApplyToAll: () {
                        print('Apply to all pressed');
                      },
                      onReset: () {
                        print('Reset pressed');
                      },
                      onRemove: () {
                        print('Remove pressed');
                      },
                    ),
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
