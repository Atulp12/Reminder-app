import 'package:flutter/material.dart';
import 'package:reminder_app/core/theme/app_pallete.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );
  static final darkThemeMode = ThemeData.dark().copyWith(
   
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.backgroundColor,
    ),
    textTheme: TextTheme(
      headlineSmall: const TextStyle(fontFamily: 'ClashGrotesk'),
      titleLarge: const TextStyle(fontFamily: 'ClashGrotesk'),
      titleSmall: const TextStyle(fontFamily: 'ClashGrotesk',fontSize: 14),
      bodyMedium: TextStyle(fontFamily: 'ClashGrotesk',fontSize: 14,color: Colors.grey.shade300)
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppPallete.borderColor,
        foregroundColor: AppPallete.whiteColor),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(20),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.gradient1),
      errorBorder: _border(AppPallete.errorColor),
    ),
    
  );
}
