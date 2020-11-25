import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'addNewpage.dart';

class crudMethods{

  bool isLoggedIn()
  {
    if(FirebaseAuth.instance.currentUser!= null){
      return true;
    }else{
      return false;
    }
  }

  Future<void> addData(deviceData) async{
    //if(isLoggedIn())

      CollectionReference collectionReference= Firestore.instance.collection("DeviceData");
      collectionReference.add(deviceData).catchError((e) {
        print(e);
      });

      //  else{
         // print('You need to be logged in');
    //}
      }
  }
