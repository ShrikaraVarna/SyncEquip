import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
import 'Widget/bezierContainer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body:Center(
        child: Column(
          children: [
            Text("Home page"),
            Padding(
              padding: const EdgeInsets.all(100.0),
              child: RaisedButton(
                onPressed: (){
                context.read<Authenticate>().logout();
              },
              child: Text("Logout"),
        ),
            ),
      ],
      ),
    ),
    );
  }
}