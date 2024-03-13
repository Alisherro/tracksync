import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tracksync/core/resources/palette.dart';

import 'dimens.dart';

ThemeData themeLight(BuildContext context) => ThemeData(
      fontFamily: "Poppins",
      useMaterial3: true,
      primaryColor: Palette.primary,
      disabledColor: Palette.shadowDark,
      hintColor: Palette.subText,
      cardColor: Palette.background,
      scaffoldBackgroundColor: Palette.background,
      colorScheme: const ColorScheme.light().copyWith(
        primary: Palette.primary,
        background: Palette.background,
      ),
      textTheme: TextTheme(
        displayLarge: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: Dimens.displayLarge,
              color: Palette.text,
            ),
        displayMedium: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontSize: Dimens.displayMedium,
              color: Palette.text,
            ),
        displaySmall: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontSize: Dimens.displaySmall,
              color: Palette.text,
            ),
        headlineMedium: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: Dimens.headlineMedium,
              color: Palette.text,
              fontWeight: FontWeight.w700,
              height: 36 / Dimens.headlineMedium,
            ),
        headlineSmall: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontSize: Dimens.headlineSmall,
            color: Palette.text,
            height: 30 / Dimens.headlineSmall,
            fontWeight: FontWeight.w600),
        titleLarge: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: Dimens.titleLarge,
              color: Palette.text,
              height: 26 / Dimens.titleLarge,
            ),
        titleMedium: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: Dimens.titleMedium,
              color: Palette.text,
              height: 26 / Dimens.titleMedium,
            ),
        titleSmall: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontSize: Dimens.titleSmall,
              color: Palette.text,
            ),
        bodyLarge: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: Dimens.bodyLarge,
              color: Palette.text,
              height: 24 / Dimens.bodyLarge,
            ),
        bodyMedium: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: Dimens.bodyMedium,
            color: Palette.text,
            height: 20 / Dimens.bodyMedium),
        bodySmall: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: Dimens.bodySmall,
              color: Palette.text,
              height: 18 / Dimens.bodySmall,
            ),
        labelLarge: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: Dimens.labelLarge,
              color: Palette.text,
            ),
        labelMedium: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontSize: Dimens.labelMedium,
              color: Palette.text,
            ),
        labelSmall: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: Dimens.labelSmall,
              letterSpacing: 0.25,
              color: Palette.text,
            ),
      ).apply(fontFamily: 'Poppins'),
      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        fillColor: Palette.greyColor,
        contentPadding: const EdgeInsets.all(17),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            width: 1,
            style: BorderStyle.solid,
            color: Palette.subText,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            width: 1,
            style: BorderStyle.solid,
            color: Palette.subText,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            width: 1,
            style: BorderStyle.solid,
            color: Palette.subText,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            width: 1,
            style: BorderStyle.solid,
            color: Palette.subText,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            width: 1,
            style: BorderStyle.solid,
            color: Palette.subText,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            width: 1,
            style: BorderStyle.solid,
            color: Palette.subText,
          ),
        ),
        hintStyle: TextStyle(
            fontSize: Dimens.bodySmall,
            fontWeight: FontWeight.w400,
            color: Palette.subText,
            height: 18 / Dimens.bodySmall),
      ),
      appBarTheme: const AppBarTheme().copyWith(
        titleTextStyle: Theme.of(context).textTheme.bodyLarge,
        color: Palette.background,
        iconTheme: const IconThemeData(color: Palette.pinkLatte),
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
        ),
        surfaceTintColor: Palette.background,
        shadowColor: Palette.shadow,
      ),
      drawerTheme: const DrawerThemeData().copyWith(
        elevation: Dimens.zero,
        surfaceTintColor: Palette.background,
        backgroundColor: Palette.background,
      ),
      snackBarTheme: const SnackBarThemeData(backgroundColor: Palette.cardDark),
      bottomSheetTheme: const BottomSheetThemeData().copyWith(
        backgroundColor: Palette.background,
        surfaceTintColor: Colors.transparent,
        elevation: Dimens.zero,
      ),
      dialogTheme: const DialogTheme().copyWith(
        backgroundColor: Palette.background,
        surfaceTintColor: Colors.transparent,
        elevation: Dimens.zero,
      ),
      brightness: Brightness.light,
      iconTheme: const IconThemeData(color: Palette.primary),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      extensions: const <ThemeExtension<dynamic>>[
        TracksyncColors(
          background: Palette.background,
          card: Palette.card,
          buttonText: Palette.text,
          subtitle: Palette.subText,
          shadow: Palette.shadowDark,
          green: Palette.greenLatte,
          roseWater: Palette.roseWaterLatte,
          flamingo: Palette.flamingoLatte,
          pink: Palette.pinkLatte,
          mauve: Palette.mauveLatte,
          maroon: Palette.maroonLatte,
          peach: Palette.peachLatte,
          yellow: Palette.yellowLatte,
          teal: Palette.tealLatte,
          sapphire: Palette.sapphireLatte,
          sky: Palette.skyLatte,
          blue: Palette.blueLatte,
          lavender: Palette.lavenderLatte,
          red: Palette.redLatte,
        ),
      ],
    );

