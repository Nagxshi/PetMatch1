// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthService extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Rx<User?> _firebaseUser; // Permite User? (nulo)
  var userIsAuthenticated = false.obs;

  @override
  void onInit() {
    super.onInit();

    _firebaseUser = Rx<User?>(_auth.currentUser);
    _firebaseUser.bindStream(_auth.authStateChanges());

    ever(_firebaseUser, (User? user) {
      // Usa User? para lidar com valores nulos
      userIsAuthenticated.value = user != null;
    });
  }

  User? get user => _firebaseUser.value; // Permite User? (nulo)
  static AuthService get to => Get.find<AuthService>();

  void showSnack(String message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.grey[900],
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> createUser(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      showSnack(e.toString()); // Corrige a mensagem de erro
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      showSnack(e.toString()); // Corrige a mensagem de erro
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      showSnack(e.toString()); // Corrige a mensagem de erro
    }
  }
}
