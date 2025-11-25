import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/gasto.dart';

// Repositorio para gestionar la persistencia de los gastos
class GastosRepository {
  static const String _key = 'gastos';
  final SharedPreferences _prefs;

  GastosRepository(this._prefs);

  // Obtengo todos los gastos guardados en el dispositivo
  List<Gasto> obtenerGastos() {
    final gastosJson = _prefs.getStringList(_key) ?? [];
    return gastosJson.map((json) => Gasto.fromJson(jsonDecode(json))).toList();
  }

  // Agrego un nuevo gasto a la lista persistente
  Future<void> agregarGasto(Gasto gasto) async {
    final gastos = obtenerGastos();
    gastos.add(gasto);
    await _guardarGastos(gastos);
  }

  // Elimino un gasto específico usando su ID único
  Future<void> eliminarGasto(String id) async {
    final gastos = obtenerGastos();
    gastos.removeWhere((g) => g.id == id);
    await _guardarGastos(gastos);
  }

  // Método privado para guardar la lista actualizada en SharedPreferences
  Future<void> _guardarGastos(List<Gasto> gastos) async {
    final gastosJson = gastos.map((g) => g.toRawJson()).toList();
    await _prefs.setStringList(_key, gastosJson);
  }
}
