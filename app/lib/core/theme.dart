import 'package:flutter/material.dart';

import 'colors.dart';

/// ===========================================================
/// ELECTROCHILE
/// Tema oficial de la aplicación
/// ===========================================================
class ECTheme {
  ECTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,

      brightness: Brightness.light,

      scaffoldBackgroundColor: ECColors.background,

      colorScheme: ColorScheme.fromSeed(
        seedColor: ECColors.primary,
        primary: ECColors.primary,
        secondary: ECColors.secondary,
        background: ECColors.background,
        surface: ECColors.surface,
        brightness: Brightness.light,
      ),

      //--------------------------------------------
      // APP BAR
      //--------------------------------------------
      appBarTheme: const AppBarTheme(
        backgroundColor: ECColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      //--------------------------------------------
      // TARJETAS
      //--------------------------------------------
      cardTheme: CardThemeData(
        color: ECColors.card,
        elevation: 2,
        shadowColor: ECColors.shadow,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(
            color: ECColors.cardBorder,
          ),
        ),
      ),

      //--------------------------------------------
      // BOTONES
      //--------------------------------------------
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ECColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 58),
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      //--------------------------------------------
      // INPUTS
      //--------------------------------------------
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: ECColors.divider,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: ECColors.divider,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: ECColors.primary,
            width: 2,
          ),
        ),
      ),

      //--------------------------------------------
      // ICONOS
      //--------------------------------------------
      iconTheme: const IconThemeData(
        color: ECColors.primary,
      ),

      //--------------------------------------------
      // DIVISORES
      //--------------------------------------------
      dividerColor: ECColors.divider,

      //--------------------------------------------
      // TIPOGRAFÍA
      //--------------------------------------------
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: ECColors.textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: ECColors.textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: ECColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: ECColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: ECColors.textSecondary,
        ),
      ),

      //--------------------------------------------
      // SNACKBAR
      //--------------------------------------------
      snackBarTheme: SnackBarThemeData(
        backgroundColor: ECColors.primaryDark,
        contentTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}