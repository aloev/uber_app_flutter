

import 'package:flutter/material.dart';
import 'package:primer_proyecto/custom_markers/marker_inicio.dart';


class TestMarkerPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          height: 150,
          color: Colors.red,
          child: CustomPaint(
            painter: MarkerInicioPainter() ,
          ),
        )
     ),
   );
  }
}