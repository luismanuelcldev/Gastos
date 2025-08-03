import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/gasto.dart';

class ServicioCSV {
  static Future<File> generarCSV(List<Gasto> gastos) async {
    final datosCSV = _convertirACSV(gastos);
    final directorio = await getTemporaryDirectory();
    final archivo = File('${directorio.path}/reporte_gastos.csv');
    await archivo.writeAsString(datosCSV);
    return archivo;
  }

  static String _convertirACSV(List<Gasto> gastos) {
    const encabezados = 'Descripción,Categoría,Monto,Fecha\n';
    final filas = gastos.map(
      (g) =>
          '"${g.descripcion.replaceAll('"', '""')}",'
          '"${g.categoria.replaceAll('"', '""')}",'
          '${g.monto.toStringAsFixed(2)},'
          '${g.fecha.toIso8601String()}',
    );
    return encabezados + filas.join('\n');
  }
}
