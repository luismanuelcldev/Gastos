import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/gastos_cubit.dart';
import '../models/gasto.dart';
import '../services/pdf_service.dart';
import '../services/csv_service.dart';

class VistaExportar extends StatelessWidget {
  const VistaExportar({super.key});

  @override
  Widget build(BuildContext context) {
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
              // Content
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: BlocBuilder<GastosCubit, GastosState>(
                    builder: (context, state) {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Título de la sección
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFFD32F2F,
                                    ).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.file_download,
                                    color: Color(0xFFD32F2F),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Exportar Datos',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFD32F2F),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Genera reportes de tus gastos en diferentes formatos',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 32),

                            // Estadísticas rápidas
                            _buildEstadisticas(state),
                            const SizedBox(height: 32),

                            // Opciones de exportación
                            const Text(
                              'Selecciona el formato de exportación:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFD32F2F),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Botón PDF
                            _BotonExportar(
                              icono: Icons.picture_as_pdf,
                              titulo: 'Exportar a PDF',
                              descripcion:
                                  'Reporte profesional con gráficos y tablas',
                              color: const Color(0xFFD32F2F),
                              onPressed:
                                  () => _exportarPDF(context, state.gastos),
                            ),
                            const SizedBox(height: 16),

                            // Botón CSV
                            _BotonExportar(
                              icono: Icons.table_chart,
                              titulo: 'Exportar a CSV',
                              descripcion:
                                  'Datos en formato de hoja de cálculo',
                              color: const Color(0xFF2E7D32),
                              onPressed:
                                  () => _exportarCSV(context, state.gastos),
                            ),
                            const SizedBox(height: 32),

                            // Información adicional
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xFFD32F2F).withOpacity(0.1),
                                    const Color(0xFFFFCDD2).withOpacity(0.1),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: const Color(
                                    0xFFD32F2F,
                                  ).withOpacity(0.2),
                                ),
                              ),
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.info_outline,
                                    color: Color(0xFFD32F2F),
                                    size: 32,
                                  ),
                                  const SizedBox(height: 12),
                                  const Text(
                                    'Información sobre la exportación',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFD32F2F),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '• PDF: Incluye gráficos, tablas y resumen por categorías\n'
                                    '• CSV: Compatible con Excel, Sheets y otras aplicaciones\n'
                                    '• Los archivos se guardan en la carpeta de descargas',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
                'Exportar Datos',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Genera reportes de tus gastos',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEstadisticas(GastosState state) {
    final totalGastos = state.gastos.fold(
      0.0,
      (sum, gasto) => sum + gasto.monto,
    );
    final cantidadGastos = state.gastos.length;
    final categorias = state.resumenPorCategoria.keys.length;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFD32F2F), Color(0xFFB71C1C)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD32F2F).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(Icons.analytics, color: Colors.white, size: 24),
              SizedBox(width: 8),
              Text(
                'Resumen de tus datos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _EstadisticaItem(
                  titulo: 'Total Gastado',
                  valor: '\$${totalGastos.toStringAsFixed(2)}',
                  icono: Icons.attach_money,
                ),
              ),
              Expanded(
                child: _EstadisticaItem(
                  titulo: 'Gastos Registrados',
                  valor: cantidadGastos.toString(),
                  icono: Icons.receipt_long,
                ),
              ),
              Expanded(
                child: _EstadisticaItem(
                  titulo: 'Categorías',
                  valor: categorias.toString(),
                  icono: Icons.category,
                ),
              ),
            ],
          ),
        ],
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
          'PDF generado exitosamente',
          accion: SnackBarAction(
            label: 'Abrir',
            textColor: Colors.white,
            onPressed: () {
              // Aquí podrías implementar la apertura del archivo
            },
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
          'CSV generado exitosamente',
          accion: SnackBarAction(
            label: 'Abrir',
            textColor: Colors.white,
            onPressed: () {
              // Aquí podrías implementar la apertura del archivo
            },
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.info, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(mensaje)),
          ],
        ),
        backgroundColor: const Color(0xFFD32F2F),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        action: accion,
      ),
    );
  }
}

class _BotonExportar extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final String descripcion;
  final Color color;
  final VoidCallback onPressed;

  const _BotonExportar({
    required this.icono,
    required this.titulo,
    required this.descripcion,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: color.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color, color.withOpacity(0.8)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icono, color: Colors.white, size: 32),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titulo,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        descripcion,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: color, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EstadisticaItem extends StatelessWidget {
  final String titulo;
  final String valor;
  final IconData icono;

  const _EstadisticaItem({
    required this.titulo,
    required this.valor,
    required this.icono,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Icon(icono, color: Colors.white, size: 28),
          const SizedBox(height: 8),
          Text(
            valor,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            titulo,
            style: const TextStyle(fontSize: 12, color: Colors.white70),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
