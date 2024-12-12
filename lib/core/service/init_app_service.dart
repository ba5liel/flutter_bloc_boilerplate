import 'package:flutter_bloc_boilerplate/core/service/app_api_service.dart';
import 'package:flutter_bloc_boilerplate/core/service/app_auth_service.dart';
import 'package:flutter_bloc_boilerplate/core/service/app_setting_service.dart';
import 'package:flutter_bloc_boilerplate/core/service/app_storage_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initAppService() async {
  //App storage service

  var appStorageService = AppStorageService();
  await appStorageService.init();

  getIt.registerSingleton<AppStorageService>(appStorageService);

  //App setting service

  var appSettingService = AppSettingService();
  await appSettingService.init();

  getIt.registerSingleton<AppSettingService>(appSettingService);

  //App Auth service

  getIt.registerSingleton<AppAuthService>(AppAuthService());

  //App API service

  var appAPIService = AppApiService();
  getIt.registerSingleton<AppApiService>(appAPIService);
}
