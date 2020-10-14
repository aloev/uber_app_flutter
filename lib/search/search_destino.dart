

import 'package:flutter/material.dart';
import 'package:primer_proyecto/models/search_result.dart';

class SearchDestination extends SearchDelegate <SearchResult>{

  @override
  final String searchFieldLabel;
  SearchDestination(): this.searchFieldLabel = 'Buscar..';


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
     return Text('Build Results');
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {

      // Se despliega

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




}