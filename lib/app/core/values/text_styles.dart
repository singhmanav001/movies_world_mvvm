import 'package:flutter/material.dart';

import 'app_colors.dart';

TextStyle quicksand_14ptRegular({Color? color}) {
  return TextStyle(
    color: color ?? black,
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
  );
}


TextStyle quicksand_14ptBold({Color? color}) {
  return TextStyle(
    color: color ?? black,
    fontWeight: FontWeight.w700,
    fontSize: 14.0,
  );
}

TextStyle quicksand_16ptBold({Color? color}) {
  return TextStyle(
      color: color ?? black,
      fontWeight: FontWeight.w700,
      fontSize: 16.0,
  );
}

TextStyle quicksand_16ptRegular({Color? color}) {
  return TextStyle(
      color: color ?? black,
      fontWeight: FontWeight.w500,
      fontSize: 16.0,
  );
}


TextStyle quicksand_20ptBold({Color? color}) {
  return TextStyle(
    color: color ?? black,
    fontWeight: FontWeight.w700,
    fontSize: 20.0,
  );
}

TextStyle quicksand_12ptRegular({Color? color, double multiplier = 1.0, TextDecoration decoration = TextDecoration.none}) {
  return TextStyle(
      color: color ?? black,
      fontWeight: FontWeight.w500,
      fontSize: 12.0*multiplier,
      decoration: decoration);
}


TextStyle quicksand_12ptBold({Color? color}) {
  return TextStyle(
      color: color ?? black,
      fontWeight: FontWeight.w700,
      fontSize: 12.0);
}


TextStyle quicksand_40ptNormal({Color? color}) {
  return TextStyle(
    color: color ?? black,
    fontWeight: FontWeight.w700,
    fontSize: 40.0,
  );
}

TextStyle quicksand_20ptNormal({Color? color}) {
  return TextStyle(
    color: color ?? black,
    fontWeight: FontWeight.w700,
    fontSize: 20.0,
  );
}




TextStyle h1_48ptBold({Color? color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.bold,
    fontSize: 48.0,
  );
}

TextStyle h1_48ptMedium({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.w500,
    fontSize: 48.0,
  );
}

TextStyle h1_48ptRegular({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.normal,
    fontSize: 48.0,
  );
}

TextStyle h2_32ptBold({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.bold,
    fontSize: 32.0,
  );
}

TextStyle h2_32ptMedium({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.w500,
    fontSize: 32.0,
  );
}

TextStyle h2_32ptRegular({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.normal,
    fontSize: 32.0,
  );
}

TextStyle h3_24ptBold({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.bold,
    fontSize: 24.0,
    letterSpacing: 0.18,
  );
}

TextStyle h3_24ptMedium({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.w500,
    fontSize: 24.0,
    letterSpacing: 0.18,
  );
}

TextStyle h3_24ptRegular({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.normal,
    fontSize: 24.0,
    letterSpacing: 0.18,
  );
}

TextStyle h4_20ptBold({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
    letterSpacing: 0.15,
  );
}

TextStyle h4_20ptMedium({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.w500,
    fontSize: 20.0,
    letterSpacing: 0.15,
  );
}

TextStyle h4_20ptRegular({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.normal,
    fontSize: 20.0,
    letterSpacing: 0.15,
  );
}

TextStyle buttonLarge18ptBold({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
    letterSpacing: 1.25,
  );
}

TextStyle buttonLarge18ptMedium({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.w500,
    fontSize: 18.0,
    letterSpacing: 1.25,
  );
}

TextStyle buttonLarge18ptRegular({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.normal,
    fontSize: 18.0,
    letterSpacing: 1.25,
  );
}

TextStyle body1_16ptBold({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.bold,
    fontSize: 16.0,
    letterSpacing: 0.5,
  );
}

TextStyle body1_16ptMedium({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
    letterSpacing: 0.5,
  );
}

TextStyle body1_16ptRegular({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.normal,
    fontSize: 16.0,
    letterSpacing: 0.5,
  );
}

TextStyle body2_14ptBold({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.bold,
    fontSize: 14.0,
    letterSpacing: 0.25,
  );
}

TextStyle body2_14ptMedium({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    letterSpacing: 0.25,
  );
}

TextStyle body2_14ptRegular({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.normal,
    fontSize: 14.0,
    letterSpacing: 0.25,
  );
}

TextStyle body2_14ptRegularDottedUnderline({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.normal,
    fontSize: 14.0,
    letterSpacing: 0.25,
    height: 1.5,
    decoration: TextDecoration.underline,
    decorationStyle: TextDecorationStyle.dotted,
  );
}

TextStyle buttonMedium16ptBold({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.bold,
    fontSize: 16.0,
    letterSpacing: 1.25,
  );
}

TextStyle robotoW70020pt({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.w700,
    fontSize: 20.0,
    letterSpacing: 1.25,
  );
}

TextStyle robotoW70016pt({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.w700,
    fontSize: 16.0,
    letterSpacing: 1.25,
  );
}

TextStyle buttonMedium16ptMedium({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
    letterSpacing: 1.25,
  );
}

TextStyle buttonMedium16ptRegular({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.normal,
    fontSize: 16.0,
    letterSpacing: 1.25,
  );
}

TextStyle buttonSmall14ptBold({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.bold,
    fontSize: 14.0,
    letterSpacing: 1.25,
  );
}

TextStyle buttonSmall14ptMedium({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    letterSpacing: 1.25,
  );
}

TextStyle buttonSmall14ptRegular({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.normal,
    fontSize: 14.0,
    letterSpacing: 1.25,
  );
}

TextStyle subTitle1_16ptBold({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.bold,
    fontSize: 16.0,
    letterSpacing: 0.15,
  );
}

TextStyle subTitle1_16ptMedium({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
    letterSpacing: 0.15,
  );
}

TextStyle subTitle1_16ptRegular({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.normal,
    fontSize: 16.0,
    letterSpacing: 0.15,
  );
}

TextStyle subTitle1_12ptRegular({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.normal,
    fontSize: 12.0,
    letterSpacing: 0.15,
  );
}

TextStyle subTitle1_12ptBold({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.bold,
    fontSize: 12.0,
    letterSpacing: 0.15,
  );
}

TextStyle subTitle2_14ptBold({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.bold,
    fontSize: 14.0,
    letterSpacing: 0.1,
  );
}

TextStyle subTitle2_14ptMedium({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    letterSpacing: 0.1,
  );
}

TextStyle subTitle2_14ptRegular({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.normal,
    fontSize: 14.0,
    letterSpacing: 0.15,
  );
}

const TextStyle defaultSubTitle2_14PtRegular = TextStyle(
  color:  black,
  fontWeight: FontWeight.w500,
  fontSize: 14.0,
  letterSpacing: 0.15,
);


TextStyle caption12ptBold({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.bold,
    fontSize: 12.0,
    letterSpacing: 0.4,
  );
}

TextStyle caption12ptMedium({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.w500,
    fontSize: 12.0,
    letterSpacing: 0.4,
  );
}

TextStyle caption12ptRegular({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.normal,
    fontSize: 12.0,
    letterSpacing: 0.4,
  );
}

TextStyle overLine10ptBold({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.bold,
    fontSize: 10.0,
    letterSpacing: 1.5,
  );
}

TextStyle overLine10ptMedium({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.w500,
    fontSize: 10.0,
    letterSpacing: 1.5,
  );
}

TextStyle englishH232ptBold({required Color color}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.w700,
    fontSize: 32.0,
  );
}
