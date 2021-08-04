import 'package:flutter/material.dart';
import 'screens/edit_roster_rules_page.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> firebaseApp = Firebase.initializeApp();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: FutureBuilder(
        future: firebaseApp,
        builder: (context, snapshot) {
            if(snapshot.hasError){
              print("you have an error ${snapshot.error.toString()}");
              return Text("Some thing went wrong");
            }else if(snapshot.hasData){
              return RosterRulesPage();
            }else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
        },

    )


      //home: RosterRulesPage(),
    );
  }
}
