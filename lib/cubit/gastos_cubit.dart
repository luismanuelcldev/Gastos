import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/gasto.dart';
import '../models/categoria.dart';
import '../models/presupuesto.dart';
import '../repositories/gastos_repository.dart';
import '../repositories/categorias_repository.dart';
import '../repositories/presupuesto_repository.dart';

part 'gastos_state.dart';

// Cubit que gestiona el estado global de la aplicación (gastos, categorías, presupuestos)
class GastosCubit extends Cubit<GastosState> {
  final GastosRepository _gastosRepository;
  final CategoriasRepository _categoriasRepository;
  final PresupuestoRepository _presupuestoRepository;

  // Inicializo el Cubit con los repositorios necesarios y un estado inicial vacío
  GastosCubit({
    required GastosRepository gastosRepository,
    required CategoriasRepository categoriasRepository,
    required PresupuestoRepository presupuestoRepository,
  }) : _gastosRepository = gastosRepository,
       _categoriasRepository = categoriasRepository,
       _presupuestoRepository = presupuestoRepository,
       super(GastosState.init());

  // Cargo todos los datos almacenados al iniciar la aplicación
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

  // Agrego un nuevo gasto y verifico si excede algún presupuesto
  Future<void> agregarGasto(Gasto gasto) async {
    await _gastosRepository.agregarGasto(gasto);
    final gastos = _gastosRepository.obtenerGastos();
    emit(state.copyWith(gastos: gastos));
    _verificarPresupuestos(gasto);
  }

  // Agrego una nueva categoría al sistema
  Future<void> agregarCategoria(Categoria categoria) async {
    await _categoriasRepository.agregarCategoria(categoria);
    final categorias = _categoriasRepository.obtenerCategorias();
    emit(state.copyWith(categorias: categorias));
  }

  // Configuro o actualizo un presupuesto para una categoría
  Future<void> configurarPresupuesto(Presupuesto presupuesto) async {
    await _presupuestoRepository.guardarPresupuesto(presupuesto);
    final presupuestos = _presupuestoRepository.obtenerPresupuestos();
    emit(state.copyWith(presupuestos: presupuestos));
  }

  // Elimino un presupuesto existente
  Future<void> eliminarPresupuesto(String categoria) async {
    await _presupuestoRepository.eliminarPresupuesto(categoria);
    final presupuestos = _presupuestoRepository.obtenerPresupuestos();
    emit(state.copyWith(presupuestos: presupuestos));
  }

  // Elimino un gasto por su ID
  Future<void> eliminarGasto(String id) async {
    await _gastosRepository.eliminarGasto(id);
    final gastos = _gastosRepository.obtenerGastos();
    emit(state.copyWith(gastos: gastos));
  }

  // Limpio cualquier mensaje de alerta activo en el estado
  void limpiarAlerta() {
    emit(state.copyWith(alerta: null));
  }

  // Verifico si un gasto recién agregado hace que se supere el presupuesto de su categoría
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
    } catch (_) {}
  }

  // Elimino una categoría del sistema
  Future<void> eliminarCategoria(String nombre) async {
    await _categoriasRepository.eliminarCategoria(nombre);
    final categorias = _categoriasRepository.obtenerCategorias();
    emit(state.copyWith(categorias: categorias));
  }

  // Actualizo los datos de una categoría existente
  Future<void> actualizarCategoria(
    String nombreOriginal,
    Categoria nuevaCategoria,
  ) async {
    await _categoriasRepository.actualizarCategoria(
      nombreOriginal,
      nuevaCategoria,
    );
    final categorias = _categoriasRepository.obtenerCategorias();
    emit(state.copyWith(categorias: categorias));
  }
}
