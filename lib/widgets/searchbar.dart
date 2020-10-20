part of 'widgets.dart';

class SearchBar extends StatelessWidget {


    @override
  Widget build(BuildContext context) {

      // Mire como se hace referencia a un Bloc especìfico
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if (state.seleccionManual){
          return Container();
        }else {
          return FadeInDown(
            duration: Duration(milliseconds: 300),
            child: buildSearchBar(context));
        }
      },
    );
  }

  
  Widget buildSearchBar(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          width: width,
          child: GestureDetector(
            onTap: ()async {

              final proximidad = context.bloc<MiUbicacionBloc>().state.ubicacion;
              final historial = context.bloc<BusquedaBloc>().state.historial;

              final resultado = await showSearch(
                context: context, 
                delegate: SearchDestination(proximidad, historial));
                this.retornoBusqueda(context, resultado);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
              width: double.infinity,
              child: Text('Donde quieres ir?', style: TextStyle(color: Colors.black87),),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12, blurRadius: 5, offset: Offset(0, 5)
                  )
                ]
              ),
            ),
          ),
      ),
    );
  }


  Future retornoBusqueda(BuildContext context, SearchResult result) async{
    if (result.cancelo) return;

      
    if(result.manual){
      context.bloc<BusquedaBloc>().add(OnActivarMarcadorManual());
      return;
    }

    // Calcular la ruta en Base a la posicion actual
    
    final trafficService = new TrafficService();

    // Ubicacion futuro
    final mapaBloc = context.bloc<MapaBloc>();
    // Ubicacion actual
    final inicio = context.bloc<MiUbicacionBloc>().state.ubicacion;

    // El result contiene coordenadas de la busqueda
    final destino = result.position;

    final drivingResponse = await trafficService.getCoordsInicioDestino(inicio, destino);

    // Contiene la ruta actual
    final geometry = drivingResponse.routes[0].geometry;
    final duracion = drivingResponse.routes[0].duration;
    final distancia = drivingResponse.routes[0].distance;

    // Se llama a las Polylines

    final points = Poly.Polyline.Decode(encodedString: geometry, precision: 6);

    final List<LatLng> rutaCoordenadas = points.decodedCoords.map(
      (point) => LatLng(point[0], point[1] )
    ).toList();

    // Hacer disparo al Bloc 

    mapaBloc.add(OncrearRutaInicioDestino(rutaCoordenadas, distancia, duracion));


    Navigator.of(context).pop();

    // Agregar al Historial

    final busquedaBloc = context.bloc<BusquedaBloc>();

    busquedaBloc.add(OnAgregarHistorial(result));

  }


}