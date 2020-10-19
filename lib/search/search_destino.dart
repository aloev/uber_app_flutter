

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

  SearchDestination(this.proximidad)
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
              )
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

    return FutureBuilder(
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
                  print(lugar);
                },
              );
            },
            separatorBuilder: (_, i) => Divider(),
            itemCount: lugares.length,
          );
        }
      },
      future: this._trafficService.getResultadosPorQuery(this.query.trim(), proximidad),  
      
    );

  }

}