import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hatphi_test/presentation/components/responsiveness.dart';

import '../../config/app_assets.dart';

class CustomAppButton extends StatelessWidget {
  final String? title;
  final Color? color;
  final Color? innActiveColor;
  final VoidCallback? voidCallback;
  final bool? isActive;
  final bool? withEmoji;
  final double? radius;
  final double? width;
  final double? height;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? horizontalMargin;

  const CustomAppButton({
    super.key,
    this.title,
    this.color,
    this.innActiveColor,
    this.isActive,
    this.withEmoji,
    this.voidCallback,
    this.radius,
    this.textColor,
    this.width,
    this.fontWeight,
    this.height,
    this.fontSize,
    this.horizontalMargin,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive();
    return InkWell(
      onTap: isActive == true ? voidCallback : () {},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: horizontalMargin ?? 0),
        height: height ?? responsive.height(48, context),
        width: width ?? double.maxFinite,
        decoration: BoxDecoration(
          color: isActive == true
              ? color ?? AppColors.kBg
              : color ?? AppColors.kBg.withOpacity(0.2),
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
        ),
        child: Center(
            child: Text(
          title ?? '',
          style: GoogleFonts.plusJakartaSans(
              color: textColor ?? Colors.white,
              fontWeight: fontWeight ?? FontWeight.w500,
              fontSize: fontSize ?? 14),
        )),
      ),
    );
  }
}
