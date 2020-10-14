

part of 'widgets.dart';


class BtnSeguirUbicacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    // Necesito conocer ambas Instancias del ubber
    // Tanto a donde me extravie como donde esta mi POINTER


    return BlocBuilder<MapaBloc, MapaState>(
      builder: (context, state) => this._crearBoton(context, state)
    );
  }

  Widget _crearBoton( BuildContext context, MapaState state){
    final mapaBloc = context.bloc<MapaBloc>();


    return Container(
          margin: EdgeInsets.only( bottom: 10),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: 25,
            child: IconButton(
              icon: Icon(
              
                state.seguirUbicacion
                ? Icons.directions_run
                : Icons.accessibility_new, 
                color: Colors.black87,
              ) ,
              onPressed: (){

                // moverCamara(destino);

                  // Disparo event de MapBloc
                mapaBloc.add( OnSeguirUbicacion() );

              },
            ),
          ),
        );
  }
}