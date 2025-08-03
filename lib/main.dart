import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/app.dart';
import 'cubit/gastos_cubit.dart';
import 'repositories/gastos_repository.dart';
import 'repositories/categorias_repository.dart';
import 'repositories/presupuesto_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => GastosCubit(
                gastosRepository: GastosRepository(prefs),
                categoriasRepository: CategoriasRepository(prefs),
                presupuestoRepository: PresupuestoRepository(prefs),
              )..cargarDatosIniciales(),
        ),
      ],
      child: const AppGastos(),
    ),
  );
}
