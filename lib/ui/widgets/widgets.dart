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

class MimosaButtonSmall extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const MimosaButtonSmall(
      {super.key, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.125,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Center(child: Text(buttonText, style: MimosaTextStyle.headline2)),
        ),
      ),
    );
  }
}

class MimosaButtonLarge extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const MimosaButtonLarge(
      {super.key, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.225,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Center(child: Text(buttonText, style: MimosaTextStyle.headline1)),
        ),
      ),
    );
  }
}
