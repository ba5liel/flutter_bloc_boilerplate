import 'package:flutter_bloc_boilerplate/core/constants/storage_keys.dart';
import 'package:flutter_bloc_boilerplate/core/service/app_service.dart';
import 'package:flutter_bloc_boilerplate/core/service/app_storage_service.dart';
import 'package:flutter_bloc_boilerplate/core/service/init_app_service.dart';
import 'package:flutter_bloc_boilerplate/data/models/setting/app_config.dart';
import 'package:flutter_bloc_boilerplate/data/models/setting/app_setting.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppSettingService extends AppService {
  late AppSetting setting;
  late AppConfig config;

  AppStorageService appStorageService = getIt<AppStorageService>();

  AppSettingService() {
    Map<String, dynamic> data = appStorageService.readMap(
        StorageKeys.settingBoxKey, AppSetting().toMap())!;

    setting = AppSetting.fromMap(data);
  }

  Future<void> init() async {
    await dotenv.load(fileName: ".env");
    config = AppConfig.fromMap(dotenv.env);
  }

  void save() {
    appStorageService.write(StorageKeys.settingBoxKey, setting.toMap());
  }
}
