import 'package:SyncEquip/mapDisplay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'location.dart';
class connectorPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _connectorPageState();
}

class _connectorPageState extends State<connectorPage>{
  final geoService= Geolocation();
  @override
  Widget build(BuildContext context) {
    return FutureProvider(create: (context) => geoService.getInitialLocation(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title:'Connector',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Consumer<Position>(builder: (context,position,widget){
            return (position!=null) ? mapDisplay(position) : Center(child: CircularProgressIndicator());
            },
          ),
          ),
    );
  }
}