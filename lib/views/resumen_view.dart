import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/gastos_cubit.dart';
import '../widgets/grafico_categorias.dart';
import '../widgets/lista_gastos.dart';

class ResumenView extends StatelessWidget {
  const ResumenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen de Gastos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.go('/agregar'),
          ),
        ],
      ),
      body: const _ContenidoResumen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/agregar'),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: _BarraNavegacion(),
    );
  }
}

class _ContenidoResumen extends StatelessWidget {
  const _ContenidoResumen();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GastosCubit, GastosState>(
      builder: (context, state) {
        if (state.alerta != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.alerta!)));
            context.read<GastosCubit>().limpiarAlerta();
          });
        }

        return Column(
          children: [
            Expanded(
              flex: 2,
              child: GraficoCategorias(resumen: state.resumenPorCategoria),
            ),
            const Divider(),
            Expanded(flex: 3, child: ListaGastos(gastos: state.gastos)),
          ],
        );
      },
    );
  }
}

class _BarraNavegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Resumen'),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          label: 'Categorías',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet),
          label: 'Presupuestos',
        ),
      ],
      onTap: (index) {
        if (index == 1) context.go('/categorias');
        if (index == 2) context.go('/presupuestos');
      },
    );
  }
}
