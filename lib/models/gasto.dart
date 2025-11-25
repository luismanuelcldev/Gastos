import 'dart:convert';

// Modelo que representa un gasto individual
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

  // Serializo el objeto a un mapa JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'monto': monto,
    'categoria': categoria,
    'fecha': fecha.toIso8601String(),
    'descripcion': descripcion,
  };

  // Deserializo un mapa JSON a una instancia de Gasto
  factory Gasto.fromJson(Map<String, dynamic> json) => Gasto(
    id: json['id'] as String,
    monto: (json['monto'] as num).toDouble(),
    categoria: json['categoria'] as String,
    fecha: DateTime.parse(json['fecha'] as String),
    descripcion: json['descripcion'] as String,
  );

  // Convierto el objeto directamente a una cadena JSON
  String toRawJson() => jsonEncode(toJson());
}
