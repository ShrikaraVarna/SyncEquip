import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:SyncEquip/mainpageAdmin.dart';
import 'package:SyncEquip/mainpageUser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import 'crud.dart';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';



class QRScanU extends StatefulWidget {
  @override
  _QRScanState createState() => _QRScanState();
}

class _QRScanState extends State<QRScanU> {
  Uint8List bytes = Uint8List(0);
  String id;

  @override
  QuerySnapshot devlist;
  crudMethods crudObj = new crudMethods();

  @override
  initState() {
    crudObj.fetchData().then((results) {
      setState(() {
        devlist = results;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Scan or Upload QR"),
          centerTitle: false,
          automaticallyImplyLeading: true,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.white, Colors.cyan[400]])),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 40),
                    this._buttonGroup(this.context),
                    SizedBox(height: 40),
                    RaisedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MainPageAdmin()));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Text("Back to Home Page"),
                    ),
                  ],
                ),
              );
          },
        ),
      ),
    );
  }

  Widget _buttonGroup(BuildContext context) {
    print(this.id);
    if(this.id!=null)
    {
      print("in");
      get(this.context);
    }
    print(this.id);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:  this.id == null ? Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 160,
              child: InkWell(
                onTap: _scan,
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Image.asset('assets/Scan.png'),
                      ),
                      Divider(height: 20),
                      Expanded(flex: 1, child: Text("Scan")),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 160,
              child: InkWell(
                onTap: _scanPhoto,
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Image.asset('assets/scan.jpg'),
                      ),
                      Divider(height: 20),
                      Expanded(flex: 1, child: Text("Scan Photo")),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )
          : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MainPageUser()));
            },
            color: Colors.amber[600],
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 13),
              child: Text(
                "Back to Home Page",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 26
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future _scan() async {
    String barcode = await scanner.scan();
    if (barcode == null) {
      print('nothing return.');
    } else {
      setState(() {
        this.id=barcode;
      });
    }
  }

  Future _scanPhoto() async {
    String barcode = await scanner.scanPhoto();
    setState(() {
      this.id=barcode;
    });
  }

  Future _scanPath(String path) async {
    String barcode = await scanner.scanPath(path);
    this.id = barcode;
  }

  Future _scanBytes() async {
    File file = await ImagePicker.pickImage(source: ImageSource.camera);
    Uint8List bytes = file.readAsBytesSync();
    String barcode = await scanner.scanBytes(bytes);
    setState(() {
      this.id=barcode;
    });
  }

  get(BuildContext context){
    if(devlist!=null)
    {
      Map<String, dynamic> deviceData;
      print("inside if1");
      for(var i=0; i<devlist.docs.length; i++)
      {
        if(devlist.docs[i].id == this.id)
        {
          print('inside if2');
          print(devlist.docs[i]['status']);
          if(devlist.docs[i]['status'] == "available")
          {
            print('inside if3');
            deviceData= {'device_name': devlist.docs[i]['device_name'], 'device_dept':devlist.docs[i]['device_dept'],
              'MFD': devlist.docs[i]['MFD'], 'service':devlist.docs[i]['service'], 'devtype':devlist.docs[i]['devtype'],
              'dbuilding':devlist.docs[i]['dbuilding'], 'dfloor':devlist.docs[i]['dfloor'], 'droom':devlist.docs[i]['droom'], 'status':"unavailable"};
            FirebaseFirestore.instance.collection('DeviceData').doc(this.id).update(deviceData);
            //dialogTriggerS(context);
          }
          else
          {
            print("inside else");
            deviceData= {'device_name': devlist.docs[i]['device_name'], 'device_dept':devlist.docs[i]['device_dept'],
              'MFD': devlist.docs[i]['MFD'], 'service':devlist.docs[i]['service'], 'devtype':devlist.docs[i]['devtype'],
              'dbuilding':devlist.docs[i]['dbuilding'], 'dfloor':devlist.docs[i]['dfloor'], 'droom':devlist.docs[i]['droom'], 'status':"available"};
            FirebaseFirestore.instance.collection('DeviceData').document(this.id).update(deviceData);
            //dialogTriggerG(context);
          }
        }
      }
    }
  }

  Future<bool> dialogTriggerS(BuildContext context) async{
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context)
        {
          return AlertDialog(
            title: Text('You have selected this device Successfully', style: TextStyle(fontSize: 15.0)),
            actions: <Widget>[
              FlatButton(child: Text('OK'),
                textColor:Colors.black
                ,onPressed: (){ Navigator.of(context).pop();},
              )
            ],
          );
        });
  }

  Future<bool> dialogTriggerG(BuildContext context) async{
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context)
        {
          return AlertDialog(
            title: Text('Thanks for using this device', style: TextStyle(fontSize: 15.0)),
            actions: <Widget>[
              FlatButton(child: Text('OK'),
                textColor:Colors.black
                ,onPressed: (){ Navigator.of(context).pop();},
              )
            ],
          );
        });
  }



}