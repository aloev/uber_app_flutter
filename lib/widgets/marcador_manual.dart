

part of 'widgets.dart';


class MarcadorManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {



    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if( state.seleccionManual){
          return _BuildMarcadorManual();      // Logica de Activar Marcador Manual
        }else {
          return Container();
        }
      },
    );
  }
}

class _BuildMarcadorManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Stack(
      children: [

        // Buton regresar
        Positioned(
          top: 70,
          left: 20,
          child: FadeInLeft(
            duration: Duration(milliseconds: 150),
            child: CircleAvatar(
              maxRadius: 25,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(Icons.arrow_back,  color: Colors.black87,), 
                onPressed: (){
                   context.bloc<BusquedaBloc>().add(OnDesctivarMarcadorManual());
                }),
            ),
          ),
        ),

        Center(
          child: Transform.translate(
            offset: Offset(0, 10),
            child: BounceInDown(
              child: Icon(Icons.location_on, size: 50,)
            )

          ),
        ),

        // Confirmar Destino
        Positioned(
          bottom: 70,
          left: 40,
          child: FadeIn(
            child: MaterialButton(
              minWidth: width - 120,
              child: Text('Confirmar Destino', style: TextStyle(color: Colors.white),),
              color: Colors.black,
              shape: StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              onPressed: (){
                this.calcularDestino(context);
              }
            ),
          )
        ),

      ],
    );
  }


  void calcularDestino( BuildContext context)async{

    calculandoAlerta(context);

    final trafficService = new TrafficService();
    final mapabloc = context.bloc<MapaBloc>();
    
    final inicio = context.bloc<MiUbicacionBloc>().state.ubicacion;   // Tenemos nuestra ultima ubicacion
    final destino = mapabloc.state.ubicacionCentral;

    final trafficResponse = await trafficService.getCoordsInicioDestino(inicio, destino);
    
    final geometry = trafficResponse.routes[0].geometry;
    final duracion = trafficResponse.routes[0].duration;
    final distancia = trafficResponse.routes[0].distance;
    // Decodificar los puntos del Geometry

    final points = Poly.Polyline.Decode(encodedString:geometry, precision: 6 ).decodedCoords;
    final List<LatLng> rutaCoordenadas = points.map(
      (point) => LatLng(point[0], point[1])
    ).toList();
    
    
    mapabloc.add( OncrearRutaInicioDestino(rutaCoordenadas,distancia,duracion ) );

    Navigator.of(context).pop();

    context.bloc<BusquedaBloc>().add(OnDesctivarMarcadorManual());
  }
}