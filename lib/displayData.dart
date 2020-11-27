import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class displayData extends StatefulWidget{
  @override
  _displayDataState createState() => _displayDataState();
}

class _displayDataState extends State<displayData> {
  @override
  QuerySnapshot devlist;
  crudMethods crudObj= new crudMethods();
  int index=0;


  Widget build(BuildContext context) {
    List deviceList= crudObj.fetchData();
    return Scaffold(
      appBar: AppBar( title: Text(deviceList[0].toString()),
      ),
      body: ListView.builder(itemBuilder: (context, index){
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Device Name',
                  style:TextStyle(
                  fontSize: 22,
                fontWeight: FontWeight.bold
              ),
          ),
                  Text('Device Department'),
                ],
              ),
            ),
          ),
        );
    },
        itemCount:deviceList.length,
      ),
    );
  }
}