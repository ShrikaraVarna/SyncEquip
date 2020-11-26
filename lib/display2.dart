import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:SyncEquip/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'crud.dart';
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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              dialogTrigger(context);
            },
          )
        ],
      ),
      body: devListDisplay(),
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
          itemCount: devlist.documents.length,
          padding: EdgeInsets.all(10.0),
          itemBuilder: (context,i){
            return new ListTile(
              title: Text(devlist.docs[i]['device_name']),
              subtitle: Text(devlist.docs[i]['device_dept']),
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

