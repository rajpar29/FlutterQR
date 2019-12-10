import 'dart:async';

import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

import './assetHistory.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  String message = "Scan to Find History";

  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      Navigator.push(context, MaterialPageRoute(builder: (context)=> AssetHistory(qrResult)));
//      setState(() {
//        result = qrResult;
//      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          message = "Camera permission was denied";
        });
      } else {
        setState(() {
          message = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        message = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        message = "Unknown Error $ex";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("FarmLedger"),
      ),
      body: Center(
        child: Text(
          message,
          style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        label: Text("Scan"),
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
