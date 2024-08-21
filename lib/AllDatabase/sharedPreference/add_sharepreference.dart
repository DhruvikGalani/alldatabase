import 'package:firebaseproject/AllDatabase/sharedPreference/variable_sharepreference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../all_databaseButton.dart';

class add_sharepreference extends StatefulWidget {
  int? index;
  add_sharepreference({this.index});

  @override
  State<add_sharepreference> createState() => _add_sharepreferenceState();
}

class _add_sharepreferenceState extends State<add_sharepreference> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("inedx  :  ${widget.index}");
    if (widget.index != null) {
      t1.text = nameList[widget.index ?? 0];
      t2.text = contactList[widget.index ?? 0];
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
        title: Text("SharePreference"),
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
                  nameList = pref!.getStringList("name") ?? [];
                  contactList = pref!.getStringList("contact") ?? [];
                  if (widget.index == null) {
                    nameList.add(t1.text);
                    contactList.add(t2.text);
                  } else {
                    nameList[widget.index ?? 0] = t1.text;
                    contactList[widget.index ?? 0] = t2.text;
                  }
                  await pref!.setStringList("name", nameList);
                  await pref!.setStringList("contact", contactList).then(
                    (value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(milliseconds: 500),
                          content: Text(
                            '${(widget.index == null) ? "Data added" : "Data updated"}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  );
                  t1.text = "";
                  t2.text = "";
                  widget.index = null;
                  setState(() {});
                },
                child: Text("${(widget.index == null) ? "add" : "update"}")),
          ],
        ),
      )),
    );
  }
}
