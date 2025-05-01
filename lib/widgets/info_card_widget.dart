import 'package:flutter/material.dart';

/// A widget that displays a title and description in a card format.
class InfoCard extends StatelessWidget {
  /// Creates an InfoCard widget.
  ///
  /// The [title] parameter is required and represents the headline of the card.
  /// The [description] parameter is required and provides additional details.
  const InfoCard({
    super.key,
    required this.title,
    required this.description,
    this.backgroundColor = Colors.white,
    this.titleStyle,
    this.descriptionStyle,
    this.padding,
    this.borderRadius,
    this.elevation = 0,
    this.width = 200,
    this.height = 120,
  });

  /// The headline text to display.
  final String title;

  /// The descriptive text to display below the title.
  final String description;

  /// The background color of the card. Defaults to white.
  final Color? backgroundColor;

  /// The text style for the title. Defaults to headline6 from theme.
  final TextStyle? titleStyle;

  /// The text style for the description. Defaults to bodyText2 from theme.
  final TextStyle? descriptionStyle;

  /// The internal padding of the card content.
  final EdgeInsetsGeometry? padding;

  /// The border radius of the card.
  final BorderRadius? borderRadius;

  /// The elevation of the card to show a shadow. Defaults to 0.
  final double? elevation;

  /// The fixed width of the card.
  final double width;

  /// The fixed height of the card.
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            offset: Offset(0, -3),
            blurRadius: 6,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Card(
        elevation: elevation ?? 0.0,
        color: backgroundColor,
        shadowColor: Colors.transparent,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: titleStyle ?? theme.textTheme.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8.0),
              Text(
                description,
                style: descriptionStyle ?? theme.textTheme.bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
