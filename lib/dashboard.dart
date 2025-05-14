import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:ui' as ui;

import 'componentes/indicadores.dart';
import 'componentes/velocidad_actual.dart';
import 'componentes/info_motor.dart';
import 'componentes/tiempo_temperatura.dart';
import 'constantes.dart';

/// Componente principal del tablero.
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // Lista de opacidades para las líneas de velocidad (efecto visual)
  List<double> LineasVelocidadOpacidad = [1, 0.8, 0.6, 0.4, 0.3, 0.2, 0.15, 0.1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorFondoPrincipal,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              constraints: const BoxConstraints(
                minWidth: 1184,
                maxWidth: 1480,
                minHeight: 456,
                maxHeight: 604,
              ),
              child: AspectRatio(
                aspectRatio: 2.59,
                child: LayoutBuilder(
                  builder: (context, constraints) => CustomPaint(
                    painter: PathPainter(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TiempoYTemperatura(constraints: constraints),
                        Expanded(
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Column(
                                children: [
                                  const SizedBox(height: 20),
                                  const Indicadores(),
                                  const Spacer(),
                                  const VelocidadActual(velocidad: 54),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/speed_miter.svg",
                                        height: 32,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Text(
                                          "100 km/H",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(color: colorPrimario),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  InfoMotor(constraints: constraints),
                                ],
                              ),
                              ...List.generate(
                                LineasVelocidadOpacidad.length,
                                (index) => Positioned(
                                  bottom: 20 + (2 * index).toDouble(),
                                  left: constraints.maxWidth * 0.13 - (30 * index),
                                  height: constraints.maxHeight * 0.8,
                                  width: constraints.maxWidth * 0.31,
                                  child: Opacity(
                                    opacity: LineasVelocidadOpacidad[index],
                                    child: CustomPaint(
                                      painter: SpeedLinePainter(),
                                    ),
                                  ),
                                ),
                              ),
                              ...List.generate(
                                LineasVelocidadOpacidad.length,
                                (index) => Positioned(
                                  bottom: 20 + (2 * index).toDouble(),
                                  right: constraints.maxWidth * 0.13 - (30 * index),
                                  height: constraints.maxHeight * 0.8,
                                  width: constraints.maxWidth * 0.31,
                                  child: Transform.scale(
                                    scaleX: -1,
                                    child: Opacity(
                                      opacity: LineasVelocidadOpacidad[index],
                                      child: CustomPaint(
                                        painter: SpeedLinePainter(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Dibuja la forma exterior del tablero usando `Path`.
class PathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.bottomRight,
        colors: [
          colorPrimario,
          colorPrimarioMedio,
        ],
      ).createShader(const Offset(0, 0) & size)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0;

    Path path = Path();
    path.moveTo(0, size.height / 2);
    path.lineTo(size.width * 0.13, size.height * 0.05);
    path.lineTo(size.width * 0.31, 0);
    path.lineTo(size.width * 0.39, size.height * 0.11);
    path.lineTo(size.width * 0.60, size.height * 0.11);
    path.lineTo(size.width * 0.69, 0);
    path.lineTo(size.width * 0.87, size.height * 0.05);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width * 0.87, size.height);
    path.lineTo(size.width * 0.13, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

/// Dibuja una línea con guiones (por ejemplo, para progreso promedio).
class DashLinePainter extends CustomPainter {
  DashLinePainter({required this.progress});

  final double progress;

  final Paint _paint = Paint()
    ..color = colorPrimarioMedio
    ..strokeWidth = 10.0
    ..style = PaintingStyle.stroke
    ..strokeJoin = StrokeJoin.round;

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path()
      ..moveTo(0, size.height / 2)
      ..lineTo(size.width * progress, size.height / 2);

    Path dashPath = Path();

    double dashWidth = 24.0;
    double dashSpace = 2.0;
    double distance = 0.0;

    for (ui.PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth;
        distance += dashSpace;
      }
    }
    canvas.drawPath(dashPath, _paint);
  }

  @override
  bool shouldRepaint(DashLinePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

/// Dibuja las líneas anguladas de "velocidad" que aparecen a los costados.
class SpeedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double stockWidth = 8;

    // Primera forma triangular
    Path path_0 = Path()
      ..moveTo(size.width * 0.76, 0)
      ..lineTo(size.width, size.height * 0.30)
      ..lineTo(size.width - stockWidth, size.height * 0.30)
      ..close();

    // Segunda forma triangular conectando hacia abajo
    Path path1 = Path()
      ..moveTo(size.width, size.height * 0.30)
      ..lineTo(40, size.height - 20)
      ..lineTo(size.width - stockWidth, size.height * 0.30)
      ..close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.shader = ui.Gradient.linear(
      Offset(size.width * 0.912, 0),
      Offset(size.width * 0.837, size.height * 1.76),
      [
        colorPrimario.withOpacity(1),
        colorGradienteFinal.withOpacity(0.79),
      ],
      [0, 1],
    );

    canvas.drawPath(path_0, paint0Fill);
    canvas.drawPath(path1, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
// Este CustomPainter dibuja una forma personalizada con varios gradientes.
// Se usa para efectos visuales en el dashboard.
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Primer path: forma principal
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0005, size.height * 0.304);
    path_0.lineTo(size.width * 0.249, size.height * 0.001);
    path_0.lineTo(size.width * 0.0244, size.height * 0.304);
    path_0.lineTo(size.width * 0.999, size.height * 0.998);
    path_0.lineTo(size.width * 0.0005, size.height * 0.304);
    path_0.close();

    // Primer relleno: gradiente lineal
    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.232, size.height * 0.107),
        Offset(size.width * 0.056, size.height * 0.356),
        [colorPrimario.withOpacity(1), colorPrimarioClaro],
        [0, 1]);
    canvas.drawPath(path_0, paint0Fill);

    // Segundo path: mismo que el anterior, otro efecto
    Path path_1 = path_0;
    Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.shader = ui.Gradient.radial(
      const Offset(0, 0),
      size.width * 0.0017,
      [
        colorBrilloSecundario.withOpacity(0.85),
        colorBrilloSecundario.withOpacity(0),
      ],
      [0, 1],
    );
    canvas.drawPath(path_1, paint1Fill);

    // Tercer gradiente adicional sobre el mismo path
    Path path_2 = path_0;
    Paint paint2Fill = Paint()..style = PaintingStyle.fill;
    paint2Fill.shader = ui.Gradient.linear(
        Offset(size.width * 1.25, size.height * 1.25),
        Offset(size.width * 0.15, size.height * 0.01),
        [colorPrimario.withOpacity(1), colorPrimario.withOpacity(0)],
        [0, 1]);
    canvas.drawPath(path_2, paint2Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// Este painter dibuja una figura para millaje promedio (decoración visual)
class AverageMillagePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.28, 0);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(size.width * 0.295, size.height * 0.086);
    path_0.lineTo(0, size.height * 0.98);
    path_0.lineTo(size.width * 0.28, 0);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.91, -0.000008),
        Offset(size.width * 0.83, size.height * 1.76),
        [colorPrimario.withOpacity(1), colorGradienteFinal.withOpacity(0.79)],
        [0, 1]);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// Este painter dibuja la forma que representa información del motor
class kInfoMotor extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = colorPrimarioMedio
      ..style = PaintingStyle.fill;

    const double strokeWidth = 2;

    // Primer bloque de figura
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width * 0.17, size.height * 0.5);
    path.lineTo(size.width * 0.34, size.height * 0.5);
    path.lineTo(size.width * 0.42, 0);
    path.lineTo(size.width * 0.48, 0);
    path.lineTo(size.width * 0.48, strokeWidth);
    path.lineTo(size.width * 0.42, strokeWidth);
    path.lineTo(size.width * 0.34, size.height * 0.5 + strokeWidth);
    path.lineTo(size.width * 0.17, size.height * 0.5 + strokeWidth);
    path.close();
    canvas.drawPath(path, paint);

    // Segundo bloque simétrico
    Path path2 = Path();
    path2.moveTo(size.width * 0.52, 0);
    path2.lineTo(size.width * 0.58, 0);
    path2.lineTo(size.width * 0.66, size.height * 0.5);
    path2.lineTo(size.width * 0.83, size.height * 0.5);
    path2.lineTo(size.width, size.height);
    path2.lineTo(size.width * 0.83, size.height * 0.5 + strokeWidth);
    path2.lineTo(size.width * 0.66, size.height * 0.5 + strokeWidth);
    path2.lineTo(size.width * 0.58, strokeWidth);
    path2.lineTo(size.width * 0.52, strokeWidth);
    path2.close();
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

