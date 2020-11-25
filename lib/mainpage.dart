import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:SyncEquip/addNewpage.dart';
import 'auth.dart';
import 'demo.dart';
import 'package:SyncEquip/qrscan.dart';

import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "SyncEquip",
          style: TextStyle(
            fontSize: 40,
            color: Colors.amberAccent
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget> [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0)
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => addNewpage()));
                },
                color: Colors.amber[600],
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 33,horizontal: 33),
                  child: Text(
                    "ADD NEW",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 36
                    ),
                  ),
                ),
              ),
            ],
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0)
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Demo()));
            },
            color: Colors.amber,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 33,horizontal: 33),
              child: Text(
                "CHECK STATUS",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 36
                ),
              ),
            ),
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0)
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => QRScan()));
            },
            color: Colors.amber[600],
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 33,horizontal: 33),
              child: Text(
                "SCAN QR",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 36
                ),
              ),
            ),
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0)
            ),
            onPressed: (){
              context.read<Authenticate>().logout();
            },
            color: Colors.indigo[600],
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 33),
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
    );
  }
}
