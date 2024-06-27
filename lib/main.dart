import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:mimosa/app_ui.dart';
import 'package:mimosa/models/question_set.dart';
import 'package:mimosa/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final FlexSchemeColor schemeLight = FlexSchemeColor.from(
      primary: MimosaColors.primary,
      secondary: MimosaColors.secondary,
      tertiary: MimosaColors.accent,
      brightness: Brightness.light,
    );
    const double appBarElevation = 0.5;
    const double appBarOpacity = 0.94;
    const bool swapColors = true;
    const FlexKeyColors keyColors = FlexKeyColors(
      useKeyColors: false, // <-- set to true enable M3 seeded ColorScheme.
      useSecondary: true,
      useTertiary: true,
      keepPrimary:
          false, // <-- Keep defined value, do not use the seeded result.
      keepPrimaryContainer: false,
      keepSecondary: false,
      keepSecondaryContainer: false,
      keepTertiary: false,
      keepTertiaryContainer: false,
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => QuestionSet()),
      ],
      child: MaterialApp(
        title: 'Mimosa',
        debugShowCheckedModeBanner: false,
        theme: FlexColorScheme.light(
          colors: schemeLight,
          appBarElevation: appBarElevation,
          appBarOpacity: appBarOpacity,
          appBarStyle: FlexAppBarStyle.primary,
          tooltipsMatchBackground: true,
          swapColors: swapColors,
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          keyColors: keyColors,
        ).toTheme.copyWith(
              scrollbarTheme: const ScrollbarThemeData().copyWith(
                thumbVisibility: WidgetStateProperty.all<bool>(true),
              ),
            ),
        initialRoute: RouteGenerator.homepage,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
