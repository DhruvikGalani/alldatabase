import 'package:firebaseproject/AllDatabase/SQL/sql_variable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../all_databaseButton.dart';

class add_sqldata extends StatefulWidget {
  int? id;
  int? index;
  String? name;
  String? contact;
  add_sqldata({this.id, this.name, this.contact, this.index});

  @override
  State<add_sqldata> createState() => _add_sqldataState();
}

class _add_sqldataState extends State<add_sqldata> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.id != null) {
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
              databaseHelper.createDatabase().then((value) async {
                await value.transaction((txn) async {
                  records = await txn.rawQuery('select * from userdetails');
                });
                // print("details : ${records}");
                setState(() {});
              });
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
        title: Text("SQL Data"),
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
                  if (widget.id != null) {
                    print('"1"');
                    print("${widget.id}");
                    databaseHelper.createDatabase().then((value) async {
                      await value.transaction((txn) async {
                        int dbindex = await txn.rawUpdate(
                            'update userdetails set name ="${t1.text}",contact ="${t2.text}"'
                            'where id = "${records[widget.index!]["id"]}"');
                        // print("idindex : $dbindex");
                        setState(() {});
                      });
                    }).then((value) {
                      print("2");
                      databaseHelper.createDatabase().then((value) async {
                        await value.transaction((txn) async {
                          records =
                              await txn.rawQuery('select * from userdetails');
                        });
                        // print("details : ${records}");
                        setState(() {});
                      });
                      t1.text = "";
                      t2.text = "";
                    });
                  } else {
                    databaseHelper.createDatabase().then((value) async {
                      await value.transaction((txn) async {
                        int dbindex = await txn.rawInsert(
                            'INSERT INTO userdetails(name,contact) VALUES("${t1.text}","${t2.text}")');
                        print("idindex : $dbindex");
                        setState(() {});
                      });
                    }).then((value) {
                      databaseHelper.createDatabase().then((value) async {
                        await value.transaction((txn) async {
                          records =
                              await txn.rawQuery('select * from userdetails');
                        });
                        print("details : ${records}");
                        setState(() {});
                      });
                      t1.text = "";
                      t2.text = "";
                    });
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(milliseconds: 500),
                      content: Text(
                        "${(widget.id == null) ? "Data added" : "Data Updated"}",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                  widget.id = null;
                },
                child: Text(
                  "${(widget.id == null) ? "Add" : "Update"}",
                )),
          ],
        ),
      )),
    );
  }
}
