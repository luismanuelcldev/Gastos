import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../cubit/gastos_cubit.dart';
import '../models/gasto.dart';
import '../widgets/input_gasto.dart';

// Vista para agregar un nuevo gasto
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
    // Obtengo las categorías disponibles desde el estado
    final categorias = context.watch<GastosCubit>().state.categorias;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD32F2F), Color(0xFFFFCDD2), Colors.white],
            stops: [0.0, 0.3, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(context),
              // Formulario de ingreso de datos
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Información del Gasto',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFD32F2F),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Campo Monto
                          _buildStyledField(
                            child: InputGasto(
                              controller: _montoController,
                              label: 'Monto (\$)',
                              icon: Icons.attach_money,
                              keyboardType: TextInputType.number,
                              validator: _validarMonto,
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Campo Categoría
                          _buildStyledField(
                            child: DropdownButtonFormField<String>(
                              value: _categoriaSeleccionada,
                              decoration: const InputDecoration(
                                labelText: 'Categoría',
                                prefixIcon: Icon(Icons.category),
                              ),
                              items:
                                  categorias
                                      .map(
                                        (c) => DropdownMenuItem(
                                          value: c.nombre,
                                          child: Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(
                                                  8,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: const Color(
                                                    0xFFD32F2F,
                                                  ).withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Icon(
                                                  _getIconData(c.icono),
                                                  color: const Color(
                                                    0xFFD32F2F,
                                                  ),
                                                  size: 20,
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Text(c.nombre),
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList(),
                              onChanged:
                                  (value) => setState(
                                    () => _categoriaSeleccionada = value!,
                                  ),
                              validator:
                                  (value) =>
                                      value == null
                                          ? 'Seleccione una categoría'
                                          : null,
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Campo Descripción
                          _buildStyledField(
                            child: InputGasto(
                              controller: _descripcionController,
                              label: 'Descripción',
                              icon: Icons.description,
                              validator: _validarDescripcion,
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Campo Fecha
                          _buildStyledField(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: ListTile(
                                leading: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFFD32F2F,
                                    ).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.calendar_today,
                                    color: Color(0xFFD32F2F),
                                  ),
                                ),
                                title: const Text('Fecha del Gasto'),
                                subtitle: Text(
                                  DateFormat(
                                    'dd/MM/yyyy',
                                  ).format(_fechaSeleccionada),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFD32F2F),
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Color(0xFFD32F2F),
                                ),
                                onTap: _seleccionarFecha,
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Botón guardar
                          Container(
                            width: double.infinity,
                            height: 56,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFD32F2F), Color(0xFFB71C1C)],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFFD32F2F,
                                  ).withOpacity(0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: _guardarGasto,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.save, color: Colors.white),
                                  SizedBox(width: 8),
                                  Text(
                                    'Guardar Gasto',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Construyo el encabezado de la vista
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          const SizedBox(width: 16),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nuevo Gasto',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Registra tu gasto aquí',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Envuelvo los campos con un estilo común
  Widget _buildStyledField({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }

  // Valido que el monto sea un número positivo
  String? _validarMonto(String? value) {
    if (value == null || value.isEmpty) return 'Ingrese un monto';
    if (double.tryParse(value) == null) return 'Monto inválido';
    if (double.parse(value) <= 0) return 'El monto debe ser mayor a 0';
    return null;
  }

  // Valido que la descripción tenga al menos 3 caracteres
  String? _validarDescripcion(String? value) {
    if (value == null || value.isEmpty) return 'Ingrese una descripción';
    if (value.length < 3) return 'Mínimo 3 caracteres';
    return null;
  }

  // Obtengo el icono correspondiente al nombre de la categoría
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

  // Muestro el selector de fecha
  Future<void> _seleccionarFecha() async {
    final fecha = await showDatePicker(
      context: context,
      initialDate: _fechaSeleccionada,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFD32F2F),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (fecha != null) {
      setState(() => _fechaSeleccionada = fecha);
    }
  }

  // Guardo el gasto en el estado global
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

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 8),
              Text('¡Gasto guardado exitosamente!'),
            ],
          ),
          backgroundColor: const Color(0xFFD32F2F),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );

      Navigator.pop(context);
    }
  }
}
