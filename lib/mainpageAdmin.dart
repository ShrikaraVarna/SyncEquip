import 'package:SyncEquip/displayData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:SyncEquip/addNewpage.dart';
import 'auth.dart';
import 'display2.dart';
import 'package:SyncEquip/qrscan.dart';

import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';

class MainPageAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text(
          "SyncEquip",
          style: TextStyle(
            fontFamily:'Schyler',
            fontSize: 40,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.cyan[400],
      ),

      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.cyan[400]])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget> [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => addNewpage()));
                  },
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                    child: Text(
                      "ADD NEW",
                      style: TextStyle(
                          color: Colors.cyan[500],
                          fontSize: 36
                      ),
                    ),
                  ),
                ),
              ],
            ),
            RaisedButton(

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => display2() ));
              },

              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                child: Text(

                  "CHECK STATUS",
                  style: TextStyle(
                      color: Colors.cyan[500],

                      //fontWeight: FontWeight.bold,
                      fontSize: 36
                  ),
                ),
              ),
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  QRScan()));
              },
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                child: Text(
                  "SCAN QR",
                  style: TextStyle(
                      color: Colors.cyan[500],
                      //fontWeight: FontWeight.bold,
                      fontSize: 36
                  ),
                ),
              ),
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
              ),
              onPressed: (){
                context.read<Authenticate>().logout();
              },
              color: Colors.blue[600],
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                child: Text(
                  "LOGOUT",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}