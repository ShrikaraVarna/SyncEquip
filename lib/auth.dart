import 'package:SyncEquip/mainpageAdmin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'mainpageUser.dart';
import 'mainpageAdmin.dart';
import 'src/welcomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:SyncEquip/src/loginPage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return  MultiProvider(
      providers: [
        Provider<Authenticate> (
          create: (_) =>Authenticate(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<Authenticate>().authStateChanges,
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme:GoogleFonts.latoTextTheme(textTheme).copyWith(
            bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: autenticatewrap(),
      ),
    );
  }
}

class Authenticate{
  Authenticate(this._firebaseAuth);
  final FirebaseAuth _firebaseAuth;
  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();
  Future <void> logout() async
  {
    await _firebaseAuth.signOut();
  }
  Future <String> login({String email, String password}) async
  {
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "signed in";
    } on FirebaseAuthException catch(e)
    {
      return e.message;
    }
  }
} //end of _LoginPageState class

class autenticatewrap extends StatelessWidget {
  const autenticatewrap({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseuser = context.watch<User>();
    if(firebaseuser != null){
    if (firebaseuser.email == 'gowrishvicky@gmail.com' || firebaseuser.email== "shrikara@gmail.com") {
      return MainPageAdmin();
    }
    else
      return  MainPageUser();}
    else{
      return WelcomePage();}
  }
}
