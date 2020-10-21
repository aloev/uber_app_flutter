part of 'mapa_bloc.dart';

@immutable
abstract class MapaEvent {}

class OnMapaListo extends MapaEvent{}

class OnMarcarRecorrido extends MapaEvent{}


class OnSeguirUbicacion extends MapaEvent{}


class OncrearRutaInicioDestino extends MapaEvent{
  final List<LatLng> rutaCoordenadas;
  final double  distance;
  final double  duracion;
  final String nombreDestino;

  OncrearRutaInicioDestino(this.rutaCoordenadas, this.distance, this.duracion, this.nombreDestino);
}


class OnNuevaUbicacion extends MapaEvent{

  final LatLng ubicacion;
  OnNuevaUbicacion(this.ubicacion);

}

class OnMovioMapa extends MapaEvent{

  final LatLng centroMapa;

  OnMovioMapa(this.centroMapa);
}