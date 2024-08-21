import 'package:firebase_database/firebase_database.dart';
import 'package:firebaseproject/realtime_database/realtimeDatabase_Add.dart';
import 'package:flutter/material.dart';

class view_RealtimeData extends StatefulWidget {
  const view_RealtimeData({super.key});

  @override
  State<view_RealtimeData> createState() => _view_RealtimeDataState();
}

class _view_RealtimeDataState extends State<view_RealtimeData> {
  DatabaseReference starCountRef = FirebaseDatabase.instance.ref('student');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // starCountRef.onValue.listen((DatabaseEvent event) {
    //   final data = event.snapshot.value;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("view")),
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
                                  return realtimedataAdd(
                                    name:
                                        "${data.values.toList()[pos]['name']}",
                                    contact:
                                        "${data.values.toList()[pos]['contact']}",
                                    mykey: "$mykey",
                                  );
                                },
                              ));
                            },
                            child: ListTile(
                              title: Text("${e['name']}"),
                              subtitle: Text("${e['contact']}"),
                              trailing: IconButton(
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
                                      .remove();
                                },
                                icon: Icon(Icons.delete),
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
        stream: starCountRef.onValue,
      ),
    );
  }
}
