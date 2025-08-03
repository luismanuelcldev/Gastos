import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/gasto.dart';
import '../models/categoria.dart';
import '../models/presupuesto.dart';
import '../repositories/gastos_repository.dart';
import '../repositories/categorias_repository.dart';
import '../repositories/presupuesto_repository.dart';

part 'gastos_state.dart';

class GastosCubit extends Cubit<GastosState> {
  final GastosRepository _gastosRepository;
  final CategoriasRepository _categoriasRepository;
  final PresupuestoRepository _presupuestoRepository;

  GastosCubit({
    required GastosRepository gastosRepository,
    required CategoriasRepository categoriasRepository,
    required PresupuestoRepository presupuestoRepository,
  }) : _gastosRepository = gastosRepository,
       _categoriasRepository = categoriasRepository,
       _presupuestoRepository = presupuestoRepository,
       super(GastosState.init());

  void cargarDatosIniciales() {
    final categorias = _categoriasRepository.obtenerCategorias();
    final gastos = _gastosRepository.obtenerGastos();
    final presupuestos = _presupuestoRepository.obtenerPresupuestos();

    emit(
      state.copyWith(
        categorias: categorias,
        gastos: gastos,
        presupuestos: presupuestos,
      ),
    );
  }

  void agregarGasto(Gasto gasto) {
    _gastosRepository.agregarGasto(gasto);
    final gastos = _gastosRepository.obtenerGastos();
    emit(state.copyWith(gastos: gastos));
    _verificarPresupuestos(gasto);
  }

  void agregarCategoria(Categoria categoria) {
    _categoriasRepository.agregarCategoria(categoria);
    final categorias = _categoriasRepository.obtenerCategorias();
    emit(state.copyWith(categorias: categorias));
  }

  void guardarPresupuesto(Presupuesto presupuesto) {
    _presupuestoRepository.guardarPresupuesto(presupuesto);
    final presupuestos = _presupuestoRepository.obtenerPresupuestos();
    emit(state.copyWith(presupuestos: presupuestos));
  }

  void limpiarAlerta() {
    emit(state.copyWith(alerta: null));
  }

  void _verificarPresupuestos(Gasto gasto) {
    try {
      final presupuesto = state.presupuestos.firstWhere(
        (p) => p.categoria == gasto.categoria,
      );

      final totalGastos = state.gastos
          .where((g) => g.categoria == gasto.categoria)
          .fold(0.0, (sum, g) => sum + g.monto);

      if (totalGastos >= presupuesto.limite) {
        emit(
          state.copyWith(
            alerta: '¡Has excedido tu presupuesto en ${gasto.categoria}!',
          ),
        );
      } else if (totalGastos >= presupuesto.alerta) {
        emit(
          state.copyWith(
            alerta:
                '¡Cuidado! Estás cerca de exceder tu presupuesto en ${gasto.categoria}',
          ),
        );
      }
    } catch (_) {
      // No hay presupuesto para esta categoría
    }
  }
}
