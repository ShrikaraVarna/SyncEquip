import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'location.dart';

class mapDisplay extends StatefulWidget{
  @override
  final Position initialPosition;
  mapDisplay(this.initialPosition);
  State<StatefulWidget> createState() => _mapDisplayState();
  }


class _mapDisplayState extends State<mapDisplay>
{
  final Geolocation geoService = Geolocation();
  Completer<GoogleMapController> _controller= Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: GoogleMap(
        initialCameraPosition: CameraPosition(target: LatLng(
          widget.initialPosition.latitude, widget.initialPosition.longitude), zoom: 18.0),
        mapType: MapType.normal,
        myLocationEnabled: true,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
        ),
      ) ,
      );
    throw UnimplementedError();
  }

  Future<void> centerScreen(Position position) async{
    final GoogleMapController controller= await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 18.0)));
  }

  void initState()
  {
    geoService.getCurrentLocation().listen((position){
      centerScreen(position);
    });
    super.initState();
  }
}