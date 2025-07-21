import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:control_gastos/core/core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  //TODO: Cambiar por Key seguras.
  await Supabase.initialize(
    url: 'https://vcknnaowqmcmskmsifbw.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZja25uYW93cW1jbXNrbXNpZmJ3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDYyNTI0MzAsImV4cCI6MjA2MTgyODQzMH0.d2cf5IUtzJ_q7m8WsXuvnu-uMC1UiXU1WOPsWM4RC9U',
  );
  runApp(ProviderScope(
    child: MainApp(),
  ));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: routes,
      debugShowCheckedModeBanner: false,
      theme: ref.watch(themeGlobalProvider),
    );
  }
}
