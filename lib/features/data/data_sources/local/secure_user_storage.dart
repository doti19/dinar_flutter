import 'dart:convert';

import 'package:dinar/features/data/models/credit/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class UserStorage {
  Future<void> saveUser(UserModel user);
  Future<UserModel?> readUser();
  Future<void> deleteUser();
}

class SecureUserStorage implements UserStorage {
  SecureUserStorage(this._storage);
  final FlutterSecureStorage _storage;
  @override
  Future<UserModel?> readUser() async {
    // await _storage.deleteAll();
    final userData = await _storage.read(key: 'user');
    if (userData != null) {
      final Map<String, dynamic> userMap = json.decode(userData);
      print('read user ${userData}');
      return UserModel.fromJson(
        userMap,
      ); // Assuming LocalUser has a fromJson constructor
    }
    return null;
  }

  @override
  Future<void> saveUser(UserModel user) async {
    final userData = user.toJson();
    final String userDataString = json.encode(userData);
    // Assuming LocalUser has a toJson method
    await _storage.write(key: 'user', value: userDataString);
    print('saved ');
  }

  @override
  Future<void> deleteUser() async {
    await _storage.delete(key: 'user');
  }
}
