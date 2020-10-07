

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart' as handler;


class AccesoGpsPage extends StatefulWidget {

  @override
  _AccesoGpsPageState createState() => _AccesoGpsPageState();
}

class _AccesoGpsPageState extends State<AccesoGpsPage> with WidgetsBindingObserver{


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

      if( await handler.Permission.location.isGranted){
        Navigator.pushReplacementNamed(context, 'loading');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Es necesario el GPS para usar esta app'),

            MaterialButton(
              child: Text('Solicitar Acceso', style: TextStyle(color: Colors.white),),
              color: Colors.black,
              shape: StadiumBorder(),
              onPressed: () async{ 

                //TODO: verificar permisos
                final status = await handler.Permission.location.request(); 

                this.accesoGPS(status);
                // print(status);
              },
              
            )
          ],
        ),
     ),
   );
  }

  void accesoGPS( handler.PermissionStatus status){

    switch (status) {


      case handler.PermissionStatus.granted:
        Navigator.pushReplacementNamed(context, 'mapa');
        break;
      case handler.PermissionStatus.denied:
      case handler.PermissionStatus.restricted:
      case handler.PermissionStatus.permanentlyDenied:

        handler.openAppSettings();

    }

  }
}