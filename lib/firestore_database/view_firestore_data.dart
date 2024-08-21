import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseproject/firestore_database/firestoreDatabase_Add.dart';
import 'package:flutter/material.dart';

class view_firestore_data extends StatefulWidget {
  const view_firestore_data({super.key});

  @override
  State<view_firestore_data> createState() => _view_firestore_dataState();
}

class _view_firestore_dataState extends State<view_firestore_data> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('student').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
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
                      return firestoreDataAdd(
                        name: "${data['name']}",
                        contact: "${data['contact']}",
                        mykey: '${document.id}',
                      );
                    },
                  ));
                },
                child: ListTile(
                  title: Text(data['name']),
                  subtitle: Text(data['contact']),
                  trailing: IconButton(
                    onPressed: () async {
                      print(document.id);
                      CollectionReference users =
                          FirebaseFirestore.instance.collection('student');
                      return users
                          .doc(document.id)
                          .delete()
                          .then((value) => print("User Deleted"))
                          .catchError((error) =>
                              print("Failed to delete user: $error"));
                    },
                    icon: Icon(Icons.delete),
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
