import 'package:noty_mobile/data/firebase_api_provider.dart';
import 'package:noty_mobile/domain/models/custom_user.dart';

class AuthRepository {
  final FirebaseApiProvider _firebaseApiProvider;

  AuthRepository({
    required FirebaseApiProvider firebaseApiProvider,
  }) : _firebaseApiProvider = firebaseApiProvider;

  bool isUserLoggedIn() {
    return _firebaseApiProvider.isUserLoggedIn();
  }

  Future<void> createUser({
    required String email,
    required String password,
    required String name,
    required String surName,
  }) async {
    await _firebaseApiProvider.createUser(
      email: email,
      password: password,
      name: name,
      surName: surName,
    );
  }

  Future<void> logOut() async {
    await _firebaseApiProvider.logOut();
  }

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    await _firebaseApiProvider.logIn(
      email: email,
      password: password,
    );
  }

  Future<bool> signInWithGoogle() async {
    return await _firebaseApiProvider.signInWithGoogle();
  }

  Future<void> updateToken() async {
    await _firebaseApiProvider.updateToken();
  }

  Future<void> resetPassword({required String email}) async {
    await _firebaseApiProvider.resetPassword(email: email);
  }

  Future<CustomUser?> getUserAttributes() async {
    return await _firebaseApiProvider.getUserAttributes();
  }

  Future<void> updateUser({
    required String name,
    required String sName,
    required String plate,
  }) async {
    return await _firebaseApiProvider.updateUser(
      name: name,
      sName: sName,
      plate: plate,
    );
  }

  Future<void> deleteUser() async {
    return await _firebaseApiProvider.deleteCurrentUser();
  }

  Future<String?> updatePlate({required String plate}) async {
    return await _firebaseApiProvider.updatePlate(plate: plate);
  }

  Future<void> updateVerification() async {
    await _firebaseApiProvider.updateIsVerified();
  }
}
