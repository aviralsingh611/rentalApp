import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myapp/loggedin.dart';

class FirebaseAuthService {

  FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();
    print("asdf");
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        print("asdf");
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
          await auth.signInWithCredential(credential);

          user = userCredential.user;

          if (user != null) {
            // Register the user in Firestore
            final userDoc = firestore.collection('users').doc(user.uid);

            // Check if user document exists
            final docSnapshot = await userDoc.get();

            if (!docSnapshot.exists) {
              // Extract username from email
              String username = user.email!.split('@')[0];

              await userDoc.set({
                'email': user.email,
                'username': username,
              });
            }

            // Navigate to another page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            print("Exception: $e");
          } else if (e.code == 'invalid-credential') {
            print("Exception: $e");
          } else {
            print("Exception: $e");
          }
        } catch (e) {
          print("Exception: $e");
        }
      }
    } catch (e) {
      print("Exception: $e");
    }

    return user;
  }

  Future<UserCredential?> loginWithGoogle() async {
    try{
      final googleUser=await GoogleSignIn().signIn();
      final googleAuth=await googleUser?.authentication;
      final cred=GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken
      );
      return await _auth.signInWithCredential(cred);
    }
    catch(e){
      print(e.toString());
    }
  }
  Future<void> adduser(String email,String username,String password)async {
    CollectionReference users=FirebaseFirestore.instance.collection('users');
    users.add({
      'email': email,
      'username': username
    });
  }
  Future<User?> signUpWithEmailAndPassword(String email,String username, String password) async {
    try {
      UserCredential credential =await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await _firestore.collection('users').doc(credential.user!.uid).set({
        'email': email,
        'username': username,
      });
      //adduser(email,username,password);
      return credential.user;
    } on FirebaseAuthException catch (e) {

      if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: 'The email address is already in use.');
      } else {
        Fluttertoast.showToast(msg: 'An error occurred: ${e.code}');
      }
    }
    return null;

  }

  Future<User?> signInWithEmailAndPassword(String user, String password) async {

    try {
      String email = user;
      //CollectionReference users=FirebaseFirestore.instance.collection('users');
      if (!user.contains('@')) {
        //print("asl;jdf");
        //print("Fetching email for username: $user");
        final snapshot = await _firestore.collection("users").where("username", isEqualTo: user).get();
       // print("asdf");
        //print("Query completed");
        if (snapshot.docs.isEmpty) {
          Fluttertoast.showToast(msg: 'Invalid username.');
          return null;
        }
        final username=snapshot.docs[0];
        //print(username.toString());
        email = snapshot.docs.first['email'];
        //print("Email found: $email");
      }
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      //print("FirebaseAuthException: ${e.code}");
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Invalid email or password.');
      } else {
        Fluttertoast.showToast(msg: 'An error occurred: ${e.code}');
      }
    }
    catch(e){
      //print("Exception: $e");
    }
    return null;

  }
  Future<bool> sendPasswordResetEmail(String username) async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('users').where('username', isEqualTo: username).get();
      if (snapshot.docs.isEmpty) {
        return false;
      }
      String email = snapshot.docs.first['email'];
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }




}