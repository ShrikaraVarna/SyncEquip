import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission/permission.dart';
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
  GoogleMapController _controller;
  final Set<Polyline> polyline = {};
  List<LatLng> routecords=[];
  List<LatLng> usercords=[];

  GoogleMapPolyline googleMapPolyline = new GoogleMapPolyline(apiKey: "AIzaSyDyMT8t_DlTKh5BKR8EgwZrFlSPTZPGY1w");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  GoogleMap(
        initialCameraPosition: CameraPosition(target: LatLng(
          widget.initialPosition.latitude, widget.initialPosition.longitude), zoom: 18.0),
        mapType: MapType.normal,
        myLocationEnabled: true,
        onMapCreated: onMapCreated,
        polylines: polyline,
        ),
      );
    throw UnimplementedError();
  }

  void onMapCreated (GoogleMapController controller){
    setState(() {
      _controller=(controller);
      polyline.add(Polyline(
          polylineId: PolylineId('route1'),
          visible: true,
          points: routecords,
          width: 4,
          color: Colors.blue,
          startCap: Cap.roundCap,
          endCap: Cap.buttCap
      ));

    });

  }


  Future<void> centerScreen(Position position) async{
    final GoogleMapController controller= await _controller;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 18.0)));
  }

  getsomePoints() async
  {
    var permissions = await Permission.getPermissionsStatus([PermissionName.Location]);

    if(permissions[0].permissionStatus== PermissionStatus.notAgain){
      var askpermissions = await Permission.requestPermissions([PermissionName.Location]);
    }
    else {
      //usercords = geoService.getCurrentLocation() as List<LatLng>;
      routecords = await googleMapPolyline.getCoordinatesWithLocation(
          origin: LatLng(12.9103, 77.5408),
          destination: LatLng(12.9100, 77.5424),
          mode: RouteMode.driving);
    }
  }

  void initState()
  {
    super.initState();
    geoService.getCurrentLocation().listen((position){
      getsomePoints();
      centerScreen(position);
    });

  }
}