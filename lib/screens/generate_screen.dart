import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/rendering.dart';
//import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';



class PantallaGenerar extends StatefulWidget {

  @override
  _PantallaGenerarState createState() => _PantallaGenerarState();
}

class _PantallaGenerarState extends State<PantallaGenerar> {

  static const double _PaddingSeccionSuperior = 70.0;
  static const double _PaddingSeccionInferior = 20.0;
  static const double _AlturaSeccionSuperior = 30.0;

  File? file;

  GlobalKey globalKey = new GlobalKey();
  String _stringDatos = "QR DE EJEMPLO";
  final TextEditingController _controladorTexto = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined, ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text('GENERADOR QR'),
        actions: [
          IconButton(onPressed: _CapturarYcompartirPng, icon: Icon(Icons.share)),
        ],
        backgroundColor: Color.fromRGBO(5, 145, 110, 1),
      ),
      body: _contenidoWidget(),
    );
  }

  Future<void> _CapturarYcompartirPng() async {
    try {
      RenderRepaintBoundary boundary = globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;

      var image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final appDir = await getExternalStorageDirectory();

      var datetime = DateTime.now();

      file = await File('${appDir.path}/imagen.png').create();

      await file?.writeAsBytes(pngBytes);

      print(file!.path);

      await Share.shareFiles(
        [file!.path],
        mimeTypes: ["image/png"],
        text: "compartir QR",
        subject: "QR"
      );
    } catch(e) {
      print(e.toString());
    }
  }
  _contenidoWidget() {
    final AlturaBody = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
    return Container(

      color: const Color(0xFFFFFFFF),
      child: Column(
        children: <Widget> [

          Padding(
            padding: const EdgeInsets.only(
              top: _PaddingSeccionSuperior,
              left: 20.0,
              right: 10.0,
              bottom: _PaddingSeccionInferior,
            ),
            child: Container(
              height: _AlturaSeccionSuperior,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget> [
                  Expanded(child:  TextFormField(
                    controller: _controladorTexto,
                    decoration: InputDecoration(
                      hintText: 'Escribe el Mensaje o Enlace',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF6200EE)),
                      ),
                    ),
                  ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: ElevatedButton(
                      child: Text("Generar"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _stringDatos = _controladorTexto.text;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(child: Center(
            child: RepaintBoundary(
              key: globalKey,
              child: QrImage(
                version: QrVersions.auto,
                data: _stringDatos,
                size: 0.5 * AlturaBody,
              ),
            ),
          )),
        ],
      ),
    );
  }
}
