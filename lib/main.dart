import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/app.dart';
import 'cubit/gastos_cubit.dart';
import 'repositories/gastos_repository.dart';
import 'repositories/categorias_repository.dart';
import 'repositories/presupuesto_repository.dart';

// Función principal que inicializa la aplicación
void main() async {
  // Aseguro que los bindings de Flutter estén inicializados antes de ejecutar código asíncrono
  WidgetsFlutterBinding.ensureInitialized();

  // Obtengo la instancia de SharedPreferences para la persistencia de datos local
  final prefs = await SharedPreferences.getInstance();

  // Ejecuto la aplicación envolviéndola en los proveedores de estado necesarios
  runApp(
    MultiBlocProvider(
      providers: [
        // Inicializo el Cubit principal con sus repositorios dependientes
        BlocProvider(
          create:
              (context) => GastosCubit(
                gastosRepository: GastosRepository(prefs),
                categoriasRepository: CategoriasRepository(prefs),
                presupuestoRepository: PresupuestoRepository(prefs),
              )..cargarDatosIniciales(), // Cargo los datos guardados al iniciar
        ),
      ],
      child: const AppGastos(),
    ),
  );
}
