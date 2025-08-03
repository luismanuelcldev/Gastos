import 'package:flutter/material.dart';

class Categoria {
  final String nombre;
  final String icono;
  final Color color;

  const Categoria({
    required this.nombre,
    required this.icono,
    required this.color,
  });

  Map<String, dynamic> toJson() => {
    'nombre': nombre,
    'icono': icono,
    // ignore: deprecated_member_use
    'color': color.value,
  };

  factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
    nombre: json['nombre'] as String,
    icono: json['icono'] as String,
    color: Color(json['color'] as int),
  );
}
