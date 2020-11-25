import 'package:flutter/material.dart';
import 'package:SyncEquip/demo.dart';

// Demonstrates how to use autofill hints. The full list of hints is here:
// https://github.com/flutter/engine/blob/master/lib/web_ui/lib/src/engine/text_editing/autofill_hint.dart
class addNewpage extends StatefulWidget {
  @override
  _addNewpageState createState() => _addNewpageState();
}

class _addNewpageState extends State<addNewpage> {
  final _formKey = GlobalKey<FormState>();

  Widget _scanButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Demo()),
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

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Demo()),
        );
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
                      decoration: InputDecoration(
                        labelText: 'Name of Device',
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Device's Department",
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Time for next Service',
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Manufactured Date',
                      ),
                    ),

                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Location- Building Name',
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Location- Floor No.',
                      ),
                    ),
                    TextField(
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
