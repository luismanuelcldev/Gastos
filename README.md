# 💰 App Control de Gastos Flutter 

## Objetivo del Proyecto:
Desarrollo de una aplicación móvil utilizando Flutter para el control y gestión eficiente de gastos personales. La aplicación permite a los usuarios registrar, categorizar, analizar y exportar sus gastos con funcionalidades como gráficos interactivos, sistema de presupuestos, alertas automáticas y exportación de reportes a PDF y Excel.

> [!NOTE]
> Aplicacion desarrollada con Flutter y arquitectura BLoC para gestión de estado reactivo


## Funcionalidades Principales:

- **Gestión Completa de Gastos:** Crear, visualizar, **editar** y eliminar gastos con información detallada (descripción, categoría, monto, fecha y hora exacta).

- **Sistema de Categorías:** Gestión de categorías personalizadas con íconos intuitivos para clasificar gastos eficientemente.

- **Control de Presupuestos:** Configuración de límites de gasto por categoría con sistema de alertas automáticas.

- **Análisis Visual:** Gráficos de barras interactivos para visualizar gastos por categoría con tooltips informativos.

- **Exportación de Reportes:** Generación de reportes en formato PDF y Excel con guardado directo en **Descargas** y apertura inmediata.

- **Alertas Inteligentes:** Notificaciones automáticas al acercarse o exceder límites de presupuesto.

- **Persistencia Local:** Almacenamiento offline de gastos, categorías y presupuestos usando SharedPreferences.

- **Interfaz Moderna:** Material Design 3 con navegación fluida y experiencia de usuario optimizada.

- **Multiplataforma:** Funcionamiento completo en web, Android, iOS, Windows, macOS y Linux.

- **Navegación Declarativa:** Enrutamiento moderno con GoRouter para transiciones suaves.

- **Validación de Formularios:** Campos obligatorios con validación en tiempo real y mensajes informativos.

## Desarrollador:

