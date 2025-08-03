import 'dart:convert';

class Gasto {
  final String id;
  final double monto;
  final String categoria;
  final DateTime fecha;
  final String descripcion;

  const Gasto({
    required this.id,
    required this.monto,
    required this.categoria,
    required this.fecha,
    required this.descripcion,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'monto': monto,
    'categoria': categoria,
    'fecha': fecha.toIso8601String(),
    'descripcion': descripcion,
  };

  factory Gasto.fromJson(Map<String, dynamic> json) => Gasto(
    id: json['id'] as String,
    monto: (json['monto'] as num).toDouble(),
    categoria: json['categoria'] as String,
    fecha: DateTime.parse(json['fecha'] as String),
    descripcion: json['descripcion'] as String,
  );

  String toRawJson() => jsonEncode(toJson());
}
