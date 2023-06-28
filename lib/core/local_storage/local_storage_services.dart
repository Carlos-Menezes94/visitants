import 'package:hive_flutter/hive_flutter.dart';

import '../../app/features/home/data/models/visitor_model.dart';
import 'local_storage_data.dart';

class LocalStorageService {
  Future<void> initHive() async {
    await Hive.initFlutter();
  }

// ignore: non_constant_identifier_names
  LocalStorageService() {
    Hive.registerAdapter(VisitorModelAdapter());
    // Hive.registerAdapter(LoginDataAdapter());
    // Hive.registerAdapter(NotificationHelperAdapter());
    // Hive.registerAdapter(MonitoringInfoModelAdapter());
    // Hive.registerAdapter(EventModelAdapter());
    // Hive.registerAdapter(EventTypeAdapter());
    // Hive.registerAdapter(CustomTimerModelAdapter());
    initHive();
  }

  Future<void> putData(String key, HiveObject data) async {
    final box = await Hive.openBox(key);
    await box.put(key, data);
  }

  Future<LocalStorageData<T>> getData<T>(String key) async {
    final box = await Hive.openBox(key);

    return LocalStorageData<T>(data: box.get(key));
  }

  Future<dynamic> recoverData({
    required String directory,
    required String key,
  }) async {
    final box = await Hive.openBox(directory);
    return box.get(key);
  }

  Future<List<dynamic>> recoverDirectory({
    required String directory,
  }) async {
    final box = await Hive.openBox(directory);

    return box.values.toList();
  }

  Future<dynamic> insertData({
    required String directory,
    required String key,
    required dynamic data,
  }) async {
    final box = await Hive.openBox(directory);
    return box.put(key, data);
  }

  Future<void> deleteData({
    required String directory,
    required String key,
  }) async {
    final box = await Hive.openBox(directory);
    return box.delete(key);
  }

  Future<void> deleteDirectory({
    required String directory,
  }) async {
    final box = await Hive.openBox(directory);
    return box.deleteFromDisk();
  }
}
