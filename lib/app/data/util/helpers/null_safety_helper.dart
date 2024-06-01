part of 'index.dart';

mixin NullSafetyHelper {
  T? nullOr<T>(dynamic validator, Function action) {
    if (validator == null) {
      return null;
    }

    return action() as T;
  }

  dynamic firstOrNull(List? item, bool Function(dynamic) validation) {
    if ((item ?? []).isEmpty) {
      return null;
    }

    return item!.firstWhere(validation, orElse: () => null);
  }
}
