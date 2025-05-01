import 'package:flutter/material.dart';
import '../core/styles/colors.dart';
import '../core/styles/radius.dart';

class ChatSettingsMenuEntry extends PopupMenuEntry<String> {
  final VoidCallback? onExport;
  final VoidCallback? onImport;
  final VoidCallback? onGetMarkdown;
  final VoidCallback? onClearModels;
  final VoidCallback? onClearChat;
  final VoidCallback? onShareModels;
  final VoidCallback? onImportCharacter;
  final Function(bool)? onAutoExpandChanged;
  final VoidCallback? onDuplicateRoom;
  final bool autoExpand;

  const ChatSettingsMenuEntry({
    Key? key,
    this.onExport,
    this.onImport,
    this.onGetMarkdown,
    this.onClearModels,
    this.onClearChat,
    this.onShareModels,
    this.onImportCharacter,
    this.onAutoExpandChanged,
    this.onDuplicateRoom,
    this.autoExpand = false,
  }) : super(key: key);

  @override
  double get height => 450; // Approximate height for the menu

  @override
  bool represents(String? value) => false;

  @override
  ChatSettingsMenuEntryState createState() => ChatSettingsMenuEntryState();
}

class ChatSettingsMenuEntryState extends State<ChatSettingsMenuEntry> {
  @override
  Widget build(BuildContext context) {
    return ChatSettingsMenu(
      onExport: widget.onExport,
      onImport: widget.onImport,
      onGetMarkdown: widget.onGetMarkdown,
      onClearModels: widget.onClearModels,
      onClearChat: widget.onClearChat,
      onShareModels: widget.onShareModels,
      onImportCharacter: widget.onImportCharacter,
      onAutoExpandChanged: widget.onAutoExpandChanged,
      onDuplicateRoom: widget.onDuplicateRoom,
      autoExpand: widget.autoExpand,
    );
  }
}

class ChatSettingsMenu extends StatelessWidget {
  final VoidCallback? onExport;
  final VoidCallback? onImport;
  final VoidCallback? onGetMarkdown;
  final VoidCallback? onClearModels;
  final VoidCallback? onClearChat;
  final VoidCallback? onShareModels;
  final VoidCallback? onImportCharacter;
  final Function(bool)? onAutoExpandChanged;
  final VoidCallback? onDuplicateRoom;
  final bool autoExpand;

  const ChatSettingsMenu({
    Key? key,
    this.onExport,
    this.onImport,
    this.onGetMarkdown,
    this.onClearModels,
    this.onClearChat,
    this.onShareModels,
    this.onImportCharacter,
    this.onAutoExpandChanged,
    this.onDuplicateRoom,
    this.autoExpand = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.mdRadius,
      ),
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildMenuItem(
              'Export',
              Icons.arrow_downward,
              onExport,
            ),
            _buildMenuItem(
              'Import',
              Icons.arrow_upward,
              onImport,
            ),
            _buildMenuItem(
              'Get Markdown',
              Icons.code,
              onGetMarkdown,
              trailing: const Text('⌘M',
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
            ),
            _buildMenuItem(
              'Clear Models',
              Icons.auto_delete_outlined,
              onClearModels,
            ),
            _buildMenuItem(
              'Clear Chat',
              Icons.cancel_outlined,
              onClearChat,
            ),
            _buildMenuItem(
              'Share Models',
              Icons.share_outlined,
              onShareModels,
            ),
            _buildMenuItem(
              'Import Character',
              Icons.person_add_alt_1_outlined,
              onImportCharacter,
            ),
            _buildSwitchMenuItem(
              'Auto-expand',
              autoExpand,
              onAutoExpandChanged,
            ),
            _buildMenuItem(
              'Duplicate Room',
              Icons.copy_outlined,
              onDuplicateRoom,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    String title,
    IconData iconData,
    VoidCallback? onTap, {
    Widget? trailing,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            if (trailing != null) trailing,
            Icon(
              iconData,
              size: 20,
              color: AppColors.gray600,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchMenuItem(
    String title,
    bool value,
    Function(bool)? onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }
}
