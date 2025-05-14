import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Widget que muestra la hora actual y la temperatura ambiente.
/// Se adapta automáticamente al tamaño disponible gracias a `BoxConstraints`.
class TiempoYTemperatura extends StatelessWidget {
  const TiempoYTemperatura({
    Key? key,
    required this.constraints, // Restricciones de tamaño (ancho y alto)
  }) : super(key: key);

  final BoxConstraints constraints; // Recibidas desde el layout padre

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Tamaño proporcional al contenedor padre
      width: constraints.maxWidth * 0.21,
      height: constraints.maxHeight * 0.11,
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.titleMedium!, // Estilo de texto por defecto
        child: Row(
          children: [
            // Hora actual (por ahora fija, se puede hacer dinámica más adelante)
            const Text("05:21 PM"),

            // Espaciador flexible que empuja la temperatura al final
            const Spacer(),

            // Icono del clima (sol)
            SvgPicture.asset(
              "assets/icons/sun.svg",
              height: 32,
            ),

            const SizedBox(width: 4),

            // Temperatura ambiente (actualmente fija en 18 grados)
            const Text("18 °C"),
          ],
        ),
      ),
    );
  }
}
