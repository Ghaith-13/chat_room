import 'package:flutter/material.dart';
import '../widgets/model_selector_widget.dart';

class ModelSelectorDemo extends StatefulWidget {
  const ModelSelectorDemo({Key? key}) : super(key: key);

  @override
  State<ModelSelectorDemo> createState() => _ModelSelectorDemoState();
}

class _ModelSelectorDemoState extends State<ModelSelectorDemo> {
  String? selectedModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Model Selector Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // Model selector widget
          ModelSelectorWidget(
            initialSelectedModel: 'Claude 3.7 Sonnet',
            onModelSelected: (model) {
              setState(() {
                selectedModel = model;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Selected model: $model')),
              );
            },
          ),

          const SizedBox(height: 20),

          // Display selected model
          if (selectedModel != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Currently Selected:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        selectedModel!,
                        style: const TextStyle(fontSize: 16),
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
