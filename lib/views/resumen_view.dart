import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/gastos_cubit.dart';
import '../widgets/grafico_categorias.dart';
import '../widgets/lista_gastos.dart';

// Vista principal que muestra el resumen de gastos y gráficos
class ResumenView extends StatelessWidget {
  const ResumenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFD32F2F), // Rojo
              Color(0xFFFFCDD2), // Rojo claro
              Colors.white,
            ],
            stops: [0.0, 0.3, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header personalizado
              _buildHeader(context),
              // Contenido principal
              const Expanded(child: _ContenidoResumen()),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFD32F2F).withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: FloatingActionButton.extended(
          onPressed: () => context.push('/agregar'),
          icon: const Icon(Icons.add, size: 24),
          label: const Text(
            'Nuevo Gasto',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  // Construye el encabezado de la vista
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Control de Gastos',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Gestiona tu dinero inteligentemente',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () => context.push('/exportar'),
              icon: const Icon(Icons.download, color: Colors.white, size: 28),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget que contiene el gráfico y la lista de gastos
class _ContenidoResumen extends StatelessWidget {
  const _ContenidoResumen();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GastosCubit, GastosState>(
      builder: (context, state) {
        if (state.alerta != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.warning, color: Colors.white),
                    const SizedBox(width: 8),
                    Expanded(child: Text(state.alerta!)),
                  ],
                ),
                backgroundColor: const Color(0xFFD32F2F),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
            context.read<GastosCubit>().limpiarAlerta();
          });
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              // Tarjeta del gráfico
              Card(
                elevation: 12,
                child: Container(
                  height: 240,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD32F2F).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.bar_chart,
                              color: Color(0xFFD32F2F),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Gastos por Categoría',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: GraficoCategorias(
                          resumen: state.resumenPorCategoria,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Tarjeta de la lista
              Expanded(
                child: Card(
                  elevation: 12,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFD32F2F).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.list,
                                color: Color(0xFFD32F2F),
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Historial de Gastos',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Expanded(child: ListaGastos(gastos: state.gastos)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
