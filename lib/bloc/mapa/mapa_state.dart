part of 'mapa_bloc.dart';

@immutable
class MapaState{

  final bool mapaListo;

  final bool dibujarRecorrido;

  
  final bool seguirUbicacion;
  // Polylines

  final Map<String, Polyline > polylines;

  MapaState({
    this.dibujarRecorrido = true,
    this.mapaListo = false,
    this.seguirUbicacion = false,
    Map<String, Polyline > polylines
  }): this.polylines = polylines ?? new Map();

  // Modificar el estado

  MapaState copyWith({
    bool mapaListo,
    bool dibujarRecorrido,
    bool seguirUbicacion,
    Map<String, Polyline > polylines,
  }) => MapaState(
    mapaListo: mapaListo ?? this.mapaListo,
    polylines: polylines ?? this.polylines,
    seguirUbicacion: seguirUbicacion ?? this.seguirUbicacion,
    dibujarRecorrido: dibujarRecorrido ?? this.dibujarRecorrido
  );

}