ThemeData themeDark(BuildContext context) => ThemeData(
      fontFamily: 'Poppins',
      useMaterial3: true,
      primaryColor: Palette.pinkMocha,
      disabledColor: Palette.shadowDark,
      hintColor: Palette.subTextDark,
      cardColor: Palette.backgroundDark,
      scaffoldBackgroundColor: Palette.backgroundDark,
      colorScheme: const ColorScheme.dark().copyWith(primary: Palette.primary),
      textTheme: TextTheme(
        displayLarge: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: Dimens.displayLarge,
              color: Palette.textDark,
            ),
        displayMedium: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontSize: Dimens.displayMedium,
              color: Palette.textDark,
            ),
        displaySmall: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontSize: Dimens.displaySmall,
              color: Palette.textDark,
            ),
        headlineMedium: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: Dimens.headlineMedium,
              color: Palette.textDark,
              fontWeight: FontWeight.w700,
              height: 36 / Dimens.headlineMedium,
            ),
        headlineSmall: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontSize: Dimens.headlineSmall,
              color: Palette.textDark,
              height: 30 / Dimens.headlineSmall,
            ),
        titleLarge: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: Dimens.titleLarge,
              color: Palette.textDark,
              height: 26 / Dimens.titleLarge,
            ),
        titleMedium: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: Dimens.titleMedium,
              color: Palette.textDark,
              height: 26 / Dimens.titleMedium,
            ),
        titleSmall: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontSize: Dimens.titleSmall,
              color: Palette.textDark,
            ),
        bodyLarge: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: Dimens.bodyLarge,
              color: Palette.textDark,
              height: 24 / Dimens.bodyLarge,
            ),
        bodyMedium: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: Dimens.bodyMedium,
            color: Palette.textDark,
            height: 20 / Dimens.bodyMedium),
        bodySmall: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: Dimens.bodySmall,
              color: Palette.textDark,
              height: 18 / Dimens.bodySmall,
            ),
        labelLarge: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: Dimens.labelLarge,
              color: Palette.textDark,
            ),
        labelMedium: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontSize: Dimens.labelMedium,
              color: Palette.textDark,
            ),
        labelSmall: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: Dimens.labelSmall,
              letterSpacing: 0.25,
              color: Palette.textDark,
            ),
      ),
      appBarTheme: const AppBarTheme().copyWith(
        titleTextStyle: Theme.of(context).textTheme.bodyLarge,
        iconTheme: const IconThemeData(color: Palette.pinkMocha),
        color: Palette.backgroundDark,
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
        ),
        surfaceTintColor: Palette.backgroundDark,
        shadowColor: Palette.shadowDark,
      ),
      drawerTheme: const DrawerThemeData().copyWith(
        elevation: Dimens.zero,
        surfaceTintColor: Palette.backgroundDark,
        backgroundColor: Palette.backgroundDark,
        shadowColor: Palette.shadowDark,
      ),
      bottomSheetTheme: const BottomSheetThemeData().copyWith(
        backgroundColor: Palette.backgroundDark,
        surfaceTintColor: Colors.transparent,
        elevation: Dimens.zero,
      ),
      dialogTheme: const DialogTheme().copyWith(
        backgroundColor: Palette.backgroundDark,
        surfaceTintColor: Colors.transparent,
        elevation: Dimens.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Palette.shadow,
        contentPadding: const EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        hintStyle: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w500, color: Palette.card),
        suffixStyle: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w500, color: Palette.card),
      ),
      brightness: Brightness.dark,
      iconTheme: const IconThemeData(color: Palette.primary),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      extensions: const <ThemeExtension<dynamic>>[
        TracksyncColors(
          background: Palette.backgroundDark,
          buttonText: Palette.textDark,
          card: Palette.cardDark,
          subtitle: Palette.subTextDark,
          shadow: Palette.shadowDark,
          green: Palette.greenMocha,
          roseWater: Palette.roseWaterMocha,
          flamingo: Palette.flamingoMocha,
          pink: Palette.pinkMocha,
          mauve: Palette.mauveMocha,
          maroon: Palette.maroonMocha,
          peach: Palette.peachMocha,
          yellow: Palette.yellowMocha,
          teal: Palette.tealMocha,
          sapphire: Palette.sapphireMocha,
          sky: Palette.skyMocha,
          blue: Palette.blueMocha,
          lavender: Palette.lavenderMocha,
          red: Palette.redMocha,
        ),
      ],
    );

class TracksyncColors extends ThemeExtension<TracksyncColors> {
  final Color? background;
  final Color? card;
  final Color? buttonText;
  final Color? subtitle;
  final Color? shadow;
  final Color? green;
  final Color? roseWater;
  final Color? flamingo;
  final Color? pink;
  final Color? mauve;
  final Color? maroon;
  final Color? peach;
  final Color? yellow;
  final Color? teal;
  final Color? sky;
  final Color? sapphire;
  final Color? blue;
  final Color? lavender;
  final Color? red;

