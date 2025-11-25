import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/categoria.dart';

// Repositorio encargado de la persistencia de categorías
class CategoriasRepository {
  static const String _key = 'categorias';
  final SharedPreferences _prefs;

  CategoriasRepository(this._prefs);

  // Recupero la lista de categorías almacenadas
  List<Categoria> obtenerCategorias() {
    // Si no existe la clave, devolvemos los defaults (primera ejecución)
    if (!_prefs.containsKey(_key)) {
      final defaults = _categoriasDefault();
      // Guardamos los defaults iniciales para asegurar persistencia inmediata
      _guardarCategorias(defaults);
      return List<Categoria>.from(defaults);
    }

    final categoriasJson = _prefs.getStringList(_key) ?? [];
    return categoriasJson
        .map((json) => Categoria.fromJson(jsonDecode(json)))
        .toList();
  }

  // Añado una nueva categoría y actualizo el almacenamiento
  Future<void> agregarCategoria(Categoria categoria) async {
    final categorias = obtenerCategorias();
    categorias.add(categoria);
    await _guardarCategorias(categorias);
  }

  // Guardo la lista completa de categorías en SharedPreferences
  Future<void> _guardarCategorias(List<Categoria> categorias) async {
    final categoriasJson =
        categorias.map((c) => jsonEncode(c.toJson())).toList();
    await _prefs.setStringList(_key, categoriasJson);
  }

  // Elimino una categoría por su nombre
  Future<void> eliminarCategoria(String nombre) async {
    final categorias = obtenerCategorias();
    categorias.removeWhere((c) => c.nombre == nombre);
    await _guardarCategorias(categorias);
  }

  // Actualizo una categoría existente buscando por su nombre original
  Future<void> actualizarCategoria(
    String nombreOriginal,
    Categoria nuevaCategoria,
  ) async {
    final categorias = obtenerCategorias();
    final index = categorias.indexWhere((c) => c.nombre == nombreOriginal);
    if (index != -1) {
      categorias[index] = nuevaCategoria;
      await _guardarCategorias(categorias);
    }
  }

  // Defino una lista de categorías por defecto para la primera vez que se abre la app
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
