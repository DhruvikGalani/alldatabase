import 'package:firebase_database/firebase_database.dart';
import 'package:firebaseproject/realtime_database/view_realtime_data.dart';
import 'package:flutter/material.dart';

class realtimedataAdd extends StatefulWidget {
  String? name;
  String? contact;
  String? mykey;
  realtimedataAdd({this.name, this.contact, this.mykey});

  @override
  State<realtimedataAdd> createState() => _realtimedataAddState();
}

class _realtimedataAddState extends State<realtimedataAdd> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.mykey != null) {
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
      appBar: AppBar(title: Text("realtime data add")),
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
          onPressed: () async {
            if (widget.mykey != null) {
              // realtime
              DatabaseReference ref =
                  FirebaseDatabase.instance.ref("student/${widget.mykey}");
              await ref.set({
                "name": t1.text,
                "contact": t2.text,
              });
            } else {
              // realtime
              DatabaseReference ref =
                  FirebaseDatabase.instance.ref("student").push();
              await ref.set({
                "name": t1.text,
                "contact": t2.text,
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
                return view_RealtimeData();
              },
            ));
          },
          child: Text("view data"),
        ),
      ]),
    );
  }
}
