import 'package:flutter/material.dart';

class ModelControlPanel extends StatelessWidget {
  final bool switchValue;
  final Function(bool)? onSwitchToggled;
  final VoidCallback onClose;

  const ModelControlPanel({
    Key? key,
    required this.switchValue,
    this.onSwitchToggled,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(16.0),
          bottomRight: Radius.circular(16.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: onClose,
            child: SizedBox(
              height: 24.0,
              child: Icon(
                Icons.more_vert,
                size: 16.0,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          SizedBox(
            height: 8.0,
            child: Transform.scale(
              scale: 0.7,
              child: Switch(
                value: switchValue,
                onChanged: onSwitchToggled,
                activeColor: Colors.white,
                activeTrackColor: const Color(0xFF6E5DC7),
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey.shade300,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
            ),
          ),
          GestureDetector(
            onTap: onClose,
            child: const SizedBox(
              height: 24.0,
              child: Icon(
                Icons.close,
                size: 16.0,
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          )
        ],
      ),
    );
  }
}
