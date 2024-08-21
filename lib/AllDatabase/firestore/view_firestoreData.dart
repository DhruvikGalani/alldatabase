import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseproject/AllDatabase/firestore/add_firestoreData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../all_databaseButton.dart';

class view_firestoredata extends StatefulWidget {
  const view_firestoredata({super.key});

  @override
  State<view_firestoredata> createState() => _view_firestoredataState();
}

class _view_firestoredataState extends State<view_firestoredata> {
  final Stream<QuerySnapshot> detailsStream =
      FirebaseFirestore.instance.collection('student').snapshots();

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
        title: Text("view firestoreData"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: detailsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return InkWell(
                onTap: () {
                  print("key = ${document.id}");
                  print("name = ${data['name']}");
                  print("contact = ${data['contact']}");

                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return add_firestoreData(
                        name: "${data['name']}",
                        contact: "${data['contact']}",
                        keys: '${document.id}',
                      );
                    },
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey.shade300,
                    ),
                    child: Row(
                      children: [
                        Flexible(
                          child: ListTile(
                            style: ListTileStyle.drawer,
                            title: Text("name : ${data['name']}"),
                            subtitle: Text("contact : ${data['contact']}"),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            print(document.id);
                            CollectionReference users = FirebaseFirestore
                                .instance
                                .collection('student');
                            return users
                                .doc(document.id)
                                .delete()
                                .then((value) => print("User Deleted"))
                                .catchError((error) =>
                                    print("Failed to delete user: $error"))
                                .then((value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: Duration(milliseconds: 500),
                                  content: Text(
                                    'data deleted',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
