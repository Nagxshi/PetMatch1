// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthService extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Rx<User?> _firebaseUser; // Allows User? (nullable)
  var userIsAuthenticated = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Set up the stream listener for authentication state changes
    _firebaseUser = Rx<User?>(_auth.currentUser);
    _firebaseUser.bindStream(_auth.authStateChanges());

    // Update the authenticated state whenever the user changes
    ever(_firebaseUser, (User? user) {
      userIsAuthenticated.value = user != null;
    });
  }

  User? get user => _firebaseUser.value; // Allows User? (nullable)
  static AuthService get to => Get.find<AuthService>();

  // Display a Snackbar with an error message
  void showSnack(String message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.grey[900],
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Create a new user account with email and password
  Future<void> createUser(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific errors more precisely
      showSnack(getFirebaseAuthErrorMessage(e));
    } catch (e) {
      // Catch any other exceptions
      showSnack('An unexpected error occurred: ${e.toString()}');
    }
  }

  // Login user with email and password
  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific errors more precisely
      showSnack(getFirebaseAuthErrorMessage(e));
    } catch (e) {
      // Catch any other exceptions
      showSnack('An unexpected error occurred: ${e.toString()}');
    }
  }

  // Log out the current user
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      showSnack('Error logging out: ${e.toString()}');
    }
  }

  // Utility method to get user-friendly error messages
  String getFirebaseAuthErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'user-not-found':
        return 'No user found for this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'The email is already in use by another account.';
      case 'weak-password':
        return 'The password is too weak. Please choose a stronger password.';
      default:
        return 'An authentication error occurred: ${e.message}';
    }
  }
}
