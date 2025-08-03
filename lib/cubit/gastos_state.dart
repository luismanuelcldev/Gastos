part of 'gastos_cubit.dart';

class GastosState {
  final List<Gasto> gastos;
  final List<Categoria> categorias;
  final List<Presupuesto> presupuestos;
  final String? alerta;

  GastosState({
    required this.gastos,
    required this.categorias,
    required this.presupuestos,
    this.alerta,
  });

  factory GastosState.init() =>
      GastosState(gastos: [], categorias: [], presupuestos: []);

  GastosState copyWith({
    List<Gasto>? gastos,
    List<Categoria>? categorias,
    List<Presupuesto>? presupuestos,
    String? alerta,
  }) {
    return GastosState(
      gastos: gastos ?? this.gastos,
      categorias: categorias ?? this.categorias,
      presupuestos: presupuestos ?? this.presupuestos,
      alerta: alerta,
    );
  }

  Map<String, double> get resumenPorCategoria {
    final resumen = <String, double>{};

    for (final categoria in categorias) {
      final total = gastos
          .where((g) => g.categoria == categoria.nombre)
          .fold(0.0, (sum, g) => sum + g.monto);

      if (total > 0) {
        resumen[categoria.nombre] = total;
      }
    }

    return resumen;
  }
}
