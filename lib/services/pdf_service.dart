import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:intl/intl.dart';
import 'dart:typed_data';
import '../models/gasto.dart';

// Servicio para la generación de reportes en formato PDF
class ServicioPDF {
  // Genero el documento PDF con el reporte de gastos
  static Future<Uint8List> generarPDF(List<Gasto> gastos) async {
    final pdf = pw.Document();
    // Calculo el total general de gastos
    final total = gastos.fold(0.0, (sum, g) => sum + g.monto);

    // Agrupar por categoría para el resumen
    final porCategoria = <String, double>{};
    for (var g in gastos) {
      porCategoria[g.categoria] = (porCategoria[g.categoria] ?? 0) + g.monto;
    }

    // Añado una página al documento con formato A4
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build:
            (pw.Context context) => [
              // Encabezado del reporte
              pw.Header(
                level: 0,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Reporte de Gastos',
                          style: pw.TextStyle(
                            fontSize: 24,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.red800,
                          ),
                        ),
                        pw.Text(
                          'Generado el: ${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now())}',
                          style: const pw.TextStyle(
                            fontSize: 12,
                            color: PdfColors.grey700,
                          ),
                        ),
                      ],
                    ),
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: pw.BoxDecoration(
                        color: PdfColors.red50,
                        borderRadius: pw.BorderRadius.circular(8),
                      ),
                      child: pw.Text(
                        'Total: \$${total.toStringAsFixed(2)}',
                        style: pw.TextStyle(
                          fontSize: 18,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.red800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),

              // Sección de Resumen por Categoría
              pw.Text(
                'Resumen por Categoría',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.grey800,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Wrap(
                spacing: 10,
                runSpacing: 10,
                children:
                    porCategoria.entries.map((entry) {
                      return pw.Container(
                        width: 150,
                        padding: const pw.EdgeInsets.all(10),
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(color: PdfColors.grey300),
                          borderRadius: pw.BorderRadius.circular(8),
                        ),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              entry.key,
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.grey700,
                              ),
                            ),
                            pw.SizedBox(height: 4),
                            pw.Text(
                              '\$${entry.value.toStringAsFixed(2)}',
                              style: pw.TextStyle(
                                fontSize: 14,
                                color: PdfColors.red800,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
              pw.SizedBox(height: 30),

              // Tabla detallada de movimientos
              pw.Text(
                'Detalle de Movimientos',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.grey800,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.TableHelper.fromTextArray(
                context: context,
                headerDecoration: const pw.BoxDecoration(
                  color: PdfColors.red800,
                ),
                headerStyle: pw.TextStyle(
                  color: PdfColors.white,
                  fontWeight: pw.FontWeight.bold,
                ),
                rowDecoration: const pw.BoxDecoration(
                  border: pw.Border(
                    bottom: pw.BorderSide(color: PdfColors.grey200),
                  ),
                ),
                cellPadding: const pw.EdgeInsets.all(8),
                data: [
                  ['Fecha', 'Categoría', 'Descripción', 'Monto'],
                  ...gastos.map(
                    (g) => [
                      DateFormat('dd/MM/yyyy').format(g.fecha),
                      g.categoria,
                      g.descripcion,
                      '\$${g.monto.toStringAsFixed(2)}',
                    ],
                  ),
                ],
              ),

              // Pie de página del documento
              pw.SizedBox(height: 20),
              pw.Divider(color: PdfColors.grey300),
              pw.Center(
                child: pw.Text(
                  'Control de Gastos App',
                  style: const pw.TextStyle(
                    color: PdfColors.grey500,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
      ),
    );

    // Retorno el documento generado como bytes
    return pdf.save();
  }
}
