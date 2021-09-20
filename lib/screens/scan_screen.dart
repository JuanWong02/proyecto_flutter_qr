import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class PantallaEscanear extends StatefulWidget {
  const PantallaEscanear({Key? key}) : super(key: key);

  @override
  _PantallaEscanearState createState() => _PantallaEscanearState();
}

class _PantallaEscanearState extends State<PantallaEscanear> {
  String codigo = "";
  @override
  initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined, ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text('ESCANEAR QR'),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget> [
            Padding(padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor
                ),
                onPressed: escanear,
                child: const Text('INICIAR CAMARA'),
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(codigo, textAlign: TextAlign.center),

            ),
          ],
        ),
      ),
    );
  }
  Future escanear() async {
    try {
      String? ResultadoCam = await scanner.scan();
      setState(() {
        codigo = ResultadoCam!;
        AbrirURL();
      });
    }  on PlatformException catch (e) {
      print(e);
    }

  }
  void AbrirURL() async => await canLaunch(codigo) ? await launch(codigo) : throw 'No se pudo abrir $codigo';
}






