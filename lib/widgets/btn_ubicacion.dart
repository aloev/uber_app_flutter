

part of 'widgets.dart';


class BtnUbicacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    // Necesito conocer ambas Instancias del ubber
    // Tanto a donde me extravie como donde esta mi POINTER

    final mapaBloc = context.bloc<MapaBloc>();
    final miubicacionBloc = context.bloc<MiUbicacionBloc>();

    return Container(
      margin: EdgeInsets.only( bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(Icons.my_location, color: Colors.black87,) ,
          onPressed: (){

            final destino = miubicacionBloc.state.ubicacion;

            // Disparo al Bloc
            mapaBloc.moverCamara(destino);
          },
        ),
      ),
    );
  }
}