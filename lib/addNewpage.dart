import 'package:flutter/material.dart';
import 'package:SyncEquip/demo.dart';
import 'qrscan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'crud.dart';
// Demonstrates how to use autofill hints. The full list of hints is here:
// https://github.com/flutter/engine/blob/master/lib/web_ui/lib/src/engine/text_editing/autofill_hint.dart
class addNewpage extends StatefulWidget {
  @override
  _addNewpageState createState() => _addNewpageState();
}

class _addNewpageState extends State<addNewpage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController devicename = new TextEditingController();
  TextEditingController devicedept = new TextEditingController();
  TextEditingController mfd= new TextEditingController();
  TextEditingController servicedate = new TextEditingController();
  TextEditingController building = new TextEditingController();
  TextEditingController floor = new TextEditingController();
  TextEditingController room = new TextEditingController();

  crudMethods crudObj= new crudMethods();

  Widget _scanButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QRScan()),
        );
      },

      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 60),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.brown[300], Colors.brown[400]])),

        child: Text(
          'Scan QR Code',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),

      ),
    );
  }

  clearTextInput(){
    devicedept.clear(); devicename.clear();
    mfd.clear(); servicedate.clear();
    room.clear(); building.clear();
    floor.clear();
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        Map<String, dynamic> deviceData= {'device_name': this.devicename.text, 'device_dept':this.devicedept.text,
          'MFD': this.mfd.text, 'service':this.servicedate.text,
        'dbuilding':this.building.text, 'dfloor':this.floor.text, 'droom':this.room.text, 'status':"available"};
        crudObj.addData(deviceData).then((result)
        {
          dialogTrigger(context);
        }).catchError((e){
          print(e);
        });
        clearTextInput();
      },

      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.lightBlue[300], Colors.lightBlue[400]])),

        child: Text(
          'Add Device',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),

      ),
    );
  }

  Future<bool> dialogTrigger(BuildContext context) async{
    return showDialog(context: context,
    barrierDismissible: false,
    builder: (BuildContext context)
    {
      return AlertDialog(
        title: Text('Device Added Successfully', style: TextStyle(fontSize: 15.0)),
        actions: <Widget>[
          FlatButton(child: Text('OK'),
            textColor:Colors.black
            ,onPressed: (){ Navigator.of(context).pop();},
          )
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Device'),
      ),
      body: Form(
        key: _formKey,
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: AutofillGroup(
              child: Column(
                children: [
                  ...[
                    Text('Device Details', style: TextStyle(
                        color: Colors.deepPurple ,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Open Sans',
                        fontSize: 30,
                      decoration: TextDecoration.underline,),),
                    TextFormField(
                      controller: devicename,
                      decoration: InputDecoration(
                        labelText: 'Name of Device',
                      ),
                    ),
                    TextFormField(
                      controller: devicedept,
                      decoration: InputDecoration(
                        labelText: "Device's Department",
                      ),
                    ),
                    TextFormField(
                      controller: servicedate,
                      decoration: InputDecoration(
                        labelText: 'Time for next Service',
                      ),
                    ),
                    TextFormField(
                      controller: mfd,
                      decoration: InputDecoration(
                        labelText: 'Manufactured Date',
                      ),
                    ),

                    TextFormField(
                      controller: building,
                      decoration: InputDecoration(
                        labelText: 'Location- Building Name',
                      ),
                    ),
                    TextFormField(
                      controller: floor,
                      decoration: InputDecoration(
                        labelText: 'Location- Floor No.',
                      ),
                    ),
                    TextFormField(
                      controller: room,
                      decoration: InputDecoration(
                        labelText: 'Location- Room No.',
                      ),
                    ),
                    SizedBox(height: 20),
                    _scanButton(),
                    SizedBox(height: 20),
                    _submitButton(),
                  ].expand(
                        (widget) => [
                      widget,
                      SizedBox(
                        height: 24,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
