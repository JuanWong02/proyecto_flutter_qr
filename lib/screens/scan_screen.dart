import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  String codigo = "";
  @override
  initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Escaner QR'),
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
              onPressed: () {},
              child: const Text('INICIAR CAMARA'),
            ),
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(codigo, textAlign: TextAlign.center,),
            ),
          ],
        ),
      ),
    );
  }
  Future escanear() async {
    try {
      String codigo = (await BarcodeScanner.scan()) as String;
      setState(() => this.codigo = codigo);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          this.codigo =
          'El usuario no concedio los permisos para usar la camara';
        });
      } else {
        setState(() => this.codigo = 'Error desconocido: $e');
      }
    } on FormatException {
      setState(() =>
      this.codigo =
      'null (El usuario presiono el boton "regresar" antes de escanear)');
    } catch (e) {
      setState(() => this.codigo = 'Error desconocido: $e');
    }
  }
}

