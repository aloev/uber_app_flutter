


import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:primer_proyecto/models/search_response.dart';
import 'package:primer_proyecto/models/traffic_response.dart';

class TrafficService {

  // Singleton
  TrafficService._privateConstructor();

  static final TrafficService _instance = TrafficService._privateConstructor();
  factory TrafficService(){
    return _instance;
  }

  final _dio = new Dio();
  final _baseUrlDir = 'https://api.mapbox.com/directions/v5';
  final _baseUrlGeo = 'https://api.mapbox.com/geocoding/v5';
  final _apiKey = 'pk.eyJ1IjoicHJ1ZWJhcGFnaW5hczAxIiwiYSI6ImNrZzYyeGVyODA1ZTUzNnIxbXRvM3U2NzYifQ.Qq1xLEK3Uq_ZyPu1Jjoxdw';


  // Genera polylines entre Origen y Destino

  Future<DrivingResponse> getCoordsInicioDestino(LatLng inicio, LatLng destino) async{
    
    final coordString = '${inicio.longitude},${inicio.latitude};${destino.longitude},${destino.latitude}';
    final url = '${this._baseUrlDir}/mapbox/driving/$coordString';

    final resp = await this._dio.get( url, queryParameters: {

      'alternatives' :  'true',
      'geometries'   : 'polyline6',
      'steps'        : 'false',
      'access_token' :  this._apiKey,
      'language'     : 'es',
    });

    final data = DrivingResponse.fromJson(resp.data);

   
    return data;
  }

  // Obtiene resultados producto de una busqueda

  Future<SearchResponse> getResultadosPorQuery( String busqueda, LatLng proximidad)async{

    final url = '${this._baseUrlGeo}/mapbox.places/$busqueda.json';
    
    try {
      final resp = await this._dio.get(url, queryParameters: {

        'access_token' : this._apiKey,
        'autocomplete' : 'true',
        'proximity'    : '${proximidad.longitude},${proximidad.latitude}',
        'language'     : 'es',
      });


      final searchResponse = searchResponseFromJson(resp.data);

      return searchResponse;
    } catch (e) {
      return SearchResponse(features: []);
    }
    
    

  }


}