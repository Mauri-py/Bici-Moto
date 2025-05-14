import 'package:flutter/material.dart';
import '../constantes.dart'; // Importa los colores y constantes definidas
import '../dashboard.dart'; // Importa widgets personalizados utilizados

// Widget que muestra información del motor: nivel de nafta, autonomía, consumo promedio y odómetro
class InfoMotor extends StatelessWidget {
  const InfoMotor({
    Key? key,
    required this.constraints,
  }) : super(key: key);

  // Restricciones de tamaño disponibles para el widget (ancho y alto)
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Tamaño proporcional al contenedor padre
      width: constraints.maxWidth * 0.74,
      height: constraints.maxHeight * 0.22,
      child: LayoutBuilder(
        builder: (context, restriccionesInfo) => Stack(
          fit: StackFit.expand,
          children: [
            // Fondo personalizado pintado con CustomPainter
            CustomPaint(
              painter: kInfoMotor(), // Dibuja el fondo del panel de info
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Muestra la autonomía estimada restante
                  Text.rich(
                    TextSpan(
                      text: "Rest. ",
                      style: TextStyle(
                        fontSize: 16,
                        color: colorTextoPrincipal.withOpacity(0.16),
                      ),
                      children: const [
                        TextSpan(
                          text: "465km", // Autonomía
                          style: TextStyle(
                            color: colorNaftaLlena, // Color que indica tanque lleno
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Indicador de nivel de nafta en forma de barra horizontal
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SizedBox(
                      width: restriccionesInfo.maxWidth * 0.72,
                      child: Row(
                        children: [
                          // Letra "E" (Empty - vacío)
                          Text(
                            "E",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: colorTextoPrincipal.withOpacity(0.16),
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Barra de nivel de nafta (rellenada con líneas discontinuas)
                          Expanded(
                            child: SizedBox(
                              height: 8,
                              child: ClipPath(
                                clipper: NivelCombustible(),
                                child: CustomPaint(
                                  painter: DashLinePainter(progress: 1),
                                ),
                              ),
                            ),
                          ),
                          // Porcentaje de nafta actual
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "100%",
                              style: TextStyle(
                                color: colorNaftaLlena,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Indicador de consumo promedio (lado izquierdo)
            Positioned(
              top: restriccionesInfo.maxHeight * 0.10,
              left: restriccionesInfo.maxWidth * 0.16,
              width: restriccionesInfo.maxWidth * 0.17,
              height: restriccionesInfo.maxHeight * 0.38,
              child: CustomPaint(
                painter: ConsumoPromedio(), // Fondo decorativo
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: restriccionesInfo.maxWidth * 0.025),
                    Text(
                      "Avg. ",
                      style: TextStyle(
                        fontSize: 16,
                        color: colorTextoPrincipal.withOpacity(0.16),
                      ),
                    ),
                    Text(
                      "11.3 km/l", // Valor de consumo (puede cambiarse)
                      style: TextStyle(
                        fontSize: 16,
                        color: colorTextoPrincipal.withOpacity(0.32),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Indicador de odómetro (lado derecho)
            Positioned(
              top: restriccionesInfo.maxHeight * 0.10,
              right: restriccionesInfo.maxWidth * 0.16,
              width: restriccionesInfo.maxWidth * 0.17,
              height: restriccionesInfo.maxHeight * 0.38,
              child: CustomPaint(
                painter: Odometro(), // Fondo decorativo
                child: Row(
                  children: [
                    Text(
                      "ODO. ",
                      style: TextStyle(
                        fontSize: 16,
                        color: colorTextoPrincipal.withOpacity(0.16),
                      ),
                    ),
                    Text(
                      "6666.6km", // Total de kilómetros recorridos
                      style: TextStyle(
                        fontSize: 16,
                        color: colorTextoPrincipal.withOpacity(0.32),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ClipPath personalizado que recorta la barra de nivel de combustible con un diseño inclinado
class NivelCombustible extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width * 0.05, 0)
      ..lineTo(size.width * 0.95, 0)
      ..lineTo(size.width, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

// Dibuja el fondo en forma de flecha para el consumo promedio
class ConsumoPromedio extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = colorFondoMarcadorMarcha
      ..style = PaintingStyle.fill;

    const double strokeWidth = 4;
    Path path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width * 0.27, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width * 0.27, strokeWidth);

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

// Dibuja el fondo decorativo para el odómetro, con punta hacia abajo
class Odometro extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = colorFondoMarcadorMarcha
      ..style = PaintingStyle.fill;

    const double strokeWidth = 4;
    Path path = Path()
      ..lineTo(size.width * 0.73, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width * 0.73, strokeWidth);

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
