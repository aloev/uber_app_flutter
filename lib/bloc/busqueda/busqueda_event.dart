part of 'busqueda_bloc.dart';

@immutable
abstract class BusquedaEvent {}


class OnActivarMarcadorManual extends BusquedaEvent{}

class OnDesctivarMarcadorManual extends BusquedaEvent{}