import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  Future createAccount({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseAuth.instance.currentUser?.updateDisplayName(name);

      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        throw AuthException(code: "invalid-user");
      }

      // Salva o usuário no Firestore
      // cria um collection "users" e cria um documento com o ID do usuário, armazenando o id, email e nome
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser.uid)
          .set({"id": currentUser.uid, "email": email, "name": name});
    } on FirebaseAuthException catch (e) {
      log(e.message ?? 'Erro desconhecido');

      // lança exceção personalizada
      throw AuthException(code: e.code);
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(code: e.code);
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();

      // verifica se o logout foi realizado com sucesso, o log deve retornar null
      final currentUser = FirebaseAuth.instance.currentUser;
      log("User info: ${currentUser?.email}");
    } on AuthException catch (e) {
      throw AuthException(code: e.code);
    }
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on AuthException catch (e) {
      throw AuthException(code: e.code);
    }
  }
    User? getCurrentUser() {
      return FirebaseAuth.instance.currentUser;
    }
}

class AuthException implements Exception {
  final String code;
  AuthException({required this.code});
  String getMessage() {
    switch (code) {
      case "email-already-in-use":
        return "E-mail já foi cadastrado.";
      case "weak-password":
        return "Senha fraca, A senha deve conter no mínimo 6 caracteres.";
      case "invalid-email":
        return "E-mail inválido.";
      case "invalid-user":
        return "Usuário inválido";
      case "wrong-password":
        return "Senha incorreta.";
      case "user-not-found":
        return "Usuário não encontrado.";
      case "auth/invalid-email":
        return "E-mail inválido.";
      case "auth/user-not-found":
        return "Usuário não encontrado.";
      case "auth/missing-email":
        return "Insira um e-mail.";
      case "invalid-credential":
        return "E-mail ou senha inválido.";
      default:
        return "Erro desconhecido $code";
    }
  }
}
