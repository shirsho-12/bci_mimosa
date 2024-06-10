import 'dart:async';
import 'dart:io';
import 'dart:developer' as devtools show log;

import 'package:flutter/material.dart';
// import 'package:spritewidget/spritewidget.dart';
// import 'package:mimosa/ui/typography/text_styles.dart';
export 'responsive_layout_builder.dart';

// late ImageMap _images;
// late SpriteSheet _sprites;
List<String> transitionAnimationImages = [
  'assets/images/face_pref/secondlayer_bag1.png',
  'assets/images/face_pref/secondlayer_bag2.png',
  'assets/images/face_pref/secondlayer_bag3.png',
];

class ChildrenGameAnimation extends StatefulWidget {
  final double width;
  final double height;
  const ChildrenGameAnimation(
      {super.key, required this.width, required this.height});

  @override
  State<ChildrenGameAnimation> createState() => _ChildrenGameAnimationState();
}

class _ChildrenGameAnimationState extends State<ChildrenGameAnimation> {
  // late NodeWithSize rootNode;

  // Future<void> _loadAssets(AssetBundle bundle) async {
  //   _images = ImageMap();
  //   // get all the images from the director
  //   // Directory dir = Directory('assets/images/face_pref/');
  //   // var exists = dir.existsSync();
  //   // devtools.log('Directory: $dir, Exists: $exists');
  //   await _images.load(transitionAnimationImages);
  // }
  late final Timer timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    //   rootNode = NodeWithSize(Size(widget.width, widget.height));
    //   await _loadAssets(DefaultAssetBundle.of(context));
    timer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
      setState(() {
        _index = (_index + 1) % transitionAnimationImages.length;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return SpriteWidget(rootNode);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 150),
      key: UniqueKey(),
      child: Image.asset(
        transitionAnimationImages[_index],
        width: widget.width,
        height: widget.height,
        key: UniqueKey(),
      ),
    );
  }
}
