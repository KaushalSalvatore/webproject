
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:webproject/services/database.dart';
import 'package:webproject/views/home.dart';
class AuthService{
  Future<User> signInWithGoogle(BuildContext context) async
  {

    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = new GoogleSignIn();
    final GoogleSignInAccount _googleSignInAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await _googleSignInAccount.authentication;
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    final UserCredential result = await _firebaseAuth.signInWithCredential(credential);

    final User user = result.user;
    if(result == null){
      // String name = user.photoURL.toString();
    }
    else {
      Map<String ,String> userMap ={
        "userName": user.displayName,
        "email": user.email
      };
      DatabaseServices().uploadUserInfo(user.uid, userMap);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Home(
                userEmail: user.email,
                username: user.displayName,
              )
          )
      );
    }
    return user;

  }
}

