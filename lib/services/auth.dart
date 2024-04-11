import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maavils_app/login/phone.dart';
import 'package:maavils_app/models/user.dart'; // Assuming UserObj is defined in this file

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to map Firebase User to custom User object
  UserObj? _userFromFirebaseUser(User? user) {
    return user != null ? UserObj(uid: user.uid) : null;
  }

  // Stream to listen for changes in the authentication state
  // Returns UserObj or null based on the authentication state
  Stream<UserObj?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // Function to sign in using phone number
  Future signInPhone(
    TextEditingController countryCodeController,
    TextEditingController phoneNumberController,
  ) async {
    try {
      // Start phone number verification
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: countryCodeController.text + phoneNumberController.text,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          print(e.code); // Print verification failed error code
          // Show error message to user
          Fluttertoast.showToast(
            msg: "Verification failed. Please try again.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          // Store verification ID for later use
          MyPhone.verificationId = verificationId;
          // Show OTP sent message to user
          Fluttertoast.showToast(
            msg: "OTP Sent!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print(e.toString()); // Print error message
      // Show error message to user
      Fluttertoast.showToast(
        msg: "An error occurred. Please try again.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  // Function for OTP verification
  Future<UserObj?> verifyOTP(String verificationId, String otp) async {
    try {
      // Create PhoneAuthCredential with verification ID and OTP
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      // Sign in with the credential
      UserCredential result = await _auth.signInWithCredential(credential);
      User user = result.user!;
      print(user.uid);

      // Show OTP verified message to user
      Fluttertoast.showToast(
        msg: "OTP verified successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );

      // Return the custom User object
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString()); // Print error message
      // Show wrong OTP message to user
      Fluttertoast.showToast(
        msg: "Wrong OTP! Please try again.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
    return null;
  }

  //sign out from app
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      // You can add any additional logic here after signing out
    } catch (e) {
      print(e.toString()); // Print error message
      // Show error message to user
      Fluttertoast.showToast(
        msg: "An error occurred while signing out. Please try again.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }
}
