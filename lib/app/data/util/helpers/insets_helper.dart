part of 'index.dart';

mixin InsetsHelper {
  EdgeInsets paddingAll(double valor) {
    return EdgeInsets.symmetric(
      vertical: valor.h,
      horizontal: valor.w,
    );
  }
}
