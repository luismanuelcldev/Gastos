import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../views/resumen_view.dart';
import '../views/agregar_gasto_view.dart';
import '../views/categorias_view.dart';
import '../views/presupuestos_view.dart';
import '../views/exportar_view.dart';
import '../widgets/scaffold_with_nav_bar.dart';

// Defino las claves globales para la navegación
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

// Configuro las rutas de la aplicación usando GoRouter
final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    // Configuro una ruta Shell para mantener la barra de navegación persistente
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return ScaffoldWithNavBar(child: child);
      },
      routes: [
        // Ruta principal: Resumen
        GoRoute(path: '/', builder: (context, state) => const ResumenView()),
        // Ruta de Categorías
        GoRoute(
          path: '/categorias',
          builder: (context, state) => const VistaCategorias(),
        ),
        // Ruta de Presupuestos
        GoRoute(
          path: '/presupuestos',
          builder: (context, state) => const VistaPresupuestos(),
        ),
      ],
    ),
    // Rutas fuera del Shell (sin barra de navegación inferior)
    GoRoute(
      path: '/agregar',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const AgregarGastoView(),
    ),
    GoRoute(
      path: '/exportar',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const VistaExportar(),
    ),
  ],
);
