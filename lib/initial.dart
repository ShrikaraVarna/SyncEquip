import 'package:flutter/material.dart';
import 'dart:async';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:SyncEquip/src/welcomePage.dart';
import 'delayed_animation.dart';
import 'auth.dart';



class Initial extends StatefulWidget {
  @override
  _InitialState createState() => _InitialState();
}

class _InitialState extends State<Initial> with SingleTickerProviderStateMixin {
  final int delayedAmount = 400;
  double _scale;
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    _scale = 1 - _controller.value;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.blueAccent[700],
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 0),
              child: ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        AvatarGlow(
                          endRadius: 130,
                          duration: Duration(seconds: 2),
                          glowColor: Colors.white24,
                          repeat: true,
                          repeatPauseDuration: Duration(seconds: 2),
                          startDelay: Duration(seconds: 1),
                          child: Material(
                              elevation: 6.0,
                              shape: CircleBorder(),
                              child: CircleAvatar(
                                backgroundColor: Colors.blueAccent[700],
                                backgroundImage: AssetImage("assets/LOGO.jpg"),
                                radius: 70,
                              )),
                        ),
                        DelayedAnimation(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 0),
                            child: Text(
                              "SyncEquip",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 65.0,
                                  fontFamily: "Adam",
                                  color: color),
                            ),
                          ),
                          delay: delayedAmount + 2000,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        SizedBox(
                          height: 90.0,
                        ),
                        DelayedAnimation(
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MyApp()),
                              );
                            },
                            color: Colors.amber[600],
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 33),
                              child: Text(
                                "CONTINUE",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    fontFamily: 'Nexa_Light'),
                              ),
                            ),
                          ),
                          delay: delayedAmount + 4000,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ]
              ),
            ),
          )
      ),
    );
  }
}