  const TracksyncColors({
    this.background,
    this.card,
    this.buttonText,
    this.subtitle,
    this.shadow,
    this.green,
    this.roseWater,
    this.flamingo,
    this.pink,
    this.mauve,
    this.maroon,
    this.peach,
    this.yellow,
    this.teal,
    this.sapphire,
    this.sky,
    this.blue,
    this.lavender,
    this.red,
  });

  @override
  ThemeExtension<TracksyncColors> copyWith({
    Color? background,
    Color? card,
    Color? buttonText,
    Color? subtitle,
    Color? shadow,
    Color? green,
    Color? roseWater,
    Color? flamingo,
    Color? pink,
    Color? mauve,
    Color? maroon,
    Color? peach,
    Color? yellow,
    Color? teal,
    Color? sky,
    Color? sapphire,
    Color? blue,
    Color? lavender,
    Color? red,
  }) {
    return TracksyncColors(
      background: background ?? this.background,
      card: card ?? this.card,
      buttonText: buttonText ?? this.buttonText,
      subtitle: subtitle ?? this.subtitle,
      shadow: shadow ?? this.shadow,
      green: green ?? this.green,
      roseWater: roseWater ?? this.roseWater,
      flamingo: flamingo ?? this.flamingo,
      pink: pink ?? this.pink,
      mauve: mauve ?? this.mauve,
      maroon: maroon ?? this.maroon,
      peach: peach ?? this.peach,
      yellow: yellow ?? this.yellow,
      teal: teal ?? this.teal,
      sky: sky ?? this.sky,
      sapphire: sapphire ?? this.sapphire,
      blue: blue ?? this.blue,
      lavender: lavender ?? this.lavender,
      red: red ?? this.red,
    );
  }

  @override
  ThemeExtension<TracksyncColors> lerp(
    covariant ThemeExtension<TracksyncColors>? other,
    double t,
  ) {
    if (other is! TracksyncColors) {
      return this;
    }
    return TracksyncColors(
      background: Color.lerp(background, other.background, t),
      card: Color.lerp(card, other.card, t),
      buttonText: Color.lerp(buttonText, other.buttonText, t),
      subtitle: Color.lerp(subtitle, other.subtitle, t),
      shadow: Color.lerp(shadow, other.shadow, t),
      green: Color.lerp(green, other.green, t),
      roseWater: Color.lerp(roseWater, other.roseWater, t),
      flamingo: Color.lerp(flamingo, other.flamingo, t),
      pink: Color.lerp(pink, other.pink, t),
      mauve: Color.lerp(mauve, other.mauve, t),
      maroon: Color.lerp(maroon, other.maroon, t),
      peach: Color.lerp(peach, other.peach, t),
      yellow: Color.lerp(yellow, other.yellow, t),
      teal: Color.lerp(teal, other.teal, t),
      sapphire: Color.lerp(sapphire, other.sapphire, t),
      blue: Color.lerp(blue, other.blue, t),
      lavender: Color.lerp(lavender, other.lavender, t),
      sky: Color.lerp(sky, other.sky, t),
      red: Color.lerp(red, other.red, t),
    );
  }
}

class BoxDecorations {
  BoxDecorations(this.context);

  final BuildContext context;

  BoxDecoration get button => BoxDecoration(
        color: Palette.primary,
        borderRadius:
            const BorderRadius.all(Radius.circular(Dimens.cornerRadius)),
        boxShadow: [BoxShadows(context).button],
      );

  BoxDecoration get card => BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius:
            const BorderRadius.all(Radius.circular(Dimens.cornerRadius)),
        boxShadow: [BoxShadows(context).card],
      );
}

class BoxShadows {
  BoxShadows(this.context);

  final BuildContext context;

  BoxShadow get button => BoxShadow(
        color: Theme.of(context)
            .extension<TracksyncColors>()!
            .shadow!
            .withOpacity(0.5),
        blurRadius: 16.0,
        spreadRadius: 1.0,
      );

  BoxShadow get card => BoxShadow(
        color: Theme.of(context)
            .extension<TracksyncColors>()!
            .shadow!
            .withOpacity(0.5),
        blurRadius: 5.0,
        spreadRadius: 0.5,
      );

  BoxShadow get dialog => BoxShadow(
        color: Theme.of(context).extension<TracksyncColors>()!.shadow!,
        offset: const Offset(0, -4),
        blurRadius: 16.0,
      );

  BoxShadow get dialogAlt => BoxShadow(
        color: Theme.of(context).extension<TracksyncColors>()!.shadow!,
        offset: const Offset(0, 4),
        blurRadius: 16.0,
      );

  BoxShadow get buttonMenu => BoxShadow(
        color: Theme.of(context).extension<TracksyncColors>()!.shadow!,
        blurRadius: 4.0,
      );
}

class NoSplashScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
