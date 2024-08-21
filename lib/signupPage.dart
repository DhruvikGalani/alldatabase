import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseproject/logoutPage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class signupClass extends StatefulWidget {
  const signupClass({super.key});

  @override
  State<signupClass> createState() => _signupClassState();
}

class _signupClassState extends State<signupClass> {
  @override
  void initState() {
    // TODO: implement initState

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return logOutclass();
          },
        ));

        print('User is signed in!');
      }
    });
    super.initState();
  }

  String vid = "";
  TextEditingController mobile = TextEditingController();
  TextEditingController otp = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  signInWithGoogle()
                      .then(
                    (value) => print(value),
                  )
                      .then(
                    (value) {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return logOutclass();
                        },
                      ));
                    },
                  );
                },
                child: Text("Sign-up")),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: mobile,
            ),
            ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance
                      .verifyPhoneNumber(
                    phoneNumber: '+91${mobile.text}',
                    timeout: const Duration(seconds: 60),
                    verificationCompleted:
                        (PhoneAuthCredential credential) async {
                      await auth.signInWithCredential(credential);
                    },
                    verificationFailed: (FirebaseAuthException e) {
                      if (e.code == 'invalid-phone-number') {
                        print('The provided phone number is not valid.');
                      }
                    },
                    codeSent: (String verificationId, int? resendToken) async {
                      setState(() {
                        vid = verificationId;
                      });
                      // // Update the UI - wait for the user to enter the SMS code
                      // String smsCode = 'xxxx';
                      //
                      // // Create a PhoneAuthCredential with the code
                      // PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
                      //
                      // // Sign the user in (or link) with the credential
                      // await auth.signInWithCredential(credential);
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {
                      setState(() {
                        vid = verificationId;
                      });
                    },
                  )
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("otp send"),
                      ),
                    );
                  });
                },
                child: Text("Send Otp")),
            TextField(
              controller: otp,
            ),
            ElevatedButton(
                onPressed: () async {
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: vid, smsCode: otp.text);
                  await auth.signInWithCredential(credential).then((value) {
                    log("value=$value");
                  }).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("number verifeid"),
                      ),
                    );
                  });
                },
                child: Text("Verify Otp")),
          ],
        ),
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
