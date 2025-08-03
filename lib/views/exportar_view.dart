import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/pdf_service.dart';
import '../services/csv_service.dart';
import '../cubit/gastos_cubit.dart';
import '../models/gasto.dart';

class VistaExportar extends StatelessWidget {
  const VistaExportar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exportar Datos')),
      body: Center(
        child: BlocBuilder<GastosCubit, GastosState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _BotonExportar(
                  icono: Icons.picture_as_pdf,
                  texto: 'Exportar a PDF',
                  onPressed: () => _exportarPDF(context, state.gastos),
                ),
                const SizedBox(height: 20),
                _BotonExportar(
                  icono: Icons.grid_on,
                  texto: 'Exportar a CSV',
                  onPressed: () => _exportarCSV(context, state.gastos),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _exportarPDF(BuildContext context, List<Gasto> gastos) async {
    if (gastos.isEmpty) {
      _mostrarMensaje(context, 'No hay gastos para exportar');
      return;
    }

    try {
      final archivo = await ServicioPDF.generarPDF(gastos);
      if (context.mounted) {
        _mostrarMensaje(
          context,
          'PDF generado: ${archivo.path}',
          accion: SnackBarAction(
            label: 'Abrir',
            onPressed: () {}, // TODO: Implementar apertura de archivo
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        _mostrarMensaje(context, 'Error al generar PDF: $e');
      }
    }
  }

  Future<void> _exportarCSV(BuildContext context, List<Gasto> gastos) async {
    if (gastos.isEmpty) {
      _mostrarMensaje(context, 'No hay gastos para exportar');
      return;
    }

    try {
      final archivo = await ServicioCSV.generarCSV(gastos);
      if (context.mounted) {
        _mostrarMensaje(
          context,
          'CSV generado: ${archivo.path}',
          accion: SnackBarAction(
            label: 'Abrir',
            onPressed: () {}, // TODO: Implementar apertura de archivo
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        _mostrarMensaje(context, 'Error al generar CSV: $e');
      }
    }
  }

  void _mostrarMensaje(
    BuildContext context,
    String mensaje, {
    SnackBarAction? accion,
  }) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(mensaje), action: accion));
  }
}

class _BotonExportar extends StatelessWidget {
  final IconData icono;
  final String texto;
  final VoidCallback onPressed;

  const _BotonExportar({
    required this.icono,
    required this.texto,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ElevatedButton.icon(
        icon: Icon(icono),
        label: Text(texto),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}
