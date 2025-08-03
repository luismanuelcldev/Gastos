import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../cubit/gastos_cubit.dart';
import '../models/gasto.dart';
import '../widgets/input_gasto.dart';

class AgregarGastoView extends StatefulWidget {
  const AgregarGastoView({super.key});

  @override
  State<AgregarGastoView> createState() => _AgregarGastoViewState();
}

class _AgregarGastoViewState extends State<AgregarGastoView> {
  final _formKey = GlobalKey<FormState>();
  final _montoController = TextEditingController();
  final _descripcionController = TextEditingController();
  String _categoriaSeleccionada = 'Comida';
  DateTime _fechaSeleccionada = DateTime.now();

  @override
  void dispose() {
    _montoController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categorias = context.watch<GastosCubit>().state.categorias;

    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Gasto')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              InputGasto(
                controller: _montoController,
                label: 'Monto',
                icon: Icons.attach_money,
                keyboardType: TextInputType.number,
                validator: _validarMonto,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _categoriaSeleccionada,
                items:
                    categorias
                        .map(
                          (c) => DropdownMenuItem(
                            value: c.nombre,
                            child: Row(
                              children: [
                                Icon(_getIconData(c.icono)),
                                const SizedBox(width: 8),
                                Text(c.nombre),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                onChanged:
                    (value) => setState(() => _categoriaSeleccionada = value!),
                decoration: const InputDecoration(
                  labelText: 'Categoría',
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) =>
                        value == null ? 'Seleccione una categoría' : null,
              ),
              const SizedBox(height: 16),
              InputGasto(
                controller: _descripcionController,
                label: 'Descripción',
                icon: Icons.description,
                validator: _validarDescripcion,
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: const Text('Fecha'),
                subtitle: Text(
                  DateFormat('dd/MM/yyyy').format(_fechaSeleccionada),
                ),
                trailing: const Icon(Icons.arrow_drop_down),
                onTap: _seleccionarFecha,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _guardarGasto,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Guardar Gasto'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _validarMonto(String? value) {
    if (value == null || value.isEmpty) return 'Ingrese un monto';
    if (double.tryParse(value) == null) return 'Monto inválido';
    return null;
  }

  String? _validarDescripcion(String? value) {
    if (value == null || value.isEmpty) return 'Ingrese una descripción';
    return null;
  }

  IconData _getIconData(String iconName) {
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

  Future<void> _seleccionarFecha() async {
    final fecha = await showDatePicker(
      context: context,
      initialDate: _fechaSeleccionada,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (fecha != null) {
      setState(() => _fechaSeleccionada = fecha);
    }
  }

  void _guardarGasto() {
    if (_formKey.currentState!.validate()) {
      final gasto = Gasto(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        monto: double.parse(_montoController.text),
        categoria: _categoriaSeleccionada,
        fecha: _fechaSeleccionada,
        descripcion: _descripcionController.text,
      );

      context.read<GastosCubit>().agregarGasto(gasto);
      Navigator.pop(context);
    }
  }
}
