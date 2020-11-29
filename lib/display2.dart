import 'package:SyncEquip/connectorPage.dart';
import 'package:SyncEquip/location.dart';
import 'package:SyncEquip/mainpageAdmin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'crud.dart';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'mapDisplay.dart';

class device
{
  String title;
  device();
  device.fromSnapshot(DocumentSnapshot snapshot) :
      title= snapshot['device_name'];
}

class display2 extends StatefulWidget{
  @override
  _display2State createState() => _display2State();
}

class _display2State extends State<display2> {
  @override
  QuerySnapshot devlist;
  crudMethods crudObj = new crudMethods();
  TextEditingController searchText= TextEditingController();
  List tempDocs=[];
  List allDocs=[];
  final geoService= Geolocation();

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
        appBar: AppBar(
          title: Text('Device Info'),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MainPageAdmin())),
          ),
        ),
        body: Center(
          child:Column(
            children: [
              Text(
                  'View Devices',
                style: TextStyle(
                  fontSize: 40, fontWeight: FontWeight.bold,

                    foreground: Paint()
                      ..shader = ui.Gradient.linear(
                        const Offset(0, 75),
                        const Offset(150, 75),
                        <Color>[
                          Colors.white,
                          Colors.cyan,
                        ],
                      ),
                  fontFamily: 'Schyler',
                  fontFamilyFallback: <String>[
                    'Noto Sans CJK SC',
                    'Noto Color Emoji',
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top:10.0,bottom: 10.0, left: 15.0, right: 15.0),
              child: TextField(
              controller: searchText,
              decoration: InputDecoration(
                  hintText: 'Search device',
                  prefixIcon: Icon(Icons.search)
              ),
        ),
            ),
              Expanded(
                  child: Container(
                      child: devListDisplay()
                  ),
              ),
            ],
          ),
        ),
      ),
    );
    throw UnimplementedError();
  }

  @override
  void initState() {
    crudObj.fetchData().then((results) {
      setState(() {
        devlist = results;
        allDocs= devlist.docs;
        tempDocs=devlist.docs;
      });
    });
    //initState2();
    searchText.addListener(onSearchChanged);
    super.initState();
  }

  onSearchChanged()
  {
    searchbar();
  }

  searchbar() {
    var searchResults = [];
    if (searchText.text != "") {
      for (var snap in allDocs) {
        var element = device.fromSnapshot(snap).title.toLowerCase();
        if(element.contains(searchText.text.toLowerCase())) {
          searchResults.add(snap);
        }
      }
      }
    else {
      searchResults = allDocs;
    }
    setState(() {
        tempDocs=searchResults;
    });
  }


  void dispose()
  {
    searchText.removeListener(searchbar);
    searchText.dispose();
    super.dispose();
  }


  Future<bool> dialogTrigger(BuildContext context, i) async {
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                "Location Details\nBuilding: "+tempDocs[i]['dbuilding']+"\nFloor-"+tempDocs[i]['dfloor']+
                    "\nRoom- "+tempDocs[i]['droom'],
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),

            actions: <Widget>[
              FlatButton(child: Text('OK'),
                textColor: Colors.black,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Widget devListDisplay(){
    if(devlist!=null)
      {
        return ListView.builder(
          itemCount: tempDocs.length,
          padding: EdgeInsets.all(10.0),
          itemBuilder: (context,i){
            return listofItems(context, i) ;
          },
        );
      }
    else
      {
        return Center(child: CircularProgressIndicator());
      }
  }

  notAvailable(context, i)
  {
    return Text("");
  }

  listofItems(context,i)
  {

      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
          //clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          child: Column(
            children: <Widget>[ new ListTile(
              title: Text(tempDocs[i]['device_name']),
              subtitle: Text(tempDocs[i]['device_dept']),
            ),
              tempDocs[i]['devtype'] == "Movable" ?
              Padding(
                padding: const EdgeInsets.only(left: 70.0),
                child: Row(
                  children: <Widget>[
                    FlatButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0),
                      ),
                      child: Text('Location', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      onPressed: () {
                        dialogTrigger(context, i);
                      },
                      color: Colors.blueAccent,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FlatButton(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                        ),
                        child: Text('Locate Device', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => connectorPage()));
                        },
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ) : FlatButton(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15.0),
                ),
                child: Text('Location', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                onPressed: () {
                  dialogTrigger(context, i);
                },
                color: Colors.blueAccent,
              ),
            ],
          ),
        ),
      );
    }

}//End of _display2State class

