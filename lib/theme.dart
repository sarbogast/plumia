import 'package:flutter/material.dart';

extension ColorToMaterial on Color {
  MaterialColor toMaterial() {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = red, g = green, b = blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(value, swatch);
  }
}

ThemeData buildTheme(BuildContext context) {
  final colorScheme = ColorScheme.fromSwatch(
    primarySwatch: const Color(0xff5fa0ff).toMaterial(),
  ).copyWith(
    brightness: Brightness.dark,
    background: const Color(0xff131113),
    onBackground: const Color(0xfff6e8d7),
    onPrimary: Colors.black,
  );

  return ThemeData(
    primaryColor: colorScheme.primary,
    selectedRowColor: const Color(0xff212125).toMaterial(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    buttonTheme: ButtonTheme.of(context).copyWith(
      buttonColor: colorScheme.primary,
      textTheme: ButtonTextTheme.accent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          const Set<MaterialState> nonInteractiveStates = <MaterialState>{
            MaterialState.disabled,
          };
          if (states.any(nonInteractiveStates.contains)) {
            return Colors.grey;
          }
          return colorScheme.primary;
        }),
        foregroundColor: MaterialStateProperty.all<Color>(
          Colors.black,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: Theme.of(context).textTheme.headline6!.copyWith(
            color: colorScheme.onBackground,
          ),
      contentPadding: const EdgeInsets.only(bottom: 6),
      fillColor: const Color(0xff1A1A1A),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: colorScheme.primary,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(primary: colorScheme.onBackground),
    ),
    chipTheme: ChipThemeData.fromDefaults(
      primaryColor: colorScheme.onPrimary,
      secondaryColor: colorScheme.onBackground,
      labelStyle: const TextStyle(color: Colors.black),
    ).copyWith(
      elevation: 2,
    ),
    colorScheme: colorScheme,
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        const Set<MaterialState> nonInteractiveStates = <MaterialState>{
          MaterialState.disabled,
        };
        if (states.any(nonInteractiveStates.contains)) {
          return Colors.grey;
        }
        return colorScheme.primary;
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        const Set<MaterialState> nonInteractiveStates = <MaterialState>{
          MaterialState.disabled,
        };
        if (states.any(nonInteractiveStates.contains)) {
          return Colors.grey.shade300;
        }
        return Colors.grey;
      }),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: colorScheme.secondary,
      linearTrackColor: Colors.grey,
      circularTrackColor: Colors.grey,
    ),
    tabBarTheme: TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: colorScheme.secondary,
          width: 2,
        ),
      ),
    ),
  );
}
