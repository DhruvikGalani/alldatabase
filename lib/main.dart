import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseproject/AllDatabase/Hive/hiveclass.dart';
import 'package:firebaseproject/AllDatabase/Hive/varible_hive.dart';
import 'package:firebaseproject/AllDatabase/all_databaseButton.dart';
import 'package:firebaseproject/database_choose.dart';
import 'package:firebaseproject/firebase_options.dart';
import 'package:firebaseproject/signupPage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AllDatabase/sharedPreference/variable_sharepreference.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // all datbase

  // share preference
  pref = await SharedPreferences.getInstance();

  // hive
  pr = await SharedPreferences.getInstance();
  await Hive.initFlutter();
  Hive.registerAdapter(hiveclassAdapter());
  BoxDetails = await Hive.openBox("details");

  //----------

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    // home: signupClass(), // for singup bt google and mobile otp
    // home: dataBase_choose(), // for choose database ( realtime or firestore)
    home: all_Button(), // all database Button
  ));
}
