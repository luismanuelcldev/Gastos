import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/gastos_cubit.dart';
import '../models/presupuesto.dart';

class VistaPresupuestos extends StatefulWidget {
  const VistaPresupuestos({super.key});

  @override
  State<VistaPresupuestos> createState() => _VistaPresupuestosState();
}

class _VistaPresupuestosState extends State<VistaPresupuestos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Presupuestos')),
      body: const _ListaPresupuestos(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarDialogoNuevoPresupuesto(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  static void _mostrarDialogoNuevoPresupuesto(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final categoriaController = TextEditingController();
    final limiteController = TextEditingController();
    final alertaController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Nuevo Presupuesto'),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: categoriaController,
                    decoration: const InputDecoration(labelText: 'Categoría'),
                    validator:
                        (value) =>
                            value?.isEmpty ?? true ? 'Ingrese categoría' : null,
                  ),
                  TextFormField(
                    controller: limiteController,
                    decoration: const InputDecoration(labelText: 'Límite'),
                    keyboardType: TextInputType.number,
                    validator:
                        (value) =>
                            value?.isEmpty ?? true ? 'Ingrese límite' : null,
                  ),
                  TextFormField(
                    controller: alertaController,
                    decoration: const InputDecoration(labelText: 'Alerta'),
                    keyboardType: TextInputType.number,
                    validator:
                        (value) =>
                            value?.isEmpty ?? true ? 'Ingrese alerta' : null,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<GastosCubit>().guardarPresupuesto(
                      Presupuesto(
                        categoria: categoriaController.text,
                        limite: double.parse(limiteController.text),
                        alerta: double.parse(alertaController.text),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Guardar'),
              ),
            ],
          ),
    );
  }
}

class _ListaPresupuestos extends StatelessWidget {
  const _ListaPresupuestos();

  @override
  Widget build(BuildContext context) {
    final presupuestos = context.watch<GastosCubit>().state.presupuestos;

    if (presupuestos.isEmpty) {
      return const Center(child: Text('No hay presupuestos configurados'));
    }

    return ListView.builder(
      itemCount: presupuestos.length,
      itemBuilder: (context, index) {
        final presupuesto = presupuestos[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(presupuesto.categoria),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Límite: \$${presupuesto.limite.toStringAsFixed(2)}'),
                Text('Alerta: \$${presupuesto.alerta.toStringAsFixed(2)}'),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _mostrarDialogoEditar(context, presupuesto),
            ),
          ),
        );
      },
    );
  }

  void _mostrarDialogoEditar(BuildContext context, Presupuesto presupuesto) {
    final formKey = GlobalKey<FormState>();
    final limiteController = TextEditingController(
      text: presupuesto.limite.toString(),
    );
    final alertaController = TextEditingController(
      text: presupuesto.alerta.toString(),
    );

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Editar ${presupuesto.categoria}'),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(presupuesto.categoria),
                  TextFormField(
                    controller: limiteController,
                    decoration: const InputDecoration(labelText: 'Límite'),
                    keyboardType: TextInputType.number,
                    validator:
                        (value) =>
                            value?.isEmpty ?? true ? 'Ingrese límite' : null,
                  ),
                  TextFormField(
                    controller: alertaController,
                    decoration: const InputDecoration(labelText: 'Alerta'),
                    keyboardType: TextInputType.number,
                    validator:
                        (value) =>
                            value?.isEmpty ?? true ? 'Ingrese alerta' : null,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<GastosCubit>().guardarPresupuesto(
                      Presupuesto(
                        categoria: presupuesto.categoria,
                        limite: double.parse(limiteController.text),
                        alerta: double.parse(alertaController.text),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Guardar'),
              ),
            ],
          ),
    );
  }
}
