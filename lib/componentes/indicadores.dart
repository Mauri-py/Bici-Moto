import 'package:flutter/material.dart'; // Importa el paquete principal de Flutter para construir la interfaz de usuario
import 'package:flutter_svg/flutter_svg.dart'; // Importa el paquete para mostrar imágenes SVG

// Widget sin estado que representa la fila de indicadores visuales de la bicimoto
class Indicadores extends StatelessWidget {
  const Indicadores({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // Centra todos los íconos en el eje horizontal
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Botón para el guiño izquierdo
        TextButton(
          onPressed: () {}, // Actualmente no hace nada al presionar
          child: SvgPicture.asset(
            "assets/icons/giro_izquierdo_prendido.svg", // Ícono SVG del guiño izquierdo
            height: 32, // Altura del ícono
          ),
        ),
        // Botón para las luces delanteras
        TextButton(
          onPressed: () {},
          child: SvgPicture.asset(
            "assets/icons/head_light.svg", // Ícono SVG de la luz delantera
            height: 32,
          ),
        ),
        // Botón para el dipper (luz de cambio entre baja y alta)
        TextButton(
          onPressed: () {},
          child: SvgPicture.asset(
            "assets/icons/dipper.svg", // Ícono SVG del dipper
            height: 32,
          ),
        ),
        // Botón para el guiño derecho
        TextButton(
          onPressed: () {},
          child: SvgPicture.asset(
            "assets/icons/giro_derecho_apagado.svg", // Ícono SVG del guiño derecho
            height: 32,
          ),
        ),
      ],
    );
  }
}
