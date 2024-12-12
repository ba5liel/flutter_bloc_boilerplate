import 'package:flutter_bloc_boilerplate/core/service/app_service.dart';
import 'package:hive_flutter/adapters.dart';

class AppStorageService extends AppService {
  late Box _box;

  Box get box => _box;

  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox('selam.et');
  }

  void write(String key, dynamic value) {
    _box.put(key, value);
  }

  T read<T>(String key, [T? defaultValue]) {
    return _box.get(key, defaultValue: defaultValue) as T;
  }

  Future<void> delete(String key) async {
    await _box.delete(key);
  }

  Map<String, dynamic>? readMap(String key,
      [Map<String, dynamic>? defaultValue]) {
    Map? map = _box.get(key, defaultValue: defaultValue);
    if (map != null) return Map<String, dynamic>.from(map);
    return null;
  }

  Future<void> clear() async {
    await _box.clear();
  }
}
