import 'package:firebaseproject/AllDatabase/Hive/hiveclass.dart';
import 'package:firebaseproject/AllDatabase/Hive/varible_hive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../all_databaseButton.dart';

class add_hiveData extends StatefulWidget {
  int? ind;
  String? name;
  String? contact;
  add_hiveData({this.ind, this.name, this.contact});

  @override
  State<add_hiveData> createState() => _add_hiveDataState();
}

class _add_hiveDataState extends State<add_hiveData> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    i = pr!.getInt("ind") ?? 0;
    print("object i : ${widget.ind}");
    if (widget.ind != null) {
      t1.text = widget.name!;
      t2.text = widget.contact!;
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
        title: Text("Hive Data"),
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
                  if (widget.ind != null) {
                    print("i : $i");
                    BoxDetails.putAt(int.parse("${widget.ind}"),
                        hiveclass("${t1.text}", "${t2.text}"));
                  } else {
                    i = pr!.getInt("ind") ?? 0;
                    i++;
                    print("i= $i");
                    await pr!.setInt("ind", i);
                    BoxDetails.put("$i", hiveclass("${t1.text}", "${t2.text}"));
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(milliseconds: 500),
                      content: Text(
                        '${(widget.ind != null) ? "Data Updated" : "Data Added"}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                  t1.text = "";
                  t2.text = "";
                  widget.ind = null;

                  setState(() {});
                },
                child: Text("${(widget.ind == null) ? "add" : "update"}")),
          ],
        ),
      )),
    );
  }
}
