import 'package:firebase_database/firebase_database.dart';
import 'package:firebaseproject/AllDatabase/realtime/add_realtimeData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../all_databaseButton.dart';

class view_realtimedata extends StatefulWidget {
  const view_realtimedata({super.key});

  @override
  State<view_realtimedata> createState() => _view_realtimedataState();
}

class _view_realtimedataState extends State<view_realtimedata> {
  DatabaseReference CountRef = FirebaseDatabase.instance.ref('student');

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
        title: Text("view_realtimedata"),
      ),
      body: StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.connectionState == ConnectionState.done ||
              snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              if (snapshot.data!.snapshot.value != null) {
                Map data = snapshot.data!.snapshot.value as Map;
                print("data value===${data.values}");
                print("data key===${data.keys}");

                return ListView(
                  children: data.values
                      .map((e) => InkWell(
                            onTap: () {
                              int pos = 0;
                              data.values
                                  .toList()
                                  .asMap()
                                  .forEach((index, element) {
                                if (e == element) {
                                  pos = index;
                                }
                              });
                              String mykey = data.keys.toList()[pos];
                              print(
                                  "name == ${data.values.toList()[pos]['name']}");
                              print(
                                  "contact == ${data.values.toList()[pos]['contact']}");
                              print("===${mykey}");
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return add_realtimeData(
                                    name:
                                        "${data.values.toList()[pos]['name']}",
                                    contact:
                                        "${data.values.toList()[pos]['contact']}",
                                    keys: "$mykey",
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
                                        title: Text("name : ${e['name']}"),
                                        subtitle:
                                            Text("contact : ${e['contact']}"),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () async {
                                        int pos = 0;
                                        data.values
                                            .toList()
                                            .asMap()
                                            .forEach((index, element) {
                                          if (e == element) {
                                            pos = index;
                                          }
                                        });
                                        String key = data.keys.toList()[pos];
                                        print("===${key}");
                                        await FirebaseDatabase.instance
                                            .ref('student/$key')
                                            .remove()
                                            .then((value) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              duration:
                                                  Duration(milliseconds: 500),
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
                          ))
                      .toList(),
                );
              } else {
                return Center(
                  child: Text(" No data"),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        stream: CountRef.onValue,
      ),
    );
  }
}
