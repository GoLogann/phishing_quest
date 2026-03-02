import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static final colors = _AppColors();
  static final textStyles = _AppTextStyles();

  static final defaultTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: colors.primary,
    scaffoldBackgroundColor: colors.backgroundDark,
    fontFamily: GoogleFonts.poppins().fontFamily,
    cardColor: colors.backgroundCard,
    colorScheme: ColorScheme.dark(
      brightness: Brightness.dark,
      primary: colors.primary,
      onPrimary: colors.textPrimary,
      secondary: colors.accent,
      onSecondary: colors.textPrimary,
      error: colors.error,
      onError: colors.textPrimary,
      surface: colors.backgroundCard,
      onSurface: colors.textPrimary,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.poppins(
        color: colors.textPrimary,
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: colors.textPrimary),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: colors.backgroundCard,
      selectedItemColor: colors.primary,
      unselectedItemColor: colors.textSecondary,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colors.backgroundCard,
      hintStyle: TextStyle(color: colors.textSecondary),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: colors.surfaceBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: colors.surfaceBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: colors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: colors.error),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colors.primary,
        foregroundColor: colors.textPrimary,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        textStyle: GoogleFonts.poppins(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: colors.backgroundCard,
      surfaceTintColor: colors.backgroundCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: colors.backgroundCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.r),
      ),
    ),
  );
}

class _AppColors {
  // === Dark Ocean Palette ===
  final Color backgroundDark = const Color(0xFF0F172A);
  final Color backgroundCard = const Color(0xFF1E293B);
  final Color surfaceBorder = const Color(0xFF334155);

  // Primary & Accent
  final Color primary = const Color(0xFF3B82F6);
  final Color primaryLight = const Color(0xFF60A5FA);
  final Color primaryDark = const Color(0xFF1D4ED8);
  final Color accent = const Color(0xFFF97316);
  final Color accentLight = const Color(0xFFFBBF24);

  // Status colors
  final Color success = const Color(0xFF22C55E);
  final Color error = const Color(0xFFEF4444);
  final Color warning = const Color(0xFFFBBF24);
  final Color info = const Color(0xFF06B6D4);

  // Text
  final Color textPrimary = const Color(0xFFF8FAFC);
  final Color textSecondary = const Color(0xFF94A3B8);
  final Color textMuted = const Color(0xFF64748B);

  // Difficulty colors
  final Color difficultyEasy = const Color(0xFF22C55E);
  final Color difficultyMedium = const Color(0xFFF97316);
  final Color difficultyHard = const Color(0xFFEF4444);

  // Ranking
  final Color gold = const Color(0xFFFBBF24);
  final Color silver = const Color(0xFF94A3B8);
  final Color bronze = const Color(0xFFCD7F32);

  // Glow effects
  final Color primaryGlow = const Color(0x333B82F6);
  final Color accentGlow = const Color(0x33F97316);

  // Legacy compat
  Color get secondary => accent;
  Color get white => textPrimary;
  Color get black => backgroundDark;
  Color get primaryOpacity => const Color(0x143B82F6);
  Color get whiteDark => backgroundCard;
  Color get whiteLight => surfaceBorder;
  Color get primaryLightBorder => surfaceBorder;
  Color get grey => surfaceBorder;
  Color get sucess => success;
  Color get alert => warning;
  Color get backOpacity => const Color(0x42000000);
  Color get badgeTypeOfResource => const Color(0xFF9747FF);
  Color get badgePublicResource => const Color(0xFF256DFB);
  Color get badgePrivateResource => const Color(0xFFFF4747);
  Color get redYoutube => const Color(0xFFFF0000);
  Color get blackTiktok => const Color(0xFF0F0F0F);
  Color get goldenWebsite => const Color(0xFFFF7900);
  Color get blueLinkedin => const Color(0xFF0A66C2);
  Color get color1Instagram => const Color(0xFFFDB051);
  Color get color2Instagram => const Color(0xFFF33240);
  Color get color3Instagram => const Color(0xFFCB2684);
  Color get color4Instagram => const Color(0xFF2F216C);
  Color get errorOpacity => const Color(0x14EF4444);
}

class _AppTextStyles {
  static final TextStyle _default = TextStyle(
    color: AppTheme.colors.textPrimary,
    fontFamily: GoogleFonts.poppins().fontFamily,
  );

  /// 48sp
  final TextStyle superDisplay = _default.copyWith(fontSize: 48.sp, fontWeight: FontWeight.w800);
  /// 28sp
  final TextStyle display = _default.copyWith(fontSize: 28.sp, fontWeight: FontWeight.w700);
  /// 25sp
  final TextStyle posHeader = _default.copyWith(fontSize: 25.sp, fontWeight: FontWeight.w700);
  /// 24sp
  final TextStyle header = _default.copyWith(fontSize: 24.sp, fontWeight: FontWeight.w600);
  /// 20sp
  final TextStyle title = _default.copyWith(fontSize: 20.sp, fontWeight: FontWeight.w600);
  /// 18sp
  final TextStyle posSubTitle = _default.copyWith(fontSize: 18.sp, fontWeight: FontWeight.w500);
  /// 16sp
  final TextStyle subTitle = _default.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500);
  /// 14sp
  final TextStyle posLabel = _default.copyWith(fontSize: 14.sp);
  /// 13sp
  final TextStyle prePosLabel = _default.copyWith(fontSize: 13.sp);
  /// 12sp
  final TextStyle label = _default.copyWith(fontSize: 12.sp);
  /// 11sp
  final TextStyle preLabel = _default.copyWith(fontSize: 11.sp);
  /// 10sp
  final TextStyle prepreLabel = _default.copyWith(fontSize: 10.sp);
}
