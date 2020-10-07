part of 'mi_ubicacion_bloc.dart';

@immutable
abstract class MiUbicacionEvent {}


      // Modifica el State

class OnUbicacionCambio extends MiUbicacionEvent{

  final LatLng ubicacion;

  OnUbicacionCambio(this.ubicacion); 

}