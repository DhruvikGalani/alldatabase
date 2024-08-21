import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../all_databaseButton.dart';

class add_realtimeData extends StatefulWidget {
  String? name;
  String? contact;
  String? keys;
  add_realtimeData({this.name, this.contact, this.keys});

  @override
  State<add_realtimeData> createState() => _add_realtimeDataState();
}

class _add_realtimeDataState extends State<add_realtimeData> {
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
        title: Text("Realtime Data"),
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
              onPressed: () async {
                if (widget.keys != null) {
                  // realtime
                  DatabaseReference ref =
                      FirebaseDatabase.instance.ref("student/${widget.keys}");
                  await ref.set({
                    "name": t1.text,
                    "contact": t2.text,
                  }).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(milliseconds: 500),
                        content: Text(
                          '${(widget.keys == null) ? "Data added" : "Data updated"}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                    t1.text = "";
                    t2.text = "";
                  });
                } else {
                  // realtime
                  DatabaseReference ref =
                      FirebaseDatabase.instance.ref("student").push();
                  await ref.set({
                    "name": t1.text,
                    "contact": t2.text,
                  }).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(milliseconds: 500),
                        content: Text(
                          '${(widget.keys == null) ? "Data added" : "Data updated"}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                    t1.text = "";
                    t2.text = "";
                  });
                }
                widget.keys = null;
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
