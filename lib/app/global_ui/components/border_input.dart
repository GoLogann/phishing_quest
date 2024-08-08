import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phishing_quest/app/global_ui/app_theme.dart';

class BorderInput extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final bool isDisabled;
  final List<TextInputFormatter> formatters;
  final AssetImage? icon;
  final TextInputType? type;
  final String? Function(String?)? validation;
  final String? Function(String?)? onChange;
  final double? paddingHorizontal;
  final int? maxSize;

  BorderInput({
    required this.hint,
    required this.controller,
    this.isDisabled = false,
    this.isPassword = false,
    this.type = TextInputType.text,
    this.icon,
    this.validation,
    this.onChange,
    this.paddingHorizontal,
    this.maxSize,
    this.formatters = const [],
  });

  @override
  State<BorderInput> createState() => _BorderInputState();
}

class _BorderInputState extends State<BorderInput> {
  bool isWithError = false;
  late bool isHidden;

  @override
  void initState() {
    super.initState();
    isHidden = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: .2.sh),
      padding: EdgeInsets.symmetric(horizontal: widget.paddingHorizontal ?? 16.w),
      child: TextFormField(
        readOnly: widget.isDisabled,
        keyboardType: widget.type ?? TextInputType.text,
        controller: widget.controller,
        obscureText: isHidden,
        cursorColor: AppTheme.colors.white,
        inputFormatters: widget.formatters,
        onChanged: widget.onChange,
        maxLength: widget.maxSize,
        validator: (value) {
          String? result = (value?.isEmpty ?? true) ? 'Campo obrigatório' : null;

          if (widget.validation != null) {
            result = widget.validation!(value);
          }

          setState(() => isWithError = result != null);
          return result;
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            left: 25.w,
            top: 18.h,
            bottom: 18.h,
          ),
          filled: true,
          fillColor: AppTheme.colors.white,
          suffixIcon: (!widget.isPassword)
              ? Padding(
                  padding: EdgeInsets.only(left: 8.w, right: 15.w),
                  child: ImageIcon(
                    widget.icon,
                    color: AppTheme.colors.primary,
                  ),
                )
              : buildSuffixIcon(),
          hintText: widget.hint,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(16.r), // NOTE: 40.w
          ),
          hintStyle: AppTheme.textStyles.posLabel.copyWith(
            color: AppTheme.colors.primaryLight,
          ),
        ),
        style: AppTheme.textStyles.posLabel.copyWith(
          color: AppTheme.colors.primaryDark,
        ),
      ),
    );
  }

  Widget? buildSuffixIcon() {
    final icon = isHidden ? Icons.visibility_off : Icons.visibility;
    return Padding(
      padding: EdgeInsets.only(left: 8.w, right: 15.w),
      child: InkWell(
        onTap: () => setState(() => isHidden = !isHidden),
        child: Icon(
          icon,
          size: 25.sp,
          color: AppTheme.colors.primary,
        ),
      ),
    );
  }
}
