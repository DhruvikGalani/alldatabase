import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../all_databaseButton.dart';

class add_firestoreData extends StatefulWidget {
  String? name;
  String? contact;
  String? keys;
  add_firestoreData({this.name, this.contact, this.keys});

  @override
  State<add_firestoreData> createState() => _add_firestoreDataState();
}

class _add_firestoreDataState extends State<add_firestoreData> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.keys != null) {
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
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => all_Button(),
                  ));
            },
            icon: Icon(
              CupertinoIcons.back,
              size: 20,
            )),
        title: Text("FireStore Data"),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: t1,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: t2,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                if (widget.keys != null) {
                  CollectionReference users =
                      FirebaseFirestore.instance.collection('student');

                  users
                      .doc('${widget.keys}')
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
                      .catchError(
                          (error) => print("Failed to add user: $error"));
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(milliseconds: 500),
                    content: Text(
                      '${(widget.keys != null) ? "data updated" : " data added"}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
                widget.keys = null;
                t1.text = "";
                t2.text = "";
                setState(() {});
              },
              child: Text("${(widget.keys != null) ? "update" : "add"}"),
            ),
          ],
        ),
      )),
    );
  }
}
