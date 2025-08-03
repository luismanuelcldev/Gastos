import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/gasto.dart';

class ListaGastos extends StatelessWidget {
  final List<Gasto> gastos;

  const ListaGastos({super.key, required this.gastos});

  @override
  Widget build(BuildContext context) {
    if (gastos.isEmpty) {
      return const Center(child: Text('No hay gastos registrados'));
    }

    return ListView.builder(
      itemCount: gastos.length,
      itemBuilder: (context, index) {
        final gasto = gastos[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue[100],
              child: Text(
                gasto.categoria[0],
                style: const TextStyle(color: Colors.blue),
              ),
            ),
            title: Text(gasto.descripcion),
            subtitle: Text(DateFormat('dd/MM/yyyy').format(gasto.fecha)),
            trailing: Text(
              '\$${gasto.monto.toStringAsFixed(2)}',
              style: TextStyle(
                color: gasto.monto > 100 ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
