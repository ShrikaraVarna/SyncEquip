import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:SyncEquip/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'crud.dart';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:path/path.dart';

class display2 extends StatefulWidget{
  @override
  _display2State createState() => _display2State();
}

class _display2State extends State<display2> {
  @override
  QuerySnapshot devlist;
  crudMethods crudObj = new crudMethods();


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Device Info'),
      ),
      body: Center(
        child:Column(
          children: <Widget>[
            Text(
                'View Devices',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..shader = ui.Gradient.linear(
                      const Offset(0, 75),
                      const Offset(150, 75),
                      <Color>[
                        Colors.lightBlueAccent,
                        Colors.deepPurple,
                      ],
                    ),
                fontFamily: 'Schyler',
                fontFamilyFallback: <String>[
                  'Noto Sans CJK SC',
                  'Noto Color Emoji',
                ],
              ),
            ),
            Expanded(
                child: Container(
                    child: devListDisplay()
                ),
            ),
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }

  @override
  void initState() {
    crudObj.fetchData().then((results) {
      setState(() {
        devlist = results;
      });
    });
    super.initState();
  }


  Future<bool> dialogTrigger(BuildContext context) async {
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                'Device Added Successfully', style: TextStyle(fontSize: 15.0)),
            actions: <Widget>[
              FlatButton(child: Text('OK'),
                textColor: Colors.black
                , onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Widget devListDisplay(){
    if(devlist!=null)
      {
        return ListView.builder(
          itemCount: devlist.docs.length,
          padding: EdgeInsets.all(10.0),
          itemBuilder: (context,i){
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                //clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                child: Column(
                  children: <Widget>[ new ListTile(
                title: Text( devlist.docs[i]['device_name']),
                subtitle: Text(devlist.docs[i]['device_dept']),
              ),

                FlatButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                  ),
                  child: Text('Location'),
                  onPressed:() {
                    showDialog(context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                                "Location Details\nBuilding: "+devlist.docs[i]['dbuilding']+"\nFloor-"+devlist.docs[i]['dfloor']+
                                    "\nRoom- "+devlist.docs[i].id,
                                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),

                            actions: <Widget>[
                              FlatButton(child: Text('OK'),
                                textColor: Colors.black
                                , onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        });
                  },
                  color: Colors.greenAccent,
                ),
           ],
                ),
              ),
            );
          },
        );
      }
    else
      {
        return Text('Loading.. Please Wait');
      }
  }


}//End of _display2State class

