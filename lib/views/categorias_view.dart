import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/gastos_cubit.dart';
import '../models/categoria.dart';

class VistaCategorias extends StatelessWidget {
  const VistaCategorias({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categorías')),
      body: const _ListaCategorias(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarDialogoAgregar(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  static void _mostrarDialogoAgregar(BuildContext context) {
    final nombreController = TextEditingController();
    final iconoController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Nueva Categoría'),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nombreController,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                    validator:
                        (value) =>
                            value?.isEmpty ?? true ? 'Ingrese un nombre' : null,
                  ),
                  TextFormField(
                    controller: iconoController,
                    decoration: const InputDecoration(
                      labelText: 'Icono (ej: comida, transporte, hogar)',
                      hintText: 'comida',
                    ),
                    validator:
                        (value) =>
                            value?.isEmpty ?? true ? 'Ingrese un icono' : null,
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
                    context.read<GastosCubit>().agregarCategoria(
                      Categoria(
                        nombre: nombreController.text,
                        icono: iconoController.text,
                        color: Colors.blue,
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

  static IconData _getIconDataStatic(String iconName) {
    switch (iconName.toLowerCase()) {
      case 'food':
      case 'comida':
        return Icons.restaurant;
      case 'transport':
      case 'transporte':
        return Icons.directions_car;
      case 'entertainment':
      case 'entretenimiento':
        return Icons.movie;
      case 'shopping':
      case 'compras':
        return Icons.shopping_cart;
      case 'health':
      case 'salud':
        return Icons.local_hospital;
      case 'education':
      case 'educacion':
        return Icons.school;
      case 'home':
      case 'hogar':
        return Icons.home;
      case 'utilities':
      case 'servicios':
        return Icons.electrical_services;
      default:
        return Icons.category;
    }
  }
}

class _ListaCategorias extends StatelessWidget {
  const _ListaCategorias();

  @override
  Widget build(BuildContext context) {
    final categorias = context.watch<GastosCubit>().state.categorias;

    if (categorias.isEmpty) {
      return const Center(child: Text('No hay categorías registradas'));
    }

    return ListView.builder(
      itemCount: categorias.length,
      itemBuilder: (context, index) {
        final categoria = categorias[index];
        return ListTile(
          leading: Icon(_getIconData(categoria.icono)),
          title: Text(categoria.nombre),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => _confirmarEliminar(context, categoria),
          ),
        );
      },
    );
  }

  IconData _getIconData(String iconName) {
    return VistaCategorias._getIconDataStatic(iconName);
  }

  void _confirmarEliminar(BuildContext context, Categoria categoria) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Eliminar categoría'),
            content: Text('¿Eliminar ${categoria.nombre}?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Implementar eliminación
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${categoria.nombre} eliminada')),
                  );
                },
                child: const Text(
                  'Eliminar',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }
}
