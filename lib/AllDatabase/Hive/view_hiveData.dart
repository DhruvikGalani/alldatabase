import 'package:firebaseproject/AllDatabase/Hive/add_hivedata.dart';
import 'package:firebaseproject/AllDatabase/Hive/hiveclass.dart';
import 'package:firebaseproject/AllDatabase/Hive/varible_hive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../all_databaseButton.dart';

class view_hiveData extends StatefulWidget {
  const view_hiveData({super.key});

  @override
  State<view_hiveData> createState() => _view_hiveDataState();
}

class _view_hiveDataState extends State<view_hiveData> {
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
        title: Text("view HiveData"),
      ),
      body: ListView.builder(
        itemCount: BoxDetails.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          hiveclass hiveobj = BoxDetails.getAt(index);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return add_hiveData(
                      ind: index,
                      name: "${hiveobj.title}",
                      contact: "${hiveobj.discription}",
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
                        title: Text("Name : ${hiveobj.title}"),
                        subtitle: Text("contact : ${hiveobj.discription}"),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          BoxDetails.deleteAt(index);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(milliseconds: 500),
                              content: Text(
                                'Data deleted',
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
      ),
    );
  }
}
