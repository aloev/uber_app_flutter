

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:primer_proyecto/bloc/mapa/mapa_bloc.dart';
import 'package:primer_proyecto/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:primer_proyecto/widgets/widgets.dart';

class MapaPage extends StatefulWidget {

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {


  @override
  void initState() {

    context.bloc<MiUbicacionBloc>().iniciarSeguimiento();

    super.initState();
  }

  @override
  void dispose() {
    context.bloc<MiUbicacionBloc>().cancelarSeguimiento();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
        builder: (_, state) => crearMapa(state),
      ),
    
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnUbicacion(),

          BtnSeguirUbicacion(),

          BtnMiRuta(),
        ],
      ),
    
    );

  }

  Widget crearMapa(MiUbicacionState state){

    final mapaBloc = BlocProvider.of<MapaBloc>(context);

    if( !state.existeUbicacion) return Center(child: Text('Ubicando...'));

    // return Text('${ state.ubicacion.latitude},${ state.ubicacion.longitude  }');

    mapaBloc.add(OnNuevaUbicacion(state.ubicacion));

    
    final posInicial = new CameraPosition(
      target: state.ubicacion,
      zoom: 15
    );

    return GoogleMap(
      initialCameraPosition: posInicial ,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: true,

      onMapCreated: mapaBloc.initMapa,

      // Esto llama el Bloc para hacer las Polylineas
      polylines: mapaBloc.state.polylines.values.toSet(),

    );
  }
}