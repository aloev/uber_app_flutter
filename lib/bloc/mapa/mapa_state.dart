part of 'mapa_bloc.dart';

@immutable
class MapaState{

      // Propiedades de la Clase

  final bool mapaListo;

  final bool dibujarRecorrido;

  final LatLng ubicacionCentral;
  
  final bool seguirUbicacion;

  // Polylines  -- La mas importante

  final Map<String, Polyline > polylines;

    // Constructor

  MapaState({
    this.ubicacionCentral, 
    this.dibujarRecorrido = false,
    this.mapaListo = false,
    this.seguirUbicacion = false,
    Map<String, Polyline > polylines
  }): this.polylines = polylines ?? new Map();

  // Modificar el estado - por medio de CopyWiths

  MapaState copyWith({
    bool mapaListo,
    bool dibujarRecorrido,
    bool seguirUbicacion,
    LatLng ubicacionCentral,
    Map<String, Polyline > polylines,
  }) => MapaState(
    mapaListo: mapaListo ?? this.mapaListo,
    polylines: polylines ?? this.polylines,
    seguirUbicacion: seguirUbicacion ?? this.seguirUbicacion,
    dibujarRecorrido: dibujarRecorrido ?? this.dibujarRecorrido,
    ubicacionCentral: ubicacionCentral ?? this.ubicacionCentral
  );

}
