import 'package:firebaseproject/AllDatabase/sharedPreference/add_sharepreference.dart';
import 'package:firebaseproject/AllDatabase/sharedPreference/variable_sharepreference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../all_databaseButton.dart';

class view_sharepreference extends StatefulWidget {
  const view_sharepreference({super.key});

  @override
  State<view_sharepreference> createState() => _view_sharepreferenceState();
}

class _view_sharepreferenceState extends State<view_sharepreference> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  void init() {
    nameList = pref!.getStringList("name") ?? [];
    contactList = pref!.getStringList("contact") ?? [];
    print("l1 = $nameList");
    print("l2 = $contactList");
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
          title: Text("view_Sharepreference"),
        ),
        body: ListView.builder(
          itemCount: nameList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return add_sharepreference(
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
                          title: Text("Name : ${nameList[index]}"),
                          subtitle: Text("contact : ${contactList[index]}"),
                        ),
                      ),
                      IconButton(
                          onPressed: () async {
                            print(index);

                            nameList.removeAt(index);
                            contactList.removeAt(index);

                            await pref?.setStringList("name", nameList);
                            await pref
                                ?.setStringList("contact", contactList)
                                .then((value) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                duration: Duration(milliseconds: 500),
                                content: Text(
                                  'Data deleted',
                                  textAlign: TextAlign.center,
                                ),
                              ));
                            });
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
