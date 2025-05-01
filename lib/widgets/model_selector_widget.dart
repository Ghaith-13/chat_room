import 'package:flutter/material.dart';
import 'model_control_panel.dart';

class ModelSelectorWidget extends StatefulWidget {
  final Function(String)? onModelSelected;
  final String? initialSelectedModel;

  const ModelSelectorWidget({
    Key? key,
    this.onModelSelected,
    this.initialSelectedModel,
  }) : super(key: key);

  @override
  State<ModelSelectorWidget> createState() => _ModelSelectorWidgetState();
}

class _ModelSelectorWidgetState extends State<ModelSelectorWidget> {
  String? selectedModel;

  final List<ModelOption> models = [
    ModelOption(
      name: 'Claude 3.7 Sonnet',
      icon: Icons.circle,
      color: const Color(0xFFE9D7BE),
      textColor: Colors.black,
    ),
    ModelOption(
      name: 'GPT-4.1',
      icon: Icons.refresh,
      color: Colors.white,
      textColor: Colors.black,
    ),
    ModelOption(
      name: 'Gemini 2.5 Pro Preview',
      icon: Icons.star,
      color: Colors.white,
      iconColor: Colors.blue,
      textColor: Colors.black,
    ),
    ModelOption(
      name: 'Grok 3 Beta',
      icon: Icons.close,
      color: Colors.white,
      textColor: Colors.black,
    ),
  ];

  @override
  void initState() {
    super.initState();
    selectedModel = widget.initialSelectedModel ?? models.first.name;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          const Text(
            'To:',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: models.map((model) {
                  final bool isSelected = selectedModel == model.name;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ModelOptionContainer(
                      model: model,
                      isSelected: isSelected,
                      onTap: () {
                        setState(() {
                          selectedModel = model.name;
                        });
                        if (widget.onModelSelected != null) {
                          widget.onModelSelected!(model.name);
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ModelOption {
  final String name;
  final IconData icon;
  final Color color;
  final Color textColor;
  final Color? iconColor;

  ModelOption({
    required this.name,
    required this.icon,
    required this.color,
    required this.textColor,
    this.iconColor,
  });
}

class ModelOptionContainer extends StatelessWidget {
  final ModelOption model;
  final bool isSelected;
  final VoidCallback onTap;

  const ModelOptionContainer({
    Key? key,
    required this.model,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OptionsMenuWrapper(
      model: model,
      isSelected: isSelected,
      onTap: onTap,
    );
  }
}

class OptionsMenuWrapper extends StatefulWidget {
  final ModelOption model;
  final bool isSelected;
  final VoidCallback onTap;
  final Function(bool)? onSwitchToggled;

  const OptionsMenuWrapper({
    Key? key,
    required this.model,
    required this.isSelected,
    required this.onTap,
    this.onSwitchToggled,
  }) : super(key: key);

  @override
  State<OptionsMenuWrapper> createState() => _OptionsMenuWrapperState();
}

class _OptionsMenuWrapperState extends State<OptionsMenuWrapper> {
  bool _isMenuOpen = false;
  bool _switchValue = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isMenuOpen ? null : widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: _isMenuOpen
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.model.icon,
              size: 20.0,
              color: widget.model.iconColor ?? widget.model.textColor,
            ),
            const SizedBox(width: 8.0),
            Text(
              widget.model.name,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: widget.model.textColor,
              ),
            ),
            const SizedBox(width: 4.0),
            if (_isMenuOpen)
              ModelControlPanel(
                switchValue: _switchValue,
                onSwitchToggled: (value) {
                  setState(() {
                    _switchValue = value;
                  });
                  print('Switch for ${widget.model.name} toggled to: $value');
                  if (widget.onSwitchToggled != null) {
                    widget.onSwitchToggled!(value);
                  }
                },
                onClose: () {
                  setState(() {
                    _isMenuOpen = false;
                  });
                },
              )
            else
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isMenuOpen = true;
                  });
                },
                child: SizedBox(
                  height: 24.0, // Fixed height to match original
                  child: Icon(
                    Icons.more_vert,
                    size: 16.0,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
