import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseproject/signupPage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class logOutclass extends StatefulWidget {
  logOutclass();

  @override
  State<logOutclass> createState() => _logOutclassState();
}

class _logOutclassState extends State<logOutclass> {
  @override
  void initState() {
    // TODO: implement initState

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        myuser = user;
        setState(() {});
        print('User is signed in!');
        print('\n\n $myuser}');
      }
    });
    super.initState();
  }

  User? myuser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              child: Image.network("${myuser!.photoURL}"),
            ),
            Text("Email  : ${myuser!.email}"),
            Text("name  : ${myuser!.displayName}"),
            Text("phoneNumber  : ${myuser!.phoneNumber}"),
            Text("id length  : ${myuser!.providerData.length}"),
            Text("providerId  : ${myuser!.providerData[0].providerId}"),
            ElevatedButton(
                onPressed: () async {
                  await await GoogleSignIn().signOut();
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return signupClass();
                    },
                  ));
                },
                child: Text("log-out")),
          ],
        ),
      ),
    );
  }
}
