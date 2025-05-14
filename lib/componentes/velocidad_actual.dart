import 'package:flutter/material.dart';
import '../constantes.dart'; // Importa los colores definidos globalmente

/// Widget que muestra la velocidad actual en km/h.
/// Utiliza un efecto de degradado vertical para el texto principal.
class VelocidadActual extends StatelessWidget {
  const VelocidadActual({
    Key? key,
    this.velocidad = 00, // Velocidad a mostrar (por defecto: 00)
  }) : super(key: key);

  final int velocidad;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Texto de velocidad con un degradado de color
        ShaderMask(
          blendMode: BlendMode.srcIn, // Solo pinta donde hay texto
          shaderCallback: (bounds) => LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorTextoPrincipal,                        // Blanco
              colorTextoPrincipal.withOpacity(0),         // Transparente hacia abajo
            ],
          ).createShader(
            Rect.fromLTWH(0.0, 0.0, bounds.width, bounds.height),
          ),
          child: Text(
            "$velocidad", // Velocidad que se muestra (en km/h)
            style: const TextStyle(
              fontSize: 96,
              fontWeight: FontWeight.w500,
              height: 0.9,
            ),
          ),
        ),

        // Unidad de medida (kilómetros por hora)
        const Text(
          "km/h",
          style: TextStyle(
            fontSize: 20,
            color: colorTextoSecundario, // Usa color definido en constantes
          ),
        )
      ],
    );
  }
}
