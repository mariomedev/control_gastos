# Control de Gastos

Aplicación Flutter para registrar cuentas, categorías y transacciones (ingresos/gastos) sincronizadas con Supabase. Usa arquitectura por features, administración de estado con Bloc y DI con GetIt.


## Stack principal
- 3.9.2 (Flutter)
Dart SDK 
- Bloc + flutter_bloc para estado y side-effects
- GoRouter para navegación declarativa
- GetIt para inyección de dependencias
- Supabase (Auth + Postgres) como BaaS
- intl, formz, fl_chart y otros paquetes de UI/UX

## Configuración de Supabase
1. Crea un proyecto en Supabase y replica las tablas usadas (accounts, categories, transactions). 
2. Copia tus credenciales en `.env` siguiendo el formato:
	```env
	SUPABASE_URL=https://<tu-proyecto>.supabase.co
	SUPABASE_ANON_KEY=<tu-anon-key>
	```
3. Mantén el archivo fuera de control de versiones si cambias las llaves.

## Ejecución local
Requisitos: Flutter 3.6+, Dart 3.6+, Android Studio o Xcode según plataforma.

```bash
flutter clean
flutter pub get
flutter run    # selecciona emulador/dispositivo
```

Para web:

```bash
flutter run -d chrome
```

## Decisiones técnicas destacadas
- **Arquitectura por features:** cada módulo (`features/general_spending`, `features/accounts`, etc.) agrupa dominio, datos y presentación, facilitando escalabilidad.
- **Bloc + Formz:** formularios validados de manera reactiva y controlada, con estados explícitos para carga, éxito y error.
- **GetIt como DI:** simplifica registro de repositorios, datasources y blocs manteniendo bajo acoplamiento.
- **Supabase como BaaS:** evita construir un backend dedicado; se aprovecha autenticación, base de datos Postgres y storage administrados.
- **GoRouter:** navegación declarativa y preparada para deep links y web support.


