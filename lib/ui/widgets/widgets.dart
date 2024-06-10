import 'package:flutter/material.dart';
import 'package:mimosa/ui/typography/text_styles.dart';

export 'responsive_layout_builder.dart';

class ButtonText extends StatelessWidget {
  final String buttonText;
  const ButtonText({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(buttonText, style: MimosaTextStyle.headline2),
    );
  }
}
