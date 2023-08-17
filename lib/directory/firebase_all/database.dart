import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseDB {
  static final firebaseAuth = FirebaseAuth.instance;
  static final firebaseFireStrore = FirebaseFirestore.instance;
  static final firebasestorage = FirebaseStorage.instance;
  static final googleSignIn = GoogleSignIn();

  static Future<void> emailAndPassword(
      {required String email, required String password}) async {
    UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    firebaseFireStrore.collection("user").doc(userCredential.user?.uid).set({
      "email": email,
      "password": password,
      "uid": userCredential.user?.uid
    });
  }

  static Future<void> emailAndPasswordCheck(
      {required String email, required String password}) async {
    UserCredential userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    print(userCredential);
  }

  static Future<void> googleLogIn() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential credential1 =
        await firebaseAuth.signInWithCredential(credential);
    firebaseFireStrore.collection("user").doc(credential1.user?.uid).set({
      "email": credential1.user?.email,
      "uid": credential1.user?.uid,
      "isLogin": "GoogleLogIn",
    });
    log(credential1.additionalUserInfo!.isNewUser.toString());
  }

  static Future<void> anonymousAuth() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      print("Signed in with temporary account.");
      log(userCredential.user!.uid);
      log(userCredential.toString());
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }

  static Future<void> phoneNumerAuth(String phone) async {
    final PhoneCodeAutoRetrievalTimeout autoRetrived = (verificationId) {
      log(verificationId);
      id = verificationId;
    };

    final PhoneCodeSent smsCodeSent = (verificationId, forceResendingToken) {
      ///open dialoag or redirect new screen for otp enter
      id = verificationId;
    };

    final PhoneVerificationCompleted verificationCompleted =
        (phoneAuthCredential) {};

    final PhoneVerificationFailed failed = (error) {
      log(error.message.toString());
    };

    await firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+91$phone",
        verificationCompleted: verificationCompleted,
        verificationFailed: failed,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: autoRetrived);

    //for sign in after code enter
  }

  static String id = "";
  static Future<void> verifiedOTP(String otp) async {
    await firebaseAuth.signInWithCredential(
        PhoneAuthProvider.credential(verificationId: id, smsCode: otp));
  }
}

///for file upload
// var request = http.MultipartRequest('POST', Uri.parse('\${ApiConstants.BASE_URL}/common/uploadS3'));
// request.headers.addAll(headers());
// request.files.add(await http.MultipartFile.fromPath('file', path));//for each loop for multi image
// http.StreamedResponse response = await request.send();
// String result = await response.stream.bytesToString();
// return result;
