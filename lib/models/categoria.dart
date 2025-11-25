import 'package:flutter/material.dart';

// Modelo que representa una categoría de gastos
class Categoria {
  final String nombre;
  final String icono;
  final Color color;

  const Categoria({
    required this.nombre,
    required this.icono,
    required this.color,
  });

  // Convierto el objeto a un mapa JSON para persistencia
  Map<String, dynamic> toJson() => {
    'nombre': nombre,
    'icono': icono,
    // ignore: deprecated_member_use
    'color': color.value,
  };

  // Creo una instancia desde un mapa JSON recuperado
  factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
    nombre: json['nombre'] as String,
    icono: json['icono'] as String,
    color: Color(json['color'] as int),
  );
}
