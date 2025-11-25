import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// Widget que muestra un gráfico de barras con el resumen de gastos por categoría
class GraficoCategorias extends StatelessWidget {
  final Map<String, double> resumen;

  const GraficoCategorias({super.key, required this.resumen});

  @override
  Widget build(BuildContext context) {
    if (resumen.isEmpty) {
      return const Center(child: Text('No hay datos para mostrar'));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: _getMaxValue() * 1.2,
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                final categoria = resumen.keys.elementAt(groupIndex);
                return BarTooltipItem(
                  '$categoria\n\$${rod.toY.toStringAsFixed(2)}',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= 0 && value.toInt() < resumen.length) {
                    final categoria = resumen.keys.elementAt(value.toInt());
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        categoria.length > 8
                            ? '${categoria.substring(0, 8)}...'
                            : categoria,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    );
                  }
                  return const Text('');
                },
                reservedSize: 40,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 50,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '\$${value.toInt()}',
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: _createBarGroups(),
          gridData: const FlGridData(show: true),
        ),
      ),
    );
  }

  // Crea los grupos de barras para el gráfico
  List<BarChartGroupData> _createBarGroups() {
    return resumen.entries.map((entry) {
      final index = resumen.keys.toList().indexOf(entry.key);
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: entry.value,
            color: _getColorForIndex(index),
            width: 20,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
          ),
        ],
      );
    }).toList();
  }

  // Obtiene el valor máximo para escalar el gráfico
  double _getMaxValue() {
    if (resumen.isEmpty) return 0;
    return resumen.values.reduce((a, b) => a > b ? a : b);
  }

  // Asigna un color a cada barra basado en su índice
  Color _getColorForIndex(int index) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
      Colors.amber,
      Colors.indigo,
    ];
    return colors[index % colors.length];
  }
}
