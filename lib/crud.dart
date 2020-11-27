import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class crudMethods {

  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> addData(deviceData) async {
    if (isLoggedIn()) {
      CollectionReference collectionReference = FirebaseFirestore.instance
          .collection("DeviceData");
      collectionReference.add(deviceData).catchError((e) {
        print(e);
      });
    }
    else {
      print('You need to be logged in');
    }
  }

   fetchData()  async {
    return await FirebaseFirestore.instance.collection('DeviceData').getDocuments();
  }
  fetchData2()  async {
    return await FirebaseFirestore.instance.collection('DeviceData').getDocuments();
  }
}