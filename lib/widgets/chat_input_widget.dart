import 'package:flutter/material.dart';
import '../core/styles/colors.dart';
import '../core/styles/radius.dart';
import 'chat_settings_menu.dart';

class ChatInputWidget extends StatefulWidget {
  final Function(String)? onSendMessage;
  final VoidCallback? onAttachmentTap;
  final VoidCallback? onNewRoomTap;
  final VoidCallback? onMicTap;

  const ChatInputWidget({
    Key? key,
    this.onSendMessage,
    this.onAttachmentTap,
    this.onNewRoomTap,
    this.onMicTap,
  }) : super(key: key);

  @override
  State<ChatInputWidget> createState() => _ChatInputWidgetState();
}

class _ChatInputWidgetState extends State<ChatInputWidget> {
  final TextEditingController _messageController = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _messageController.addListener(_updateHasText);
  }

  @override
  void dispose() {
    _messageController.removeListener(_updateHasText);
    _messageController.dispose();
    super.dispose();
  }

  void _updateHasText() {
    final hasText = _messageController.text.isNotEmpty;
    if (hasText != _hasText) {
      setState(() {
        _hasText = hasText;
      });
    }
  }

  void _handleSendMessage() {
    final message = _messageController.text.trim();
    if (message.isNotEmpty && widget.onSendMessage != null) {
      widget.onSendMessage!(message);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.mdRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top row with settings and new room options
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left side with settings icon
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.settings_outlined, size: 20),
                      onPressed: () {
                        final RenderBox button =
                            context.findRenderObject() as RenderBox;
                        final RenderBox overlay = Overlay.of(context)
                            .context
                            .findRenderObject() as RenderBox;
                        final RelativeRect position = RelativeRect.fromRect(
                          Rect.fromPoints(
                            button.localToGlobal(Offset.zero,
                                ancestor: overlay),
                            button.localToGlobal(
                                button.size.bottomRight(Offset.zero),
                                ancestor: overlay),
                          ),
                          Offset.zero & overlay.size,
                        );

                        showMenu<String>(
                          context: context,
                          position: position,
                          shape: RoundedRectangleBorder(
                            borderRadius: AppRadius.mdRadius,
                          ),
                          elevation: 8,
                          color: Colors.white,
                          items: [
                            ChatSettingsMenuEntry(
                              onExport: () {
                                Navigator.pop(context);
                                // Handle export
                              },
                              onImport: () {
                                Navigator.pop(context);
                                // Handle import
                              },
                              onGetMarkdown: () {
                                Navigator.pop(context);
                                // Handle get markdown
                              },
                              onClearModels: () {
                                Navigator.pop(context);
                                // Handle clear models
                              },
                              onClearChat: () {
                                Navigator.pop(context);
                                // Handle clear chat
                              },
                              onShareModels: () {
                                Navigator.pop(context);
                                // Handle share models
                              },
                              onImportCharacter: () {
                                Navigator.pop(context);
                                // Handle import character
                              },
                              onAutoExpandChanged: (value) {
                                // Handle auto expand change without closing
                                setState(() {
                                  // Update local state if needed
                                });
                              },
                              onDuplicateRoom: () {
                                Navigator.pop(context);
                                // Handle duplicate room
                              },
                            ),
                          ],
                        );
                      },
                      color: AppColors.gray500,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 36,
                        minHeight: 36,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.language_outlined, size: 20),
                      onPressed: () {},
                      color: AppColors.gray500,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 36,
                        minHeight: 36,
                      ),
                    ),
                  ],
                ),

                // Right side with new room button
                GestureDetector(
                  onTap: widget.onNewRoomTap,
                  child: Row(
                    children: [
                      Text(
                        'New Room',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.add_box_outlined,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Message input row with different background
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.gray100,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppRadius.mdRadius.bottomLeft.x),
                bottomRight: Radius.circular(AppRadius.mdRadius.bottomRight.x),
              ),
            ),
            child: Row(
              children: [
                // Text input field
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Start a message...',
                      hintStyle: TextStyle(
                        color: AppColors.gray400,
                        fontSize: 14,
                      ),
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      fillColor: Colors.transparent,
                      filled: true,
                    ),
                    maxLines: 1,
                    textAlignVertical: TextAlignVertical.center,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _handleSendMessage(),
                  ),
                ),

                // Right side icons (attachment and send)
                IconButton(
                  icon: const Icon(Icons.attach_file_rounded, size: 20),
                  onPressed: widget.onAttachmentTap,
                  color: AppColors.gray500,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 36,
                    minHeight: 36,
                  ),
                ),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: _hasText
                        ? AppColors.primary
                        : AppColors.primary.withOpacity(0.6),
                    borderRadius: AppRadius.mdRadius,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20,
                      color: Colors.white,
                    ),
                    onPressed: _hasText ? _handleSendMessage : null,
                    color: AppColors.white,
                    padding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
