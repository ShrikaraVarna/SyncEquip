import 'package:flutter/material.dart';

// Demonstrates how to use autofill hints. The full list of hints is here:
// https://github.com/flutter/engine/blob/master/lib/web_ui/lib/src/engine/text_editing/autofill_hint.dart
class addNewpage extends StatefulWidget {
  @override
  _addNewpageState createState() => _addNewpageState();
}

class _addNewpageState extends State<addNewpage> {
  final _formKey = GlobalKey<FormState>();

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
