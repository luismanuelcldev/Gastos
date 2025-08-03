import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/presupuesto.dart';

class PresupuestoRepository {
  static const String _key = 'presupuestos';
  final SharedPreferences _prefs;

  PresupuestoRepository(this._prefs);

  List<Presupuesto> obtenerPresupuestos() {
    final presupuestosJson = _prefs.getStringList(_key) ?? [];
    return presupuestosJson
        .map((json) => Presupuesto.fromJson(jsonDecode(json)))
        .toList();
  }

  Future<void> guardarPresupuesto(Presupuesto presupuesto) async {
    final presupuestos = obtenerPresupuestos();
    final index = presupuestos.indexWhere(
      (p) => p.categoria == presupuesto.categoria,
    );

    if (index >= 0) {
      presupuestos[index] = presupuesto;
    } else {
      presupuestos.add(presupuesto);
    }

    await _guardarPresupuestos(presupuestos);
  }

  Future<void> _guardarPresupuestos(List<Presupuesto> presupuestos) async {
    final presupuestosJson =
        presupuestos.map((p) => jsonEncode(p.toJson())).toList();
    await _prefs.setStringList(_key, presupuestosJson);
  }
}
