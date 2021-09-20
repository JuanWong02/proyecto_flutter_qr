import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_scanner/screens/generate_screen.dart';
import './screens/scan_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ESCANER Y GENERADOR QR',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(5, 145, 110, 1),
        cardColor: Theme.of(context).primaryColor,
        accentColor: Colors.white,
        splashColor: Colors.lightGreen,
        fontFamily: 'Roboto',
      ),
      home: PantallaInicio(),
    );
  }
}


class PantallaInicio extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('ESCANER Y GENERADOR QR'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget> [
            Padding(padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor
              ),
              onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PantallaEscanear()),
              );
              },
              child: const Text('ESCANEAR QR'),
            ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PantallaGenerar()),
              );
              },
              child: const Text('GENERAR QR'),
            ),

            ),
          ],
        ),
      ),
    );
  }
}
