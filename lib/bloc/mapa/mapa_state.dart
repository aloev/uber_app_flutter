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
  
  final Map<String, Marker > markers;

    // Constructor

  MapaState({
    this.ubicacionCentral, 
    this.dibujarRecorrido = false,
    this.mapaListo = false,
    this.seguirUbicacion = false,
    Map<String, Polyline > polylines,
    Map<String, Marker > markers,
  }): this.polylines = polylines ?? new Map(),
      this.markers = markers ?? new Map();

  // Modificar el estado - por medio de CopyWiths

  MapaState copyWith({
    bool mapaListo,
    bool dibujarRecorrido,
    bool seguirUbicacion,
    LatLng ubicacionCentral,
    Map<String, Polyline > polylines,
    Map<String, Marker > markers,
  }) => MapaState(
    mapaListo: mapaListo ?? this.mapaListo,
    polylines: polylines ?? this.polylines,
    markers: markers ?? this.markers,
    seguirUbicacion: seguirUbicacion ?? this.seguirUbicacion,
    dibujarRecorrido: dibujarRecorrido ?? this.dibujarRecorrido,
    ubicacionCentral: ubicacionCentral ?? this.ubicacionCentral
  );

}
