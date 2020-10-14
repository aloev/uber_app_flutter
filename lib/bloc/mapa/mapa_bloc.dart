import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:primer_proyecto/bloc/mi_ubicacion/mi_ubicacion_bloc.dart' ;
import 'package:primer_proyecto/theme/uber_map_theme.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super(MapaState());


  // Controlador del Mapa
  GoogleMapController _mapController;

  // Polylines -- Una que siempre sigue, Otra apenas Click

  Polyline _miRuta = new Polyline(
    polylineId: PolylineId('mi_ruta') ,
    width: 4,
    color: Colors.transparent,
  );

  Polyline _miRutaDestino = new Polyline(
    polylineId: PolylineId('mi_ruta_destino') ,
    width: 4,
    color: Colors.black87,
  );


  // Inicia Mapa Style Uber
  void initMapa( GoogleMapController controller){

    if( !state.mapaListo ){

      this._mapController = controller;

      this._mapController.setMapStyle( jsonEncode(uberMapTheme) );
      

      add(OnMapaListo());  

    }
  }
  // Le asigna al controller de Google el nuevo destino
  void moverCamara( LatLng destino ){
    
    final cameraUpdate = CameraUpdate.newLatLng(destino);

    this._mapController?.animateCamera(cameraUpdate);
  }


  @override
  Stream<MapaState> mapEventToState( MapaEvent event, ) async* {
    
    if( event is OnMapaListo){
      yield state.copyWith( mapaListo: true);
    
    } else if( event is OnNuevaUbicacion ){

      // Regrese Todos puntos + Nueva Ubicacion => Propiedad Polyline

      yield* this._onNuevaUbicacion(event);
    
    } else if( event is OnMarcarRecorrido ){

        // Cambiar color a _miRuta que es la q me sigue always
      yield* _onMarcarRecorrido(event);
      
    } else if ( event is OnSeguirUbicacion){

      yield* this._onSeguirUbicacion(event);
     
    } else if ( event is OnMovioMapa){

      yield state.copyWith(ubicacionCentral:event.centroMapa);

    } else if ( event is OncrearRutaInicioDestino){

      yield* _oncrearRutaInicioDestino(event);
    }
  }


   // Funciones Optimizadoras

  Stream<MapaState> _onMarcarRecorrido(OnMarcarRecorrido event) async* {
    if( state.dibujarRecorrido ){

      this._miRuta = this._miRuta.copyWith( colorParam: Colors.black87  );
    } else {
      this._miRuta = this._miRuta.copyWith( colorParam: Colors.transparent  );
    }
    final currentPolylines = state.polylines;
    
    // Reescribo los puntos RESULTANDES a mi Polyline
    currentPolylines['mi_ruta'] = this._miRuta;

    yield state.copyWith(
      dibujarRecorrido: !state.dibujarRecorrido,
      polylines:currentPolylines 
    );
  }


  Stream<MapaState> _onNuevaUbicacion(OnNuevaUbicacion event ) async* {


      if( state.seguirUbicacion){

        // Obtengo la Ubicacion actual del state
        final destino = event.ubicacion;

        // Muevo el foco

        this.moverCamara(destino);
      }


      // Armo puntos viejos mas Nuevos - Polyline + Nueva Ubicacion
      final points = [ ...this._miRuta.points, event.ubicacion ];
      
      // Creo una COPIA de estos Mismos
      this._miRuta = this._miRuta.copyWith( pointsParam: points);

      // 
      final currentPolylines = state.polylines;
      
      // Reescribo los puntos RESULTANDES a mi Polyline
      currentPolylines['mi_ruta'] = this._miRuta;

      // Regresa puntos Antiguos + nuevaUbicacion
      yield state.copyWith(polylines:currentPolylines );
  }

  Stream<MapaState> _onSeguirUbicacion(OnSeguirUbicacion event)async*{
      
      // Revisar
      if( !state.seguirUbicacion){
        this.moverCamara(this._miRuta.points[this._miRuta.points.length-1]);
      }

      yield state.copyWith(seguirUbicacion: !state.seguirUbicacion);


  }


  Stream<MapaState> _oncrearRutaInicioDestino( OncrearRutaInicioDestino event) async*{
    
    this._miRutaDestino = this._miRutaDestino.copyWith(
      pointsParam: event.rutaCoordenadas
    );

    final currentPolylines = state.polylines;
    currentPolylines['mi_ruta_destino'] = this._miRutaDestino;

    yield state.copyWith(
      polylines: currentPolylines,
      // TODO: Marcadores
    );
  }

}
