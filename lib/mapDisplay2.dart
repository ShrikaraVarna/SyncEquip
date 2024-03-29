import 'package:flutter/material.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission/permission.dart';

class mapDisplay2 extends StatefulWidget {
  @override
  mapDisplay2State createState() => mapDisplay2State();
}

class mapDisplay2State extends State<mapDisplay2> {
  final Set<Polyline> polyline = {};

  GoogleMapController _controller;
  List<LatLng> routeCoords;
  GoogleMapPolyline googleMapPolyline =
  new GoogleMapPolyline(apiKey: "AIzaSyDyMT8t_DlTKh5BKR8EgwZrFlSPTZPGY1w");

  getsomePoints() async {
    var permissions =
    await Permission.getPermissionsStatus([PermissionName.Location]);
    if (permissions[0].permissionStatus == PermissionStatus.notAgain) {
      var askpermissions =
      await Permission.requestPermissions([PermissionName.Location]);
    } else {
      routeCoords = await googleMapPolyline.getCoordinatesWithLocation(
          origin: LatLng(40.6782, -73.9442),
          destination: LatLng(40.6944, -73.9212),
          mode: RouteMode.driving);
    }
  }

  getaddressPoints() async {
    routeCoords = await googleMapPolyline.getPolylineCoordinatesWithAddress(
        origin: '55 Kingston Ave, Brooklyn, NY 11213, USA',
        destination: '178 Broadway, Brooklyn, NY 11211, USA',
        mode: RouteMode.driving);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getaddressPoints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
          onMapCreated: onMapCreated,
          polylines: polyline,
          initialCameraPosition:
          CameraPosition(target: LatLng(40.6782, -73.9442), zoom: 14.0),
          mapType: MapType.normal,
        ));
  }

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller = controller;

      polyline.add(Polyline(
          polylineId: PolylineId('route1'),
          visible: true,
          points: routeCoords,
          width: 4,
          color: Colors.blue,
          startCap: Cap.roundCap,
          endCap: Cap.buttCap));
    });
  }
}