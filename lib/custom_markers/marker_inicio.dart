


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MarkerInicioPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {

    final double circuloNegroR = 20;
    final double circuloBlancoR = 7;

    Paint paint = new Paint()
    ..color = Colors.black;

    // Dibujar Circulo Negro

    canvas.drawCircle(
      Offset(circuloNegroR, size.height -circuloNegroR), 
      circuloNegroR, 
      paint
    );

    // Circulo Blanco

    paint.color = Colors.white;
    canvas.drawCircle(
      Offset(circuloNegroR, size.height -circuloNegroR), 
      circuloBlancoR, 
      paint
    );
  }

  @override
  bool shouldRepaint(MarkerInicioPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(MarkerInicioPainter oldDelegate) => false;
}