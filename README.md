# 💰 App Control de Gastos Flutter 

## Objetivo del Proyecto:
Desarrollar una aplicación móvil utilizando Flutter para el control y gestión eficiente de gastos personales. La aplicación permite a los usuarios registrar, categorizar, analizar y exportar sus gastos con funcionalidades avanzadas como gráficos interactivos, sistema de presupuestos, alertas automáticas y exportación de reportes.

> [!NOTE]
> Aplicacion desarrollada con Flutter y arquitectura BLoC para gestión de estado reactivo


## Funcionalidades Principales:

- **Gestión Completa de Gastos:** Crear, visualizar y eliminar gastos con información detallada (descripción, categoría, monto, fecha).

- **Sistema de Categorías:** Gestión de categorías personalizadas con íconos intuitivos para clasificar gastos eficientemente.

- **Control de Presupuestos:** Configuración de límites de gasto por categoría con sistema de alertas automáticas.

- **Análisis Visual:** Gráficos de barras interactivos para visualizar gastos por categoría con tooltips informativos.

- **Exportación de Reportes:** Generación de reportes en formato PDF y CSV para análisis externo.

- **Alertas Inteligentes:** Notificaciones automáticas al acercarse o exceder límites de presupuesto.

- **Persistencia Local:** Almacenamiento offline de gastos, categorías y presupuestos usando SharedPreferences.

- **Interfaz Moderna:** Material Design 3 con navegación fluida y experiencia de usuario optimizada.

- **Multiplataforma:** Funcionamiento completo en web, Android, iOS, Windows, macOS y Linux.

- **Navegación Declarativa:** Enrutamiento moderno con GoRouter para transiciones suaves.

- **Validación de Formularios:** Campos obligatorios con validación en tiempo real y mensajes informativos.

## Desarrollador:

- [Luis Manuel De La Cruz Ledesma - Desarrollador](https://github.com/luismanuelcldev)|

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
- **Arquitectura:** BLoC Pattern (flutter_bloc ^8.1.6)
- **Navegación:** GoRouter ^14.6.2
- **Persistencia:** SharedPreferences ^2.3.2
- **Gráficos:** FL Chart ^0.69.0
- **Internacionalización:** intl ^0.19.0
- **Exportación PDF:** pdf ^3.11.1
- **Archivos:** path_provider ^2.1.4

### Estructura del Proyecto
```
lib/
├── app/                 # Configuración de la aplicación
│   ├── app.dart        # Widget principal de la app
│   └── router.dart     # Configuración de rutas
├── cubit/              # Gestión de estado (BLoC)
│   ├── gastos_cubit.dart
│   └── gastos_state.dart
├── models/             # Modelos de datos
│   ├── gasto.dart
│   ├── categoria.dart
│   └── presupuesto.dart
├── repositories/       # Capa de datos
│   ├── gastos_repository.dart
│   ├── categorias_repository.dart
│   └── presupuesto_repository.dart
├── services/           # Servicios de exportación
│   ├── csv_service.dart
│   └── pdf_service.dart
├── views/              # Interfaces de usuario
│   ├── resumen_view.dart
│   ├── agregar_gasto_view.dart
│   ├── categorias_view.dart
│   ├── presupuestos_view.dart
│   └── exportar_view.dart
├── widgets/            # Componentes reutilizables
│   ├── grafico_categorias.dart
│   ├── lista_gastos.dart
│   └── input_gasto.dart
└── main.dart           # Punto de entrada de la aplicacion
```

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

### Gestión de Estado
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
- **Exportación CSV:** Archivos CSV compatibles con Excel y hojas de cálculo
- **Gestión de Archivos:** Almacenamiento temporal con path_provider
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

## Capturas de Funcionalidades

### Gestión de Gastos
- ✅ Registro de gastos con formulario validado
- ✅ Lista visual con información completa
- ✅ Categorización automática por colores
- ✅ Formato de fecha localizado (dd/MM/yyyy)

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
- ✅ Archivos CSV para análisis externo
- ✅ Cálculo automático de totales
- ✅ Gestión de archivos temporales

---

