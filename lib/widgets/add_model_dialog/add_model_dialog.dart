import 'package:chatroom/widgets/button/custom_button.dart';
import 'package:chatroom/widgets/search_dialog/modal_search_dialog.dart';
import 'package:chatroom/widgets/search_dialog/provider_search_dialog.dart';
import 'package:flutter/material.dart';
import '../../core/styles/colors.dart';
import '../../core/styles/radius.dart';
import '../text_field/search_text_field.dart';
import '../text_field/name_input_row.dart';
import '../text_field/system_prompt_input.dart';
import '../expandable_parameter_section.dart';
import '../button/selection_button.dart';
import '../dialog/sort_dialog.dart';

class AddModelDialog extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController promptController;
  final Function(String name, String prompt, double maxTokens,
      double temperature, double topP) onSave;
  final VoidCallback? onClose;

  const AddModelDialog({
    Key? key,
    required this.nameController,
    required this.promptController,
    required this.onSave,
    this.onClose,
  }) : super(key: key);

  static Future<void> show(
    BuildContext context, {
    required TextEditingController nameController,
    required TextEditingController promptController,
    required Function(String name, String prompt, double maxTokens,
            double temperature, double topP)
        onSave,
    VoidCallback? onClose,
  }) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: AddModelDialog(
          nameController: nameController,
          promptController: promptController,
          onSave: onSave,
          onClose: onClose,
        ),
      ),
    );
  }

  @override
  State<AddModelDialog> createState() => _AddModelDialogState();
}

class _AddModelDialogState extends State<AddModelDialog> {
  double _maxTokens = 0;
  double _chatMemory = 8;
  double _temperature = 1.0;
  double _topP = 1.0;
  double _topK = 0.0;
  double _frequencyPenalty = 0.0;
  double _presencePenalty = 0.0;
  double _repetitionPenalty = 1.0;
  double _minP = 0.0;
  double _topA = 0.0;
  bool _isNameEnabled = true;
  SortBy _currentSort = SortBy.default_;

  // State for model selection
  SelectionButtonData _selectedModel = const SelectionButtonData(
    imageUrl:
        'https://i.namu.wiki/i/MIhJKlK5yVR3axxgE7_gHL-rsKjliShJKd3asUqg5KDdEsdOGut-9mCW4Ti1x7i2y8zCkxeZHQFR00sQg6BfYA.webp',
    text: 'Microsoft: MAI DS R1',
    isFree: true,
  );

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
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                if (widget.onClose != null) {
                  widget.onClose!();
                }
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.highlight_remove_rounded),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with Name Input and Sort
                    NameInputRow(
                      imageUrl: _selectedModel.imageUrl,
                      isEnabled: _isNameEnabled,
                      controller: widget.nameController,
                      onToggleChanged: (value) {
                        setState(() {
                          _isNameEnabled = value;
                        });
                      },
                      onChanged: (value) {},
                    ),

                    const SizedBox(height: 16),
                    // Model Selection
                    SelectionButton(
                      label: 'Model',
                      data: _selectedModel,
                      onTap: () => _showSearchDialog(context),
                    ),

                    const SizedBox(height: 16),
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
                        const SizedBox(width: 12),
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
                    // System Prompt
                    SystemPromptInput(
                      controller: widget.promptController,
                      onChanged: (value) {},
                    ),

                    const SizedBox(height: 16),
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
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Parameters
                    ExpandableParameterSection(
                      title: "Sampling Parameters",
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
                          label: "Chat Memory",
                          value: _chatMemory,
                          min: 0,
                          max: 20,
                          onChanged: (value) {
                            setState(() {
                              _chatMemory = value;
                            });
                          },
                        ),
                        SliderParameter(
                          label: "Temperature",
                          value: _temperature,
                          min: 0,
                          max: 1,
                          decimals: 3,
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
                          decimals: 3,
                          onChanged: (value) {
                            setState(() {
                              _topP = value;
                            });
                          },
                        ),
                        SliderParameter(
                          label: "Top K",
                          value: _topK,
                          min: 0,
                          max: 1,
                          decimals: 3,
                          onChanged: (value) {
                            setState(() {
                              _topK = value;
                            });
                          },
                        ),
                        SliderParameter(
                          label: "Frequency Penalty",
                          value: _frequencyPenalty,
                          min: 0,
                          max: 1,
                          decimals: 3,
                          onChanged: (value) {
                            setState(() {
                              _frequencyPenalty = value;
                            });
                          },
                        ),
                        SliderParameter(
                          label: "Presence Penalty",
                          value: _presencePenalty,
                          min: 0,
                          max: 1,
                          decimals: 3,
                          onChanged: (value) {
                            setState(() {
                              _presencePenalty = value;
                            });
                          },
                        ),
                        SliderParameter(
                          label: "Repetition Penalty",
                          value: _repetitionPenalty,
                          min: 0,
                          max: 1,
                          decimals: 3,
                          onChanged: (value) {
                            setState(() {
                              _repetitionPenalty = value;
                            });
                          },
                        ),
                        SliderParameter(
                          label: "Min P",
                          value: _minP,
                          min: 0,
                          max: 1,
                          decimals: 3,
                          onChanged: (value) {
                            setState(() {
                              _minP = value;
                            });
                          },
                        ),
                        SliderParameter(
                          label: "Top A",
                          value: _topA,
                          min: 0,
                          max: 1,
                          decimals: 3,
                          onChanged: (value) {
                            setState(() {
                              _topA = value;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ActionButtonsRow(
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
