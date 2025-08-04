import 'package:flutter/material.dart';
import 'router.dart';

class AppGastos extends StatelessWidget {
  const AppGastos({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Control de Gastos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Esquema de colores rojo y blanco
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD32F2F), // Rojo principal
          primary: const Color(0xFFD32F2F),
          secondary: const Color(0xFFFFCDD2), // Rojo claro
          surface: Colors.white,
          background: const Color(0xFFFAFAFA), // Gris muy claro
          error: const Color(0xFFB71C1C),
        ),
        useMaterial3: true,

        // AppBar personalizado
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFD32F2F),
          foregroundColor: Colors.white,
          elevation: 4,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        // Cards personalizadas
        cardTheme: CardTheme(
          elevation: 8,
          shadowColor: Colors.grey.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: Colors.white,
        ),

        // Floating Action Button
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFD32F2F),
          foregroundColor: Colors.white,
          elevation: 8,
        ),

        // Elevated Button
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD32F2F),
            foregroundColor: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        // Input Decoration
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 2),
          ),
          labelStyle: const TextStyle(color: Color(0xFFD32F2F)),
          prefixIconColor: Color(0xFFD32F2F),
        ),
      ),
      routerConfig: router,
    );
  }
}