- [Luis Manuel De La Cruz Ledesma - Desarrollador](https://luismanueldelacruzldev.tech/)|

## Enlaces:

**Repositorio:** [GitHub Repository](https://github.com/luismanuelcldev/Gastos)

## Capturas de Pantalla

>[!NOTE]
>Aquí se muestra un listado de todas las pantallas desarrolladas.

| Pantalla Resumen Principal | Formulario Agregar Gasto |
|-----------|-----------|
| ![Resumen Principal]() | ![Agregar Gasto]() |

| Gestión de Categorías | Control de Presupuestos |
|-----------|-----------|
| ![Categorías]() | ![Presupuestos]() |

| Pantalla de Exportación |
|-----------|
| ![Exportar Datos]() |

## Arquitectura Técnica

### Stack Tecnológico
- **Framework:** Flutter (Dart SDK >=3.0.0 <4.0.0)
- **Lenguaje:** Dart
- **Arquitectura:** BLoC Pattern (flutter_bloc ^9.1.1)
- **Navegación:** GoRouter ^16.0.0
- **Persistencia:** SharedPreferences ^2.5.3
- **Gráficos:** FL Chart ^1.0.0
- **Internacionalización:** intl ^0.17.0
- **Exportación PDF:** pdf ^3.11.3
- **Exportación Excel:** excel ^4.0.6
- **Compartir Archivos:** share_plus ^12.0.1
- **Archivos:** path_provider ^2.1.4, open_filex ^4.7.0
- **Permisos:** permission_handler ^11.3.0

### Estructura del Proyecto
```
lib/
├── app/                 # Configuración de la aplicación
│   ├── app.dart        # Widget principal de la app
│   └── router.dart     # Configuración de rutas y navegación
├── cubit/              # Gestión de estado (BLoC)
│   ├── gastos_cubit.dart   # Lógica de negocio y manejo de eventos
│   └── gastos_state.dart   # Definición de estados de la aplicación
├── models/             # Modelos de datos
│   ├── gasto.dart          # Modelo de datos para transacciones
│   ├── categoria.dart      # Modelo para clasificación de gastos
│   └── presupuesto.dart    # Modelo para límites de gastos
├── repositories/       # Capa de datos
│   ├── gastos_repository.dart      # Persistencia de gastos
│   ├── categorias_repository.dart  # Persistencia de categorías
│   └── presupuesto_repository.dart # Persistencia de presupuestos
├── services/           # Servicios de exportación
│   ├── excel_service.dart  # Generación de archivos Excel
│   └── pdf_service.dart    # Generación de reportes PDF
├── views/              # Interfaces de usuario
│   ├── resumen_view.dart       # Pantalla principal con resumen
│   ├── agregar_gasto_view.dart # Formulario para nuevos gastos
│   ├── categorias_view.dart    # Gestión de categorías
│   ├── presupuestos_view.dart  # Configuración de presupuestos
│   └── exportar_view.dart      # Pantalla de descarga de reportes
├── widgets/            # Componentes reutilizables
│   ├── grafico_categorias.dart     # Widget de gráfico estadístico
│   ├── lista_gastos.dart           # Listado visual de transacciones
│   ├── input_gasto.dart            # Campo de entrada personalizado
│   └── scaffold_with_nav_bar.dart  # Estructura base con navegación
└── main.dart           # Punto de entrada de la aplicación
```

### Justificación de Arquitectura: ¿Por qué BLoC?

Para este proyecto personal, la elección de **BLoC (Business Logic Component)** como gestor de estado responde a la necesidad de construir una aplicación robusta, escalable y profesional.

- **Separación de Responsabilidades:** Desacopla la lógica de negocio de la interfaz gráfica. La UI solo "reacciona" a los estados, mientras que el `Cubit` procesa la lógica, lo que resulta en un código más limpio y legible.
- **Flujo de Datos Unidireccional:** Facilita el rastreo de errores y el entendimiento de cómo viaja la información dentro de la app, desde la interacción del usuario hasta la actualización de la pantalla.
- **Testabilidad:** Al ser componentes de lógica pura separados de los Widgets, los BLoCs/Cubits son fácilmente testeables, asegurando que la lógica de presupuestos y gastos funcione correctamente.
- **Persistencia y Reactividad:** Se integra perfectamente con repositorios y servicios (como `SharedPreferences`), permitiendo que la UI se actualice automáticamente cuando los datos cambian.
- **Estándar Profesional:** El uso de BLoC demuestra el dominio de una de las arquitecturas más demandadas y potentes en el ecosistema Flutter actual.

## Inicialización del Proyecto Flutter

Este archivo describe los pasos necesarios para inicializar el proyecto Flutter después de clonarlo o descargarlo.

### Requisitos Previos

- [Flutter](https://flutter.dev/docs/get-started/install) debe estar instalado en tu equipo (versión 3.0.0 o superior).
- Asegúrate de tener todas las dependencias necesarias instaladas. Puedes ejecutar el siguiente comando:

  ```bash
  flutter doctor
  ```
  Asegúrate de solucionar cualquier problema identificado por flutter doctor antes de continuar.

### Pasos de Inicialización

**1. Descargar el Proyecto:**
Clona el repositorio o descarga el proyecto desde GitHub.

```bash
git clone https://github.com/usuario/appgastos.git
cd appgastos
```

**2. Limpiar el Proyecto:**
Ejecuta el siguiente comando para limpiar el proyecto.
```bash
flutter clean
```

**3. Obtener Dependencias:**
Ejecuta el siguiente comando para obtener todas las dependencias del proyecto.
```bash
flutter pub get
```
Esto descargará todas las dependencias definidas en el archivo **pubspec.yaml.**

**4. Configuración Adicional (En caso de ser necesario):**
Realiza cualquier configuración adicional necesaria según las instrucciones del proyecto.

## Ejecutar la Aplicación
Una vez completados los pasos anteriores, puedes ejecutar la aplicación Flutter con el siguiente comando:

```bash
# Para Web (recomendado)
flutter run -d chrome

# Para Android
flutter run -d android

# Para Windows
flutter run -d windows

# Para iOS (solo en macOS)
flutter run -d ios
```

Esto iniciará la aplicación en el emulador, dispositivo conectado o navegador web.

## Características Técnicas Implementadas

### Gestión de Gastos
- **Patrón BLoC:** Implementación robusta con Cubit para manejo de estado reactivo
- **Estado Inmutable:** Uso de copyWith para actualizaciones seguras de estado
- **Separación de Responsabilidades:** Cubit separado de la UI para mejor mantenibilidad
- **Gestión de Alertas:** Sistema automático de notificaciones de presupuesto

### Persistencia de Datos
- **Almacenamiento Local:** SharedPreferences para gastos, categorías y presupuestos
- **Serialización JSON:** Modelos con toJson() y fromJson() para conversión de datos
- **Carga Inicial:** Categorías por defecto para nueva instalación
- **Repositorio Pattern:** Abstracción de la capa de datos

### Análisis y Visualización
- **Gráficos Interactivos:** FL Chart para visualización de gastos por categoría
- **Tooltips Informativos:** Información detallada al interactuar con gráficos
- **Resumen por Categoría:** Cálculo automático de totales por categoría
- **Colores Dinámicos:** Paleta de colores automática para diferenciación visual

### Exportación de Datos
- **Reportes PDF:** Generación de reportes profesionales con tablas y totales
- **Exportación Excel:** Archivos .xlsx compatibles con Excel y hojas de cálculo
- **Gestión de Archivos:** Guardado directo en Descargas y apertura inmediata
- **Manejo de Errores:** Validación y mensajes informativos al usuario

### Funcionalidades Avanzadas
- **Validación de Formularios:** Campos requeridos con mensajes personalizados
- **DatePicker Integrado:** Selección intuitiva de fechas para gastos
- **Categorías Personalizadas:** Creación de categorías con íconos personalizados
- **Sistema de Presupuestos:** Límites configurables con alertas automáticas
- **Navegación Fluida:** GoRouter para transiciones y deep linking

## Modelos de Datos

### Gasto
```dart
class Gasto {
  final String id;
  final double monto;
  final String categoria;
  final DateTime fecha;
  final String descripcion;
}
```

### Categoria
```dart
class Categoria {
  final String nombre;
  final String icono;
  final Color color;
}
```

### Presupuesto
```dart
class Presupuesto {
  final String categoria;
  final double limite;
  final double alerta;
}
```

### Capturas de Funcionalidades

### Gestión de Gastos
- ✅ Registro de gastos con formulario validado
- ✅ **Edición y actualización** de gastos existentes
- ✅ Lista visual con información completa y hora exacta
- ✅ Categorización automática por colores
- ✅ Formato de fecha y hora localizado (dd/MM/yyyy hh:mm a)

### Sistema de Categorías
- ✅ Categorías predefinidas (Comida, Transporte, etc.)
- ✅ Creación de categorías personalizadas
- ✅ Íconos intuitivos para identificación rápida
- ✅ Confirmación de eliminación con diálogos

### Control de Presupuestos
- ✅ Configuración de límites por categoría
- ✅ Alertas automáticas al 80% del límite
- ✅ Notificaciones de exceso de presupuesto
- ✅ Edición de presupuestos existentes

### Análisis Visual
- ✅ Gráficos de barras interactivos
- ✅ Tooltips con información detallada
- ✅ Colores automáticos por categoría
- ✅ Adaptación responsive a diferentes tamaños

### Exportación
- ✅ Reportes PDF con tabla profesional
- ✅ Archivos Excel para análisis externo
- ✅ Cálculo automático de totales
- ✅ Guardado directo en carpeta de Descargas
- ✅ Apertura inmediata de archivos generados
- ✅ Manejo de Errores: Validación y mensajes informativos al usuario

---

