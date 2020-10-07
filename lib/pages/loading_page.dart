

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as Geolocator;
import 'package:permission_handler/permission_handler.dart';
import 'package:primer_proyecto/helpers/helpers.dart';
import 'package:primer_proyecto/pages/acceso_gps_page.dart';
import 'package:primer_proyecto/pages/mapa_page.dart';

import 'package:permission_handler/permission_handler.dart' as handler;

class LoadingPage extends StatefulWidget {

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {


  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

 @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    
    if ( state == AppLifecycleState.resumed){

      if(  await Geolocator.isLocationServiceEnabled()){
        Navigator.pushReplacement(context, navegarMapaFadeIn(context, MapaPage()));
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: this.checkGpsYLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          
          if ( snapshot.hasData){
            return Center(
              child: Text(snapshot.data),
            );
          } else {
            return Center(
          child: CircularProgressIndicator(strokeWidth: 3,)
          );
          }
        },
      ),
   );
  }

  Future checkGpsYLocation( BuildContext context)async{

    // TODO: Permiso Gps

    final permisoGps = await Permission.location.isGranted;
    // TODO: GPS esta activo

    final gpsActivo = await Geolocator.isLocationServiceEnabled();

    await Future.delayed(Duration(milliseconds: 1000));


    if ( permisoGps && gpsActivo){

      Navigator.pushReplacement(context, navegarMapaFadeIn(context, MapaPage()));
      
      return '';

    } else if( !permisoGps ){

      Navigator.pushReplacement(context, navegarMapaFadeIn(context, AccesoGpsPage()));

      return 'Es necesario el Permiso del GPS';
    
    } else if( gpsActivo ){


      return 'Active GPS';

    }

    // Navigator.pushReplacement(context, navegarMapaFadeIn(context, AccesoGpsPage()));
  }
}

class FutureBuilde {
}