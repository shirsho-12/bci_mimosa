import 'package:flutter/material.dart';
import 'package:mimosa/models/image_data.dart';
import 'package:mimosa/rtn_animation/bloc/bloc.dart';
import 'package:mimosa/rtn_animation/widgets/widgets.dart';

/// {@template rtn_animation_page}
/// A description for RtnAnimationPage
/// {@endtemplate}
class RtnAnimationPage extends StatelessWidget {
  /// {@macro rtn_animation_page}
  const RtnAnimationPage({super.key});

  /// The static route for RtnAnimationPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const RtnAnimationPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RtnAnimationBloc(),
      child: const RtnAnimationView(),
    );
  }
}

/// {@template rtn_animation_view}
/// Displays the Body of RtnAnimationView
/// {@endtemplate}
class RtnAnimationView extends StatelessWidget {
  /// {@macro rtn_animation_view}
  const RtnAnimationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Background(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          time: 200,
          level: 3,
          imagePaths: RTNAssets.backgroundImages,
        ),
        const Center(child: RtnAnimationBody())
      ],
    );
  }
}
