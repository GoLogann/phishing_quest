part of 'index.dart';

mixin EnvironmentHelper {
  bool isRunningDebug() => kDebugMode;

  bool isLocalMode() => MemoryStore(StorageKeys.IS_LOCAL_ENVIRONMENT).read<bool>() ?? false;

  Future<void> setLocalMode(isLocal) async => await MemoryStore(StorageKeys.IS_LOCAL_ENVIRONMENT).write(isLocal);
}
