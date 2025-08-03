class Presupuesto {
  final String categoria;
  final double limite;
  final double alerta;

  const Presupuesto({
    required this.categoria,
    required this.limite,
    required this.alerta,
  });

  Map<String, dynamic> toJson() => {
    'categoria': categoria,
    'limite': limite,
    'alerta': alerta,
  };

  factory Presupuesto.fromJson(Map<String, dynamic> json) => Presupuesto(
    categoria: json['categoria'] as String,
    limite: (json['limite'] as num).toDouble(),
    alerta: (json['alerta'] as num).toDouble(),
  );
}
