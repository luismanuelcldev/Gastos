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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
