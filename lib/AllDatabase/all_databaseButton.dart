import 'package:firebaseproject/AllDatabase/Hive/add_hivedata.dart';
import 'package:firebaseproject/AllDatabase/Hive/view_hiveData.dart';
import 'package:firebaseproject/AllDatabase/SQL/add_sqldata.dart';
import 'package:firebaseproject/AllDatabase/SQL/view_sqlData.dart';
import 'package:firebaseproject/AllDatabase/firestore/add_firestoreData.dart';
import 'package:firebaseproject/AllDatabase/firestore/view_firestoreData.dart';
import 'package:firebaseproject/AllDatabase/realtime/add_realtimeData.dart';
import 'package:firebaseproject/AllDatabase/realtime/view_realtimeData.dart';
import 'package:firebaseproject/AllDatabase/sharedPreference/add_sharepreference.dart';
import 'package:firebaseproject/AllDatabase/sharedPreference/view_sharepreference.dart';
import 'package:flutter/material.dart';

class all_Button extends StatefulWidget {
  const all_Button({super.key});

  @override
  State<all_Button> createState() => _all_ButtonState();
}

class _all_ButtonState extends State<all_Button> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        width: 250,
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
              height: 80,
            ),
            Icon(
              color: Colors.grey,
              Icons.account_circle_sharp,
              size: 80,
            ),
            Text("mrdgalani003@gmail.com"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                color: Colors.grey,
                thickness: .5,
              ),
            ),
            Text(
              "View Database",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.w200),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(Size(150, 30))),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => view_sharepreference(),
                    ));
              },
              child: Text("shared preferences"),
            ),
            SizedBox(
              width: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => view_hiveData(),
                    ));
              },
              style: ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(Size(150, 30))),
              child: Text("Hive"),
            ),
            SizedBox(
              width: 10,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(Size(150, 30))),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => view_sqlData(),
                    ));
              },
              child: Text("SQl"),
            ),
            SizedBox(
              width: 10,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(Size(150, 30))),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => view_realtimedata(),
                    ));
              },
              child: Text("RealTime"),
            ),
            SizedBox(
              width: 10,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(Size(150, 30))),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => view_firestoredata()),
                );
              },
              child: Text("FireStore"),
            ),
          ]),
        ),
      ),
      appBar: AppBar(title: Text("All Databse")),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            style:
                ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(150, 30))),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => add_sharepreference(),
                  ));
            },
            child: Text("shared preferences"),
          ),
          SizedBox(
            width: 10,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => add_hiveData(),
                  ));
            },
            style:
                ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(150, 30))),
            child: Text("Hive"),
          ),
          SizedBox(
            width: 10,
          ),
          ElevatedButton(
            style:
                ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(150, 30))),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => add_sqldata(),
                  ));
            },
            child: Text("SQl"),
          ),
          SizedBox(
            width: 10,
          ),
          ElevatedButton(
            style:
                ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(150, 30))),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => add_realtimeData(),
                  ));
            },
            child: Text("RealTime"),
          ),
          SizedBox(
            width: 10,
          ),
          ElevatedButton(
            style:
                ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(150, 30))),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => add_firestoreData(),
                  ));
            },
            child: Text("FireStore"),
          ),
        ],
      )),
    );
  }
}
