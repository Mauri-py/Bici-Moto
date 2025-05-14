import 'package:flutter/material.dart';
import '../constantes.dart'; // Import de constantes
import '../dashboard.dart';
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
      width: constraints.maxWidth * 0.74,
      height: constraints.maxHeight * 0.22,
      child: LayoutBuilder(
        builder: (context, restriccionesInfo) => Stack(
          fit: StackFit.expand,
          children: [
            CustomPaint(
              painter: kInfoMotor(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Rest. ",
                      style: TextStyle(
                        fontSize: 16,
                        color: colorTextoPrincipal.withOpacity(0.16),
                      ),
                      children: const [
                        TextSpan(
                          text: "465km",
                          style: TextStyle(
                            color: colorBateriaLlena,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SizedBox(
                      width: restriccionesInfo.maxWidth * 0.72,
                      child: Row(
                        children: [
                          Text(
                            "E",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: colorTextoPrincipal.withOpacity(0.16),
                            ),
                          ),
                          const SizedBox(width: 10),
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
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "100%",
                              style: TextStyle(
                                color: colorBateriaLlena,
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
            Positioned(
              top: restriccionesInfo.maxHeight * 0.10,
              left: restriccionesInfo.maxWidth * 0.16,
              width: restriccionesInfo.maxWidth * 0.17,
              height: restriccionesInfo.maxHeight * 0.38,
              child: CustomPaint(
                painter: ConsumoPromedio(),
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
                      "11.3 w/km",
                      style: TextStyle(
                        fontSize: 16,
                        color: colorTextoPrincipal.withOpacity(0.32),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: restriccionesInfo.maxHeight * 0.10,
              right: restriccionesInfo.maxWidth * 0.16,
              width: restriccionesInfo.maxWidth * 0.17,
              height: restriccionesInfo.maxHeight * 0.38,
              child: CustomPaint(
                painter: Odometro(),
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
                      "6666.6km",
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
