import 'package:flutter/material.dart';

/// App spacing constants
class AppSpacing {
  // Spacing values
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;

  // Padding widgets
  static const EdgeInsets xsPadding = EdgeInsets.all(xs);
  static const EdgeInsets smPadding = EdgeInsets.all(sm);
  static const EdgeInsets mdPadding = EdgeInsets.all(md);
  static const EdgeInsets lgPadding = EdgeInsets.all(lg);
  static const EdgeInsets xlPadding = EdgeInsets.all(xl);
  static const EdgeInsets xxlPadding = EdgeInsets.all(xxl);

  // Horizontal padding
  static const EdgeInsets xsPaddingHorizontal =
      EdgeInsets.symmetric(horizontal: xs);
  static const EdgeInsets smPaddingHorizontal =
      EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsets mdPaddingHorizontal =
      EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets lgPaddingHorizontal =
      EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets xlPaddingHorizontal =
      EdgeInsets.symmetric(horizontal: xl);

  // Vertical padding
  static const EdgeInsets xsPaddingVertical =
      EdgeInsets.symmetric(vertical: xs);
  static const EdgeInsets smPaddingVertical =
      EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets mdPaddingVertical =
      EdgeInsets.symmetric(vertical: md);
  static const EdgeInsets lgPaddingVertical =
      EdgeInsets.symmetric(vertical: lg);
  static const EdgeInsets xlPaddingVertical =
      EdgeInsets.symmetric(vertical: xl);

  // SizedBox for height spacing
  static const Widget verticalSpaceXS = SizedBox(height: xs);
  static const Widget verticalSpaceSM = SizedBox(height: sm);
  static const Widget verticalSpaceMD = SizedBox(height: md);
  static const Widget verticalSpaceLG = SizedBox(height: lg);
  static const Widget verticalSpaceXL = SizedBox(height: xl);

  // SizedBox for width spacing
  static const Widget horizontalSpaceXS = SizedBox(width: xs);
  static const Widget horizontalSpaceSM = SizedBox(width: sm);
  static const Widget horizontalSpaceMD = SizedBox(width: md);
  static const Widget horizontalSpaceLG = SizedBox(width: lg);
  static const Widget horizontalSpaceXL = SizedBox(width: xl);
}
