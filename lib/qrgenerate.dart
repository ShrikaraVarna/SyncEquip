import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import 'crud.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:path/path.dart';



class QRGenerate extends StatefulWidget {
  final String name;

  QRGenerate({Key key, @required this.name}) : super(key: key);


  @override
  _QRGenerateState createState() => _QRGenerateState(name);
}

class _QRGenerateState extends State<QRGenerate> {
  String name1;

  _QRGenerateState(this.name1);

  Uint8List bytes = Uint8List(0);
  String id;


  @override
  QuerySnapshot devlist2;
  crudMethods crudObj = new crudMethods();


  @override
  void initState() {
    crudObj.fetchData().then((results) {
      setState(() {
        devlist2 = results;
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
          title: Text("SyncEquip"),
          centerTitle: true,
          automaticallyImplyLeading: true,

        ),
        backgroundColor: Colors.grey[300],
        body: Builder(
          builder: (BuildContext context) {
            return ListView(
              children: <Widget>[
                _qrCodeWidget(this.bytes, context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _qrCodeWidget(Uint8List bytes, BuildContext context) {
    if(this.bytes.isEmpty)
      {
        _generateCode();
      }
    return Padding(
      padding: EdgeInsets.all(20),
      child: Card(
        elevation: 6,
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Icon(Icons.verified_user, size: 18, color: Colors.green),
                  Text('  Generate QR Code', style: TextStyle(fontSize: 15)),
                  Spacer(),
                  Icon(Icons.more_vert, size: 18, color: Colors.black54),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4), topRight: Radius.circular(4)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 40, right: 40, top: 30, bottom: 10),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 190,
                    child: this.bytes.isEmpty
                        ? Center(
                      child: Text('Empty Code ... ',
                          style: TextStyle(color: Colors.black38)),
                    )
                        : Image.memory(this.bytes),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 7, left: 25, right: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: GestureDetector(
                            child: Text(
                              'Remove',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.blue),
                              textAlign: TextAlign.left,
                            ),
                            onTap: () =>
                                this.setState(() => this.bytes = Uint8List(0)),

                          ),
                        ),
                        Text('|', style: TextStyle(fontSize: 15, color: Colors
                            .black26)),
                        Expanded(
                          flex: 5,
                          child: GestureDetector(
                            onTap: () async {
                              final success = await ImageGallerySaver.saveImage(
                                  this.bytes);
                              SnackBar snackBar;
                              if (success) {
                                snackBar = new SnackBar(content: new Text(
                                    'Successful Preservation!'));
                                Scaffold.of(context).showSnackBar(snackBar);
                              } else {
                                snackBar =
                                new SnackBar(content: new Text('Save failed!'));
                              }
                            },
                            child: Text(
                              'Save',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.blue),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(height: 2, color: Colors.black26),
            Container(
              child: Row(
                children: <Widget>[
                  Icon(Icons.history, size: 16, color: Colors.black38),
                  Text('  Generate History',
                      style: TextStyle(fontSize: 14, color: Colors.black38)),
                  Spacer(),
                  Icon(Icons.chevron_right, size: 16, color: Colors.black38),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
            )
          ],
        ),
      ),
    );
  }

   Future _generateCode() async {
    if(devlist2!=null)
      {
        for(var i =0; i<devlist2.docs.length;i++)
          {
            if(devlist2.docs[i]['device_name'] == name1)
              {
                id = devlist2.docs[i].id;
                Uint8List result = await scanner.generateBarCode(id);
                setState(() {
                  this.bytes=result;
                });
              }
          }
      }
}

}