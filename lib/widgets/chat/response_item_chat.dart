import 'package:flutter/material.dart';
import '../../core/styles/colors.dart';

class ResponseItemChat extends StatefulWidget {
  final String reasoning;
  final String response;
  final String aiName;
  final bool isLoading;
  final VoidCallback? onRegenerate;
  final VoidCallback? onCopy;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  final VoidCallback? onAnalytics;
  final VoidCallback? onUsernameTap;

  const ResponseItemChat({
    Key? key,
    required this.reasoning,
    required this.response,
    required this.aiName,
    this.isLoading = false,
    this.onRegenerate,
    this.onCopy,
    this.onDelete,
    this.onEdit,
    this.onAnalytics,
    this.onUsernameTap,
  }) : super(key: key);

  @override
  State<ResponseItemChat> createState() => _ResponseItemChatState();
}

class _ResponseItemChatState extends State<ResponseItemChat>
    with SingleTickerProviderStateMixin {
  bool _isReasoningExpanded = false;
  bool _isHoveringUsername = false;
  late AnimationController _dotsAnimationController;
  final List<String> _loadingDots = ['', '.', '..', '...'];

  @override
  void initState() {
    super.initState();
    _dotsAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _dotsAnimationController.dispose();
    super.dispose();
  }

  String get _animatedDots {
    final dotCount =
        (_dotsAnimationController.value * _loadingDots.length).floor();
    return _loadingDots[dotCount];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // AI User Info
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                'https://i.namu.wiki/i/MIhJKlK5yVR3axxgE7_gHL-rsKjliShJKd3asUqg5KDdEsdOGut-9mCW4Ti1x7i2y8zCkxeZHQFR00sQg6BfYA.webp',
                width: 32,
                height: 32,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) => setState(() => _isHoveringUsername = true),
              onExit: (_) => setState(() => _isHoveringUsername = false),
              child: GestureDetector(
                onTap: widget.onUsernameTap,
                child: Text(
                  '${widget.aiName} | NovitaAI',
                  style: TextStyle(
                    color: const Color(0xFF7B66FF),
                    fontSize: 14,
                    decoration:
                        _isHoveringUsername ? TextDecoration.underline : null,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.8,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F3F3),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: Text(
                'Reasoning (thought for 0.6s)',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Icon(
                _isReasoningExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: Colors.black54,
              ),
              onExpansionChanged: (expanded) {
                setState(() {
                  _isReasoningExpanded = expanded;
                });
              },
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    widget.reasoning,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),
        if (widget.isLoading) ...[
          // Loading Container
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.8,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F3F3),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(16),
            child: AnimatedBuilder(
              animation: _dotsAnimationController,
              builder: (context, child) {
                return Text(
                  _animatedDots,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                    height: 1.5,
                  ),
                );
              },
            ),
          ),
        ] else ...[
          // Response Section
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.8,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F3F3),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Text(
              widget.response,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
                height: 1.5,
              ),
            ),
          )
        ],
        const SizedBox(height: 12),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.onRegenerate != null)
              _buildActionButton(
                icon: Icons.refresh,
                onTap: widget.onRegenerate,
              ),
            if (widget.onCopy != null)
              _buildActionButton(
                icon: Icons.copy_outlined,
                onTap: widget.onCopy,
              ),
            if (widget.onDelete != null)
              _buildActionButton(
                icon: Icons.delete_outline,
                onTap: widget.onDelete,
              ),
            if (widget.onEdit != null)
              _buildActionButton(
                icon: Icons.edit_outlined,
                onTap: widget.onEdit,
              ),
            if (widget.onAnalytics != null)
              _buildActionButton(
                icon: Icons.analytics_outlined,
                onTap: widget.onAnalytics,
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
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
  }
}
