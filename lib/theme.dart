import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hatphi_test/config/app_assets.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      textTheme:
          GoogleFonts.plusJakartaSansTextTheme(Theme.of(context).textTheme)
              .copyWith(
        titleLarge: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),

        /// Add more text styles as needed
      ),
      colorScheme: const ColorScheme.light(),
      primaryColor: AppColors.kBg,
      useMaterial3: true,

      /// floatingActionButtonTheme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          elevation: 3,
          shape: CircleBorder(),
          backgroundColor: AppColors.kBlue,
          iconSize: 62,
          sizeConstraints: BoxConstraints.tightFor(height: 62, width: 62)),

      /// tabBarTheme
      tabBarTheme: TabBarTheme(
        dividerHeight: 0,
        labelPadding: const EdgeInsets.symmetric(horizontal: 50),
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelStyle: GoogleFonts.plusJakartaSans(
          color: AppColors.primaryTextColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        labelStyle: GoogleFonts.plusJakartaSans(
          color: const Color(0xff004AAD),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        indicatorColor: const Color(0xff004AAD).withOpacity(0.15),
        indicator: ShapeDecoration(
          color: AppColors.kLightGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),

      ///Chip
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(color: Colors.transparent),
        ),
      ),
      expansionTileTheme: ExpansionTileThemeData(
        backgroundColor: Colors.white,
        childrenPadding: const EdgeInsets.all(10),
        shape: Border.all(
          color: Colors.transparent,
        ),
      ),
    );
  }
}
