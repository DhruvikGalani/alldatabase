import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseproject/firestore_database/view_firestore_data.dart';
import 'package:flutter/material.dart';

class firestoreDataAdd extends StatefulWidget {
  String? name;
  String? contact;
  String? mykey;
  firestoreDataAdd({this.name, this.contact, this.mykey});

  @override
  State<firestoreDataAdd> createState() => _firestoreDataAddState();
}

class _firestoreDataAddState extends State<firestoreDataAdd> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.mykey != "") {
      t1.text = widget.name ?? "";
      t2.text = widget.contact ?? "";
    } else {
      t1.text = "";
      t2.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("firestore data add")),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextField(
          controller: t1,
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: t2,
        ),
        SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () {
            if (widget.mykey != null) {
              CollectionReference users =
                  FirebaseFirestore.instance.collection('student');

              users
                  .doc('${widget.mykey}')
                  .update({
                    "name": t1.text,
                    "contact": t2.text,
                  })
                  .then((value) => print("User Updated"))
                  .catchError(
                      (error) => print("Failed to update user: $error"));
            } else {
              CollectionReference users =
                  FirebaseFirestore.instance.collection('student');
              users
                  .add({
                    "name": t1.text,
                    "contact": t2.text,
                  })
                  .then((value) => print("User Added"))
                  .catchError((error) => print("Failed to add user: $error"))
                  .then((value) {
                    setState(() {
                      ScaffoldMessenger(
                        child: SnackBar(
                            content: Center(
                          child: Text("data added"),
                        )),
                      );
                    });
                  });
            }
          },
          child: Text("${(widget.mykey != null) ? "update" : "add"}"),
        ),
        SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return view_firestore_data();
              },
            ));
          },
          child: Text("view data"),
        ),
      ]),
    );
  }
}
