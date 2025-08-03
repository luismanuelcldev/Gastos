import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/gasto.dart';

class GastosRepository {
  static const String _key = 'gastos';
  final SharedPreferences _prefs;

  GastosRepository(this._prefs);

  List<Gasto> obtenerGastos() {
    final gastosJson = _prefs.getStringList(_key) ?? [];
    return gastosJson.map((json) => Gasto.fromJson(jsonDecode(json))).toList();
  }

  Future<void> agregarGasto(Gasto gasto) async {
    final gastos = obtenerGastos();
    gastos.add(gasto);
    await _guardarGastos(gastos);
  }

  Future<void> eliminarGasto(String id) async {
    final gastos = obtenerGastos();
    gastos.removeWhere((g) => g.id == id);
    await _guardarGastos(gastos);
  }

  Future<void> _guardarGastos(List<Gasto> gastos) async {
    final gastosJson = gastos.map((g) => g.toRawJson()).toList();
    await _prefs.setStringList(_key, gastosJson);
  }
}
