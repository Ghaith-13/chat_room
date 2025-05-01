import 'package:flutter/material.dart';
import '../../core/styles/colors.dart';
import '../button/custom_button.dart';

class SenderItemChat extends StatefulWidget {
  final String message;
  final String userName;
  final VoidCallback? onRegenerate;
  final VoidCallback? onCopy;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  final VoidCallback? onCode;
  final Function(String)? onSave;
  final Function(String)? onSaveAndRetry;

  const SenderItemChat({
    Key? key,
    required this.message,
    required this.userName,
    this.onRegenerate,
    this.onCopy,
    this.onDelete,
    this.onEdit,
    this.onCode,
    this.onSave,
    this.onSaveAndRetry,
  }) : super(key: key);

  @override
  State<SenderItemChat> createState() => _SenderItemChatState();
}

class _SenderItemChatState extends State<SenderItemChat> {
  bool _isEditing = false;
  bool _isCopied = false;
  late TextEditingController _editingController;

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(text: widget.message);
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  void _startEditing() {
    setState(() {
      _isEditing = true;
      _editingController.text = widget.message;
    });
  }

  void _cancelEditing() {
    setState(() {
      _isEditing = false;
      _editingController.text = widget.message;
    });
  }

  void _saveEdit() {
    if (widget.onSave != null) {
      widget.onSave!(_editingController.text);
    }
    setState(() {
      _isEditing = false;
    });
  }

  void _saveAndRetry() {
    if (widget.onSaveAndRetry != null) {
      widget.onSaveAndRetry!(_editingController.text);
    }
    setState(() {
      _isEditing = false;
    });
  }

  void _handleCopy() {
    if (widget.onCopy != null) {
      widget.onCopy!();
      setState(() {
        _isCopied = true;
      });

      // Reset the icon after 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isCopied = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              widget.userName,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: AppColors.gray500,
              radius: 16,
              child: Text(
                widget.userName[0].toLowerCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (_isEditing) ...[
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.8,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F3F3),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _editingController,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Enter your message',
                    contentPadding: EdgeInsets.zero,
                    filled: true,
                    fillColor: Color(0xFFF3F3F3),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      text: 'Cancel',
                      onPressed: _cancelEditing,
                      variant: CustomButtonVariant.secondary,
                      backgroundColor: Colors.white,
                      borderColor: Colors.black12,
                    ),
                    const SizedBox(width: 8),
                    CustomButton(
                      text: 'Save',
                      onPressed: _saveEdit,
                      variant: CustomButtonVariant.secondary,
                      backgroundColor: Colors.white,
                      borderColor: Colors.black12,
                    ),
                    const SizedBox(width: 8),
                    CustomButton(
                      text: 'Save & Retry',
                      onPressed: _saveAndRetry,
                      variant: CustomButtonVariant.primary,
                      backgroundColor: const Color(0xFF7B66FF),
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ] else ...[
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.8,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF4285F4),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              widget.message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.onRegenerate != null)
                _buildActionButton(
                  icon: Icons.refresh,
                  onTap: widget.onRegenerate,
                  tooltip: 'Regenerate response',
                ),
              if (widget.onCopy != null)
                _buildActionButton(
                  icon: _isCopied ? Icons.check : Icons.copy_outlined,
                  onTap: _handleCopy,
                  tooltip: 'Copy message',
                ),
              if (widget.onDelete != null)
                _buildActionButton(
                  icon: Icons.delete_outline,
                  onTap: widget.onDelete,
                  tooltip: 'Delete message',
                ),
              if (widget.onEdit != null)
                _buildActionButton(
                  icon: Icons.edit_outlined,
                  onTap: _startEditing,
                  tooltip: 'Edit message',
                ),
              if (widget.onCode != null)
                _buildActionButton(
                  icon: Icons.code,
                  onTap: widget.onCode,
                  tooltip: 'View code',
                ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback? onTap,
    String? tooltip,
  }) {
    Widget button = Padding(
      padding: const EdgeInsets.only(left: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(
            icon,
            size: 20,
            color: AppColors.gray600,
          ),
        ),
      ),
    );

    if (tooltip != null) {
      return Tooltip(
        message: tooltip,
        preferBelow: false,
        verticalOffset: 20,
        textStyle: const TextStyle(
          color: Colors.black87,
          fontSize: 12,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: button,
      );
    }

    return button;
  }
}
