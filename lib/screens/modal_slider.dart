import 'package:flutter/material.dart';
import '../widgets/parameter_slider.dart';

class ModalSlider extends StatefulWidget {
  const ModalSlider({Key? key}) : super(key: key);

  @override
  State<ModalSlider> createState() => _ModalSliderState();
}

class _ModalSliderState extends State<ModalSlider> {
  double maxTokens = 0;
  double chatMemory = 8;
  double temperature = 1.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Max Tokens
          ParameterSlider(
            label: 'Max Tokens',
            value: maxTokens,
            min: 0,
            max: 32000,
            onChanged: (value) {
              setState(() {
                maxTokens = value;
              });
            },
          ),
          const SizedBox(height: 24),

          // Chat Memory
          ParameterSlider(
            label: 'Chat Memory',
            value: chatMemory,
            min: 0,
            max: 20,
            onChanged: (value) {
              setState(() {
                chatMemory = value;
              });
            },
          ),
          const SizedBox(height: 24),

          // Temperature
          ParameterSlider(
            label: 'Temperature',
            value: temperature,
            min: 0,
            max: 2,
            decimals: 3,
            onChanged: (value) {
              setState(() {
                temperature = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
