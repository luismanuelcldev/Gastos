import 'package:go_router/go_router.dart';
import '../views/resumen_view.dart';
import '../views/agregar_gasto_view.dart';
import '../views/categorias_view.dart';
import '../views/presupuestos_view.dart';
import '../views/exportar_view.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ResumenView(),
      routes: [
        GoRoute(
          path: 'agregar',
          builder: (context, state) => const AgregarGastoView(),
        ),
        GoRoute(
          path: 'categorias',
          builder: (context, state) => const VistaCategorias(),
        ),
        GoRoute(
          path: 'presupuestos',
          builder: (context, state) => const VistaPresupuestos(),
        ),
        GoRoute(
          path: 'exportar',
          builder: (context, state) => const VistaExportar(),
        ),
      ],
    ),
  ],
);
