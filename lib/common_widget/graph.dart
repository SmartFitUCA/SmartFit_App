import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/Modele/user.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';

class Graph extends StatelessWidget {
  const Graph({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: SizedBox(
        width: double.infinity,
        child: GraphArea(),
      ),
    );
  }
}

class GraphArea extends StatefulWidget {
  const GraphArea({Key? key}) : super(key: key);

  @override
  _GraphAreaState createState() => _GraphAreaState();
}

class _GraphAreaState extends State<GraphArea>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  


  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2500));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      List<DataPoint> vitesseSecondes = Provider.of<User>(context, listen: false).listActivity[0].getSpeedWithTimeActivity();

    return GestureDetector(
      onTap: () {
        _animationController.forward(from: 0.0);
      },
      child: CustomPaint(
        painter: GraphPainter(_animationController.view, data: vitesseSecondes),
      ),
    );
  }
}

class GraphPainter extends CustomPainter {
  final List<DataPoint> data;
  final Animation<double> _size;
  final Animation<double> _dotSize;

  GraphPainter(Animation<double> animation, {required this.data})
      : _size = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: animation,
            curve: const Interval(0.0, 0.75,
                curve: Curves.easeInOutCubicEmphasized),
          ),
        ),
        _dotSize = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: animation,
            curve:
                const Interval(0.75, 1, curve: Curves.easeInOutCubicEmphasized),
          ),
        ),
        super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    var xSpacing = size.width / (data.length - 1);

    var maxSteps = data
        .fold<DataPoint>(data[0], (p, c) => p.speed > c.speed ? p : c)
        .speed;

    var yRatio = size.height / maxSteps;
    var curveOffset = xSpacing * 0.3;

    List<Offset> offsets = [];

    var cx = 0.0;
    for (int i = 0; i < data.length; i++) {
      
      var y = size.height - (data[i].speed * yRatio * _size.value);

      offsets.add(Offset(cx, y));
      cx += xSpacing;
    }

    Paint linePaint = Paint()
      ..color = TColor.primaryColor1
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    Paint shadowPaint = Paint()
      ..color = TColor.primaryColor1
      ..style = PaintingStyle.stroke
      ..maskFilter = const ui.MaskFilter.blur(ui.BlurStyle.solid, 0)
      ..strokeWidth = 0.0;

    Paint fillPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(size.width / 2, 0),
        Offset(size.width / 2, size.height),
        [
          TColor.primaryColor1,
          Colors.white,
        ],
      )
      ..color = TColor.primaryColor1
      ..style = PaintingStyle.fill;

    Paint dotOutlinePaint = Paint()
      ..color = ui.Color.fromARGB(255, 236, 236, 236).withAlpha(200)
      ..strokeWidth = 8;

    Paint dotCenter = Paint()
      ..color = TColor.primaryColor1
      ..strokeWidth = 8;

    Path linePath = Path();

    Offset cOffset = offsets[0];

    linePath.moveTo(cOffset.dx, cOffset.dy);

    for (int i = 1; i < offsets.length; i++) {
      var x = offsets[i].dx;
      var y = offsets[i].dy;
      var c1x = cOffset.dx + curveOffset;
      var c1y = cOffset.dy;
      var c2x = x - curveOffset;
      var c2y = y;

      linePath.cubicTo(c1x, c1y, c2x, c2y, x, y);
      cOffset = offsets[i];
    }

    Path fillPath = Path.from(linePath);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(linePath, shadowPaint);
    canvas.drawPath(linePath, linePaint);

    int maxIndex = 0;
    double maxY = offsets[0].dy; // Supposons que la première coordonnée est la plus grande

    for (int i = 1; i < offsets.length; i++) {
      if (offsets[i].dy < maxY) {
        maxIndex = i;
        maxY = offsets[i].dy;
      }
    }

    // Maintenant, maxIndex contient l'indice de la coordonnée maximale dans la liste offsets
    // Utilisez ces coordonnées pour dessiner le point
    canvas.drawCircle(offsets[maxIndex], 15 * _dotSize.value, dotOutlinePaint);
    canvas.drawCircle(offsets[maxIndex], 6 * _dotSize.value, dotCenter);
  }

  @override
  bool shouldRepaint(covariant GraphPainter oldDelegate) {
    return data != oldDelegate.data;
  }
}

class DataPoint {
  final double time;
  final double speed;

  DataPoint(
     this.time,
     this.speed,
  );
}