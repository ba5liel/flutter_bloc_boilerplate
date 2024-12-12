import 'package:flutter_bloc_boilerplate/core/constants/storage_keys.dart';
import 'package:flutter_bloc_boilerplate/core/service/app_service.dart';
import 'package:flutter_bloc_boilerplate/core/service/app_storage_service.dart';
import 'package:flutter_bloc_boilerplate/core/service/init_app_service.dart';
import 'package:flutter_bloc_boilerplate/data/models/user.dart';

enum AuthStatus { authenticated, unauthenticated, blocked }

class AppAuthService extends AppService {
  final AppStorageService _storageService = getIt<AppStorageService>();

  AuthStatus authStatus = AuthStatus.unauthenticated;

  User? user;
  String? authtoken;

  AppAuthService() {
    var userMap = _storageService.readMap(StorageKeys.currentUserKey);
    if (userMap != null) user = User.fromMap(userMap);
    if (user != null) authStatus = AuthStatus.authenticated;
  }

  Future<void> logout() async {
    await _storageService.delete(StorageKeys.currentUserKey);
  }
}
