import 'package:flutter/material.dart';
import '../widgets/info_card_widget.dart';

class InfoCardDemo extends StatelessWidget {
  const InfoCardDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InfoCard Widget Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Basic Info Card Example
            const InfoCard(
              title: 'Strawberry Test',
              description: 'How many r\'s are in the word strawberry?',
            ),

            const SizedBox(height: 16),

            // Customized Info Card Example
            InfoCard(
              title: 'Custom Styled Card',
              description:
                  'This card has custom styling with different colors and text styles.',
              backgroundColor: Colors.blue.shade50,
              titleStyle: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              descriptionStyle: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
              elevation: 4,
              borderRadius: BorderRadius.circular(20),
            ),

            const SizedBox(height: 16),

            // Compact Info Card Example
            const InfoCard(
              title: 'Compact Card',
              description:
                  'This card uses less padding for a more compact look.',
              padding: EdgeInsets.all(8.0),
            ),
          ],
        ),
      ),
    );
  }
}
