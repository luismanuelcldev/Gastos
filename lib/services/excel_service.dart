import 'package:excel/excel.dart';
import 'package:intl/intl.dart';
import '../models/gasto.dart';

// Servicio encargado de generar archivos Excel con los datos de gastos
class ServicioExcel {
  // Genero un archivo Excel a partir de una lista de gastos
  static Future<List<int>?> generarExcel(List<Gasto> gastos) async {
    // Creo una nueva instancia de Excel
    var excel = Excel.createExcel();

    // Renombrar la hoja por defecto
    Sheet sheetObject = excel['Gastos'];
    excel.delete('Sheet1'); // Borrar la hoja por defecto si existe

    // Agregar encabezados
    var headers = ['Descripción', 'Categoría', 'Monto', 'Fecha', 'Hora'];
    sheetObject.appendRow(headers.map((e) => TextCellValue(e)).toList());

    // Agregar datos iterando sobre la lista de gastos
    for (var gasto in gastos) {
      sheetObject.appendRow([
        TextCellValue(gasto.descripcion),
        TextCellValue(gasto.categoria),
        DoubleCellValue(gasto.monto),
        TextCellValue(DateFormat('dd/MM/yyyy').format(gasto.fecha)),
        TextCellValue(DateFormat('HH:mm').format(gasto.fecha)),
      ]);
    }

    // Guardo el archivo y retorno los bytes
    return excel.save();
  }
}
