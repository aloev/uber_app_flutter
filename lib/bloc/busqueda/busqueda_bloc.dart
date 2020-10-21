import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:primer_proyecto/models/search_result.dart';

part 'busqueda_event.dart';
part 'busqueda_state.dart';

class BusquedaBloc extends Bloc<BusquedaEvent, BusquedaState> {
  BusquedaBloc() : super (BusquedaState());

  @override
  Stream<BusquedaState> mapEventToState( BusquedaEvent event,) async* {
    

    if( event is OnActivarMarcadorManual){

      yield state.copywith(seleccionManual: true);
    
    } else if (event is OnDesctivarMarcadorManual){

      yield state.copywith(seleccionManual: false);

    } else if(event is OnAgregarHistorial){

      // Se compara evento con state para ver si existe 
      final existe = state.historial.where(
      (result) => result.nombreDestino == event.result.nombreDestino 
      ).length;

      // Si no existe queremos que desestructure y guarde el nuevo
      if( existe == 0 ){
        final newHistorial = [ ...state.historial, event.result ];

        yield state.copywith(historial: newHistorial );

      }

    }
  }

  

}
