import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/presupuesto.dart';

// Repositorio para manejar la persistencia de los presupuestos
class PresupuestoRepository {
  static const String _key = 'presupuestos';
  final SharedPreferences _prefs;

  PresupuestoRepository(this._prefs);

  // Recupero la lista de presupuestos configurados
  List<Presupuesto> obtenerPresupuestos() {
    final presupuestosJson = _prefs.getStringList(_key) ?? [];
    return presupuestosJson
        .map((json) => Presupuesto.fromJson(jsonDecode(json)))
        .toList();
  }

  // Guardo o actualizo un presupuesto para una categoría específica
  Future<void> guardarPresupuesto(Presupuesto presupuesto) async {
    final presupuestos = obtenerPresupuestos();
    final index = presupuestos.indexWhere(
      (p) => p.categoria == presupuesto.categoria,
    );

    if (index >= 0) {
      // Si ya existe, lo actualizo
      presupuestos[index] = presupuesto;
    } else {
      // Si no existe, lo agrego
      presupuestos.add(presupuesto);
    }

    await _guardarPresupuestos(presupuestos);
  }

  // Persisto la lista de presupuestos en el almacenamiento local
  Future<void> _guardarPresupuestos(List<Presupuesto> presupuestos) async {
    final presupuestosJson =
        presupuestos.map((p) => jsonEncode(p.toJson())).toList();
    await _prefs.setStringList(_key, presupuestosJson);
  }

  // Elimino el presupuesto asociado a una categoría
  Future<void> eliminarPresupuesto(String categoria) async {
    final presupuestos = obtenerPresupuestos();
    presupuestos.removeWhere((p) => p.categoria == categoria);
    await _guardarPresupuestos(presupuestos);
  }
}
