import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Widget que implementa la estructura básica de la app con barra de navegación inferior
class EstructuraConBarraNavegacion extends StatelessWidget {
  final Widget hijo;

  const EstructuraConBarraNavegacion({super.key, required this.hijo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: hijo,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _calcularIndiceSeleccionado(context),
          selectedItemColor: const Color(0xFFD32F2F),
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Resumen',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category_rounded),
              label: 'Categorías',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_rounded),
              label: 'Presupuestos',
            ),
          ],
          onTap: (indice) => _alTocarItem(indice, context),
        ),
      ),
    );
  }

  // Calcula el índice seleccionado basado en la ruta actual
  int _calcularIndiceSeleccionado(BuildContext context) {
    final String ubicacion = GoRouterState.of(context).uri.path;
    if (ubicacion.startsWith('/categorias')) {
      return 1;
    }
    if (ubicacion.startsWith('/presupuestos')) {
      return 2;
    }
    if (ubicacion == '/') {
      return 0;
    }
    return 0;
  }

  // Maneja la navegación al tocar un ítem de la barra
  void _alTocarItem(int indice, BuildContext context) {
    switch (indice) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/categorias');
        break;
      case 2:
        context.go('/presupuestos');
        break;
    }
  }
}
