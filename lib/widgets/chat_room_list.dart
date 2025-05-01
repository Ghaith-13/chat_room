import 'package:flutter/material.dart';
import 'chat_options_menu.dart';

class ChatRoomList extends StatefulWidget {
  const ChatRoomList({super.key});

  @override
  State<ChatRoomList> createState() => _ChatRoomListState();
}

class _ChatRoomListState extends State<ChatRoomList> {
  final List<ChatRoom> _chatRooms = [
    ChatRoom(name: 'New Room', unreadCount: 0),
    ChatRoom(name: 'Untitled Chat', unreadCount: 0),
    ChatRoom(name: 'How many r\'s are in th...', unreadCount: 0),
    ChatRoom(name: '9.11 and 9.9, which one i', unreadCount: 0),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _chatRooms.length,
      itemBuilder: (context, index) {
        return ChatRoomTile(
          chatRoom: _chatRooms[index],
          onTap: () {
            // This adds a new room when the "New Room" is tapped
            if (_chatRooms[index].name == 'New Room') {
              setState(() {
                _chatRooms.insert(
                    1, ChatRoom(name: 'Ultimate Chat', unreadCount: 0));
              });
            }
          },
        );
      },
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  final ChatRoom chatRoom;
  final VoidCallback onTap;

  const ChatRoomTile({
    super.key,
    required this.chatRoom,
    required this.onTap,
  });

  void _showOptionsMenu(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    ).shift(const Offset(0, -5)); // Shift up slightly to be closer to dots

    showMenu<String>(
      context: context,
      position: position,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 2,
      color: Colors.white,
      items: [
        PopupMenuItem(
          padding: EdgeInsets.zero,
          child: ChatOptionsMenu(
            onRename: () {
              Navigator.of(context).pop();
              // Handle rename action
            },
            onDuplicate: () {
              Navigator.of(context).pop();
              // Handle duplicate action
            },
            onDelete: () {
              Navigator.of(context).pop();
              // Handle delete action
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = chatRoom.name == 'New Room'
        ? Theme.of(context).textTheme.bodyLarge?.color
        : Colors.grey;

    final textStyle = TextStyle(
      color: textColor,
      fontWeight:
          chatRoom.name == 'New Room' ? FontWeight.w600 : FontWeight.normal,
      fontSize: 16,
    );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: (chatRoom.name == 'Ultimate Chat')
            ? (isDarkMode ? Colors.grey[850] : Colors.grey[200])
            : chatRoom.name == 'New Room'
                ? Colors.transparent
                : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: chatRoom.name == 'New Room'
            ? Border.all(color: Colors.grey.shade300, width: 1)
            : null,
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(
          chatRoom.name,
          style: textStyle,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: chatRoom.unreadCount > 0
            ? Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${chatRoom.unreadCount}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              )
            : chatRoom.name == 'New Room'
                ? Icon(Icons.add, size: 20, color: Colors.grey)
                : chatRoom.name == 'Ultimate Chat' ||
                        chatRoom.name == 'Untitled Chat'
                    ? IconButton(
                        icon:
                            Icon(Icons.more_vert, size: 20, color: Colors.grey),
                        onPressed: () => _showOptionsMenu(context),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      )
                    : null,
      ),
    );
  }
}

class ChatRoom {
  final String name;
  final int unreadCount;

  ChatRoom({
    required this.name,
    required this.unreadCount,
  });
}
