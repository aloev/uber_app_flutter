

part of 'helpers.dart';


void calculandoAlerta( BuildContext context){


  if( Platform.isAndroid){

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Espere Por Favor'),
        content: Text('Calculando Ruta'),
      ),
    );
  } else {

    showCupertinoDialog(context: context, builder: (context) => CupertinoAlertDialog(
       title: Text('Espere Por Favor'),
        content: Text('Calculando Ruta'),
    ));
  }

}