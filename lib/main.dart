import "package:flutter/material.dart";
import "package:expense_tracker/expenses.dart";
// import "package:flutter/services.dart";

final kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 168, 242));

final kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness
        .dark, // by default the color scheme id genertaed for light mode , so we need to specify the brightness
    seedColor: Color.fromARGB(255, 5, 99, 125));

void main() async {
  // WidgetsFlutterBinding
  //     .ensureInitialized(); // This ensures that the WidgetsBinding is initialized before we call SystemChrome.setPreferredOrientations()
  // final fn = await SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp]);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    darkTheme: ThemeData.dark().copyWith(
      useMaterial3: true,
      colorScheme: kDarkColorScheme,
      cardTheme: const CardTheme().copyWith(
        color: kDarkColorScheme.secondaryContainer,
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kDarkColorScheme.primaryContainer,
          foregroundColor: kDarkColorScheme.onPrimaryContainer,
        ),
      ),
    ),
    theme: ThemeData().copyWith(
      useMaterial3: true,
      colorScheme: kColorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: kColorScheme.onPrimaryContainer,
        foregroundColor: kColorScheme.onPrimary,
      ),
      cardTheme: const CardTheme().copyWith(
        color: kColorScheme.secondaryContainer,
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kColorScheme.primaryContainer,
        ),
      ),
      textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: kColorScheme.onSecondaryContainer,
            fontSize: 17,
          )),
    ),
    themeMode: ThemeMode
        .system, // by default the theme mode is ThemeMode.system which means the app will use the theme specified by the device
    title: "Expenses",
    home: const Expenses(),
  ));
}
