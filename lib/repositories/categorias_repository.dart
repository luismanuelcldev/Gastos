import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/categoria.dart';

class CategoriasRepository {
  static const String _key = 'categorias';
  final SharedPreferences _prefs;

  CategoriasRepository(this._prefs);

  List<Categoria> obtenerCategorias() {
    final categoriasJson = _prefs.getStringList(_key) ?? [];
    return categoriasJson.isEmpty
        ? _categoriasDefault()
        : categoriasJson
            .map((json) => Categoria.fromJson(jsonDecode(json)))
            .toList();
  }

  Future<void> agregarCategoria(Categoria categoria) async {
    final categorias = obtenerCategorias();
    categorias.add(categoria);
    await _guardarCategorias(categorias);
  }

  Future<void> _guardarCategorias(List<Categoria> categorias) async {
    final categoriasJson =
        categorias.map((c) => jsonEncode(c.toJson())).toList();
    await _prefs.setStringList(_key, categoriasJson);
  }

  List<Categoria> _categoriasDefault() {
    return const [
      Categoria(nombre: 'Comida', icono: 'restaurant', color: Colors.red),
      Categoria(
        nombre: 'Transporte',
        icono: 'directions_car',
        color: Colors.blue,
      ),
      Categoria(
        nombre: 'Entretenimiento',
        icono: 'sports_esports',
        color: Colors.green,
      ),
      Categoria(
        nombre: 'Servicios',
        icono: 'home_repair_service',
        color: Colors.orange,
      ),
      Categoria(
        nombre: 'Salud',
        icono: 'medical_services',
        color: Colors.purple,
      ),
    ];
  }
}
