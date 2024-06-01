import 'package:get_storage/get_storage.dart';

import '../enumerators/storage_keys.enum.dart';

/// `MemoryStore` is a class that provides methods to
/// interact with the GetStorage package for reading,
/// writing and removing data. It requires a storeKey
/// to interact with the correct box.
class MemoryStore {
  final StorageKeys _storeKey;
  late final GetStorage _box;

  /// Constructor for `MemoryStore`.
  /// It requires `storeKey` as parameter and it must be an entry
  /// of StorageKeys. `customBox` is an optional parameter that
  /// allows for passing in a custom GetStorage box.
  MemoryStore(this._storeKey, {GetStorage? customBox}) {
    _box = customBox ?? GetStorage();
  }

  /// Reads a value from the box. The type should be provided.
  T? read<T>() {
    return _box.read<T>(_storeKey.name);
  }

  /// Writes a `value` to the box.
  /// This method is asynchronous and returns a Future.
  Future<void> write(dynamic value) async {
    await _box.write(_storeKey.name, value);
  }

  /// Removes a value from the box.
  /// This method is asynchronous and returns a Future.
  Future<void> remove() async {
    await _box.remove(_storeKey.name);
  }
}
