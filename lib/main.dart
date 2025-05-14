import 'package:flutter/material.dart';
import 'dashboard.dart'; // Importa la pantalla principal del tablero

/// Punto de entrada de la aplicación.
void main() {
  runApp(const MyApp()); // Ejecuta la app
}

/// Widget principal que configura el tema y la pantalla inicial.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tacómetro', // Título de la aplicación (no se muestra visualmente en la app)
      theme: ThemeData.dark(), // Aplica un tema oscuro a toda la app
      home: const Dashboard(), // Pantalla principal al iniciar la app
    );
  }
}
