part of 'gastos_cubit.dart';

// Clase inmutable que representa el estado de la aplicación en un momento dado
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

  // Factory para crear el estado inicial vacío
  factory GastosState.init() =>
      GastosState(gastos: [], categorias: [], presupuestos: []);

  // Método para crear una copia del estado con algunos campos modificados
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

  // Getter calculado que agrupa los gastos por categoría para reportes
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
