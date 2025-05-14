import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

import 'dashboard.dart'; // Ajusta esta importación según la ruta real de tu proyecto

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Detectar si el dispositivo es móvil (por tamaño físico de pantalla)
  final Size size = PlatformDispatcher.instance.views.first.physicalSize /
      PlatformDispatcher.instance.views.first.devicePixelRatio;

  // Si el lado corto es menor a 600dp, se considera dispositivo móvil y se fuerza landscape
  if (size.shortestSide < 600) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bici-Moto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Dashboard(),
    );
  }
}