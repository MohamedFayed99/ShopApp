import 'package:firebase_auth/firebase_auth.dart';

class Auth{
  final auth = FirebaseAuth.instance;

  Future<UserCredential> signUp(String email,String password) async {
    final user = await auth.createUserWithEmailAndPassword(email: email, password: password);
    return user;
  }

  Future<UserCredential> login(String email,String password) async {
    final user = await auth.signInWithEmailAndPassword(email: email, password: password);
    return user;
  }
}