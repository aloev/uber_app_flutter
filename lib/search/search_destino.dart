

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:primer_proyecto/models/search_response.dart';
import 'package:primer_proyecto/models/search_result.dart';
import 'package:primer_proyecto/services/traffic_service.dart';

class SearchDestination extends SearchDelegate <SearchResult>{

  @override
  final String searchFieldLabel;

  final TrafficService _trafficService;

  final LatLng proximidad;

  final List<SearchResult> historial;

  SearchDestination(this.proximidad, this.historial)
  : this.searchFieldLabel = 'Buscar..',
  this._trafficService = new TrafficService();


  @override
  List<Widget> buildActions(BuildContext context) {


    return [
      IconButton(
        icon: Icon( Icons.clear), 
        onPressed: ()=>this.query = ''
      )
    ];
    
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      // TODO: Retornar algo

    

      return IconButton(
        icon: Icon( Icons.arrow_back), 
        onPressed: ()=> this.close(context,SearchResult(cancelo: true))
      );
    }
  
    @override
    Widget buildResults(BuildContext context) {


     return this._construirResultadosSugerencias();
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {

      if( this.query.length == 0 ){
          return ListView(
            children: [
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text('Colocar Ubicacion manual'),
                onTap: (){
                  // Retornar Algo
                  this.close(context, SearchResult(cancelo: false, manual: true));
                },
              ),

              ...this.historial.map(
                (result) =>  ListTile(
                  leading: Icon( Icons.history),
                  title: Text(result.nombreDestino),
                  subtitle: Text(result.descripcion),
                  onTap: (){
                    this.close(context, result);
                  },
                )
              ).toList()


            ],
          );
      }


      return this._construirResultadosSugerencias();


      // Se despliega

  }


  // Widget de Sugerencias

  Widget _construirResultadosSugerencias(){

    if( this.query == 0){
      return Container();
    }

    // Se llama el respectivo Servicio

    this._trafficService.getSugerenciasPorQuery(this.query.trim(), this.proximidad);

    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot<SearchResponse> snapshot) { 

        if(!snapshot.hasData){

          return Center(child: CircularProgressIndicator(),);
        }else {
          
          final lugares = snapshot.data.features;

          if( lugares.length == 0){
            return ListTile(
              title: Text('No hay resultados con $query'),
            );
          }

          return ListView.separated(
            itemBuilder: (_, i){
              final lugar = lugares[i];
              return ListTile(
                leading: Icon( Icons.place),
                title: Text(lugar.textEs),
                subtitle: Text(lugar.placeNameEs),
                onTap: (){
                  
                  this.close(context, SearchResult(
                    cancelo: false,
                    manual: false,
                    // Acuerdese que mapbox entrega longitud y latitud en un array llamado lugar
                    position: LatLng(lugar.center[1],lugar.center[0]),
                    nombreDestino: lugar.textEs,
                    descripcion: lugar.placeNameEs
                  ));

                },
              );
            },
            separatorBuilder: (_, i) => Divider(),
            itemCount: lugares.length,
          );
        }
      },

      //this.query.trim(), proximidad

      // Se llama el servicio de Stream
      stream: this._trafficService.sugerenciasStream,  
      
    );

  }

}