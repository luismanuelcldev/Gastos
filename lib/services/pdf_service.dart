import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/gasto.dart';

class ServicioPDF {
  static Future<File> generarPDF(List<Gasto> gastos) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build:
            (pw.Context context) => pw.Column(
              children: [
                pw.Header(
                  level: 0,
                  child: pw.Text(
                    'Reporte de Gastos',
                    style: const pw.TextStyle(fontSize: 24),
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.TableHelper.fromTextArray(
                  context: context,
                  headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  data: [
                    ['Descripción', 'Categoría', 'Monto', 'Fecha'],
                    ...gastos.map(
                      (g) => [
                        g.descripcion,
                        g.categoria,
                        '\$${g.monto.toStringAsFixed(2)}',
                        DateFormat('dd/MM/yyyy').format(g.fecha),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Total gastado: \$${_calcularTotal(gastos)}',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/reporte_gastos.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  static String _calcularTotal(List<Gasto> gastos) {
    return gastos.fold(0.0, (sum, g) => sum + g.monto).toStringAsFixed(2);
  }
}
