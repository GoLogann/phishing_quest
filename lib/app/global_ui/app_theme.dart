import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  AppTheme._();

  static final colors = _AppColors();
  static final textStyles = _AppTextStyles();

  static final defaultTheme = ThemeData(
    useMaterial3: true,
    primaryColor: AppTheme.colors.primary,
    fontFamily: 'Poppins',
    cardColor: AppTheme.colors.white,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppTheme.colors.primary,
      onPrimary: AppTheme.colors.white,
      secondary: AppTheme.colors.secondary,
      onSecondary: AppTheme.colors.white,
      error: AppTheme.colors.error,
      onError: AppTheme.colors.white,
      background: AppTheme.colors.white,
      onBackground: AppTheme.colors.black,
      surface: AppTheme.colors.white,
      onSurface: AppTheme.colors.black,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppTheme.colors.white,
      surfaceTintColor: AppTheme.colors.white,
      shape: const RoundedRectangleBorder(),
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: AppTheme.colors.white,
      endShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          bottomLeft: Radius.circular(5),
        ),
      ),
    ),
  );
}

class _AppColors {
  final Color secondary = Color(0xFFE17900);
  final Color primary = Color(0xFF1A2F43);
  final Color primaryOpacity = Color(0x141A2F43);
  final Color primaryDark = Color(0xFF0A131C);
  final Color primaryLight = Color(0xFF33526F);
  final Color primaryLightBorder = Color(0x2933526F);
  final Color white = Color(0xFFFFFFFF);
  final Color whiteDark = Color(0xFFE8EAEB);
  final Color whiteLight = Color(0xFFEFF4F2);

  final Color sucess = Color(0xFF47CB19);
  final Color error = Color(0xFFE41A1A);
  final Color errorOpacity = Color(0x14E41A1A);
  final Color alert = Color(0xFFFFC107);

  final Color badgeTypeOfResource = Color(0xFF9747FF);
  final Color badgePublicResource = Color(0xFF256DFB);
  final Color badgePrivateResource = Color(0xFFFF4747);

  final Color black = Color(0xFF000000);
  final Color backOpacity = Color(0x42000000);

  final Color redYoutube = Color(0xFFFF0000);
  final Color blackTiktok = Color(0xFF0F0F0F);
  final Color goldenWebsite = Color(0xFFFF7900);
  final Color blueLinkedin = Color(0xFF0A66C2);

  final Color color1Instagram = Color(0xFFFDB051);
  final Color color2Instagram = Color(0xFFF33240);
  final Color color3Instagram = Color(0xFFCB2684);
  final Color color4Instagram = Color(0xFF2F216C);

  final Color grey = const Color(0xFFefeff5);
}

//TODO: REFATORAR O NOME DOS TEXTOS?

class _AppTextStyles {
  static final TextStyle _default = TextStyle(
    color: AppTheme.colors.black,
    fontFamily: 'Poppins',
  );

  /// Color: Black
  /// Size: 48
  final TextStyle superDisplay = _default.copyWith(fontSize: 48.sp);

  /// Color: Black
  /// Size: 28
  final TextStyle display = _default.copyWith(fontSize: 28.sp);

  /// Color: Black
  /// Size: 25
  final TextStyle posHeader = _default.copyWith(fontSize: 25.sp);

  /// Color: Black
  /// Size: 24
  final TextStyle header = _default.copyWith(fontSize: 24.sp);

  /// Color: Black
  /// Size: 20
  final TextStyle title = _default.copyWith(fontSize: 20.sp);

  /// Color: Black
  /// Size: 18
  final TextStyle posSubTitle = _default.copyWith(fontSize: 18.sp);

  /// Color: Black
  /// Size: 16
  final TextStyle subTitle = _default.copyWith(fontSize: 16.sp);

  /// Color: Black
  /// Size: 14
  final TextStyle posLabel = _default.copyWith(fontSize: 14);

  /// Color: Black
  /// Size: 13
  final TextStyle prePosLabel = _default.copyWith(fontSize: 13.sp);

  /// Color: Black
  /// Size: 12
  final TextStyle label = _default.copyWith(fontSize: 12.sp);

  /// Color: Black
  /// Size: 11
  final TextStyle preLabel = _default.copyWith(fontSize: 11.sp);

  /// Color: Black
  /// Size: 10
  final TextStyle prepreLabel = _default.copyWith(fontSize: 10.sp);
}
