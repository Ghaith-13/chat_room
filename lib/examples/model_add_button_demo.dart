import 'package:flutter/material.dart';
import '../widgets/model_add_button.dart';

class ModelAddButtonDemo extends StatelessWidget {
  const ModelAddButtonDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Model Add Button Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Model Selection',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Default model add button
              ModelAddButton(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Add model button pressed')),
                  );
                  _showModelSelectionDialog(context);
                },
              ),

              const SizedBox(height: 20),

              // Customized model add button
              ModelAddButton(
                label: 'Select AI model',
                icon: Icons.smart_toy,
                shortcutKey: 'M',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Custom model button pressed')),
                  );
                  _showModelSelectionDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showModelSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select a Model'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildModelOption(context, 'Claude 3.7 Sonnet', Icons.circle),
            _buildModelOption(context, 'GPT-4.1', Icons.refresh),
            _buildModelOption(context, 'Gemini 2.5 Pro', Icons.star),
            _buildModelOption(context, 'Grok 3 Beta', Icons.close),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Widget _buildModelOption(BuildContext context, String name, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(name),
      onTap: () {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Selected model: $name')),
        );
      },
    );
  }
}
