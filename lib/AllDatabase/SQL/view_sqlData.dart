import 'package:firebaseproject/AllDatabase/SQL/add_sqldata.dart';
import 'package:firebaseproject/AllDatabase/SQL/sql_variable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../all_databaseButton.dart';

class view_sqlData extends StatefulWidget {
  const view_sqlData({super.key});

  @override
  State<view_sqlData> createState() => _view_sqlDataState();
}

class _view_sqlDataState extends State<view_sqlData> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
    print("record : $records");
  }

  void init() {
    databaseHelper.createDatabase().then((value) async {
      await value.transaction((txn) async {
        records = await txn.rawQuery('select * from userdetails');
        setState(() {});
      });
    });
    setState(() {});
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
          title: Text("view_sqlData"),
        ),
        body: ListView.builder(
          itemCount: records.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return add_sqldata(
                        id: records[index]['id'],
                        name: records[index]['name'],
                        contact: records[index]['contact'],
                        index: index,
                      );
                    },
                  ));
                },
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
                          title: Text("Name : ${records[index]['name']}"),
                          subtitle:
                              Text("contact : ${records[index]['contact']}"),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            databaseHelper.createDatabase().then((value) async {
                              await value.transaction((txn) async {
                                await txn.rawDelete(
                                    'delete from userdetails where id= "${records[index]['id']}" ');
                                print("i : $index");

                                setState(() {});
                              });
                            });
                            databaseHelper.createDatabase().then((value) async {
                              await value.transaction((txn) async {
                                records = await txn
                                    .rawQuery('select * from userdetails');
                              });
                              // print("details : ${records}");
                              setState(() {});
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: Duration(milliseconds: 500),
                                content: Text(
                                  "Data deleted",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                            setState(() {});
                          },
                          icon: Icon(Icons.delete))
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
