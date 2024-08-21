import 'package:firebaseproject/firestore_database/firestoreDatabase_Add.dart';
import 'package:firebaseproject/realtime_database/realtimeDatabase_Add.dart';
import 'package:flutter/material.dart';

class dataBase_choose extends StatefulWidget {
  const dataBase_choose({super.key});

  @override
  State<dataBase_choose> createState() => _dataBase_chooseState();
}

class _dataBase_chooseState extends State<dataBase_choose> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Choose database")),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return realtimedataAdd();
                },
              ));
            },
            child: Text("realTime database"),
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return firestoreDataAdd();
                },
              ));
            },
            child: Text("firestore database"),
          ),
        ]),
      ),
    );
  }
}
