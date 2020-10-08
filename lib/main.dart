

import 'package:flutter/material.dart';
import 'package:primer_proyecto/pages/acceso_gps_page.dart';
import 'package:primer_proyecto/pages/loading_page.dart';
import 'package:primer_proyecto/pages/mapa_page.dart';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:primer_proyecto/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:primer_proyecto/bloc/mapa/mapa_bloc.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider( create: (_) => MiUbicacionBloc()),
        BlocProvider( create: (_) => MapaBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: LoadingPage(),
        // home: AccesoGpsPage(),
        routes: {
          'mapa'       : (_) => MapaPage(),
          'loading'    : (_) => LoadingPage(),
          'acceso_gps' : (_) => AccesoGpsPage(),
          
        },
      ),
    );
  }
}