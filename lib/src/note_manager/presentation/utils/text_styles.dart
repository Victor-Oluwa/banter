import 'package:banter/core/res/color.dart';
import 'package:banter/core/res/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as ql;
import 'package:flutter_quill/flutter_quill.dart';

getDefaultTextStyle(double width) {
  return ql.DefaultStyles(
    color: BanterColors.textColor1,
    h1: _defaultTextBlocStyle(
        horiSpaceLeft: 0.0,
        horiSpaceRight: 0.0,
        lineSpaceLeft: 0.0,
        lineSpaceRight: 0.0,
        vertiSpaceLeft: 0,
        vertiSpaceRight: 1.5,
        fontSize: width * 0.08,
        fontWeight: FontWeight.bold),
    h2: _defaultTextBlocStyle(
      horiSpaceLeft: 0.0,
      horiSpaceRight: 0.0,
      lineSpaceLeft: 0.0,
      lineSpaceRight: 0.0,
      vertiSpaceLeft: 0,
      vertiSpaceRight: 1.5,
      fontSize: width * 0.06,
    ),
    h3: _defaultTextBlocStyle(
        horiSpaceLeft: 0.0,
        horiSpaceRight: 0.0,
        lineSpaceLeft: 0.0,
        lineSpaceRight: 0.0,
        vertiSpaceLeft: 0,
        vertiSpaceRight: 1.5,
        fontSize: width * 0.05),
    paragraph: _defaultTextBlocStyle(
      horiSpaceLeft: 0.0,
      horiSpaceRight: 0.0,
      lineSpaceLeft: 0.0,
      lineSpaceRight: 0.0,
      vertiSpaceLeft: 0,
      vertiSpaceRight: 1.5,
      fontSize: width * 0.03,
    ),
    lists: _defaultListBlocStyle(
      horiSpaceLeft: 0.0,
      horiSpaceRight: 0.0,
      lineSpaceLeft: 0.0,
      lineSpaceRight: 0.0,
      vertiSpaceLeft: 0,
      vertiSpaceRight: 1.5,
      fontSize: width * 0.03,
    ),
    indent: _defaultTextBlocStyle(
      horiSpaceLeft: 0.0,
      horiSpaceRight: 0.0,
      lineSpaceLeft: 0.0,
      lineSpaceRight: 0.0,
      vertiSpaceLeft: 0,
      vertiSpaceRight: 1.5,
      fontSize: width * 0.03,
    ),
    leading: _defaultTextBlocStyle(
      horiSpaceLeft: 0.0,
      horiSpaceRight: 0.0,
      lineSpaceLeft: 0.0,
      lineSpaceRight: 0.0,
      vertiSpaceLeft: 0,
      vertiSpaceRight: 1.5,
      fontSize: width * 0.03,
    ),
    code: _defaultCodeTextBlocStyle(
      horiSpaceLeft: 0.0,
      horiSpaceRight: 0.0,
      lineSpaceLeft: 0.0,
      lineSpaceRight: 0.0,
      vertiSpaceLeft: 0,
      vertiSpaceRight: 1.5,
      fontSize: width * 0.03,
    ),
    inlineCode: _inlineCodeStyle(
      fontSize: width * 0.03,
      width: width,
    ),
    quote: _defaultQuoteTextBlocStyle(
      horiSpaceLeft: 0.0,
      horiSpaceRight: 0.0,
      lineSpaceLeft: 0.0,
      lineSpaceRight: 0.0,
      vertiSpaceLeft: 0,
      vertiSpaceRight: 1.5,
      fontSize: width * 0.03,
    ),

  );

}

_defaultCodeTextBlocStyle({
  required double horiSpaceLeft,
  required double horiSpaceRight,
  required double vertiSpaceLeft,
  required double vertiSpaceRight,
  required double lineSpaceLeft,
  required double lineSpaceRight,
  double? fontSize,
  FontWeight? fontWeight,
}) {
  const baseHorizontalSpacing = HorizontalSpacing(0, 0);
  const baseVerticalSpacing = VerticalSpacing(6, 0);
  return ql.DefaultTextBlockStyle(
    TextStyle(
      color: BanterColors.textColor1,
      fontFamily: BanterFonts.balooBhai,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
      baseHorizontalSpacing,
      baseVerticalSpacing,
      VerticalSpacing.zero,
      BoxDecoration(
        color: BanterColors.cardColor,
        borderRadius: BorderRadius.circular(2),
      )
  );
}

_defaultQuoteTextBlocStyle({
  required double horiSpaceLeft,
  required double horiSpaceRight,
  required double vertiSpaceLeft,
  required double vertiSpaceRight,
  required double lineSpaceLeft,
  required double lineSpaceRight,
  double? fontSize,
  FontWeight? fontWeight,
}) {
  const baseHorizontalSpacing = HorizontalSpacing(0, 0);
  const baseVerticalSpacing = VerticalSpacing(6, 0);
  return ql.DefaultTextBlockStyle(
    TextStyle(
      color: BanterColors.textColor1,
      fontFamily: BanterFonts.balooBhai,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
    baseHorizontalSpacing,
    baseVerticalSpacing,
     VerticalSpacing.zero,
    BoxDecoration(
      border: Border(
        left: BorderSide(width: 4, color: BanterColors.cardColor),
      ),
    ),
  );
}

_inlineCodeStyle({
  double? fontSize,
  FontWeight? fontWeight,
 required double width,
}) {
  return ql.InlineCodeStyle(
    backgroundColor: BanterColors.cardColor,
    style: TextStyle(
      color: BanterColors.darkBackground,
      fontFamily: BanterFonts.balooBhai,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
    header1: TextStyle(
      color: BanterColors.darkBackground,
      fontFamily: BanterFonts.balooBhai,
      // fontSize: width * 0.08,
      fontWeight: fontWeight,
    ),
    header2: TextStyle(
      color: BanterColors.darkBackground,
      fontFamily: BanterFonts.balooBhai,
      fontWeight: fontWeight,
    ),
    header3: TextStyle(
      color: BanterColors.darkBackground,
      fontFamily: BanterFonts.balooBhai,
      fontWeight: fontWeight,
    ),
  );
}

_defaultListBlocStyle({
  required double horiSpaceLeft,
  required double horiSpaceRight,
  required double vertiSpaceLeft,
  required double vertiSpaceRight,
  required double lineSpaceLeft,
  required double lineSpaceRight,
  double? fontSize,
  FontWeight? fontWeight,
}) {
  return ql.DefaultListBlockStyle(
    TextStyle(
      color: BanterColors.textColor1,
      fontFamily: BanterFonts.balooBhai,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
    ql.HorizontalSpacing(horiSpaceLeft, horiSpaceRight),
    ql.VerticalSpacing(vertiSpaceLeft, vertiSpaceRight),
    ql.VerticalSpacing(lineSpaceLeft, lineSpaceRight),
    BoxDecoration(),
    null,
  );
}

_defaultTextBlocStyle({
  required double horiSpaceLeft,
  required double horiSpaceRight,
  required double vertiSpaceLeft,
  required double vertiSpaceRight,
  required double lineSpaceLeft,
  required double lineSpaceRight,
  double? fontSize,
  FontWeight? fontWeight,
}) {
  return ql.DefaultTextBlockStyle(
    TextStyle(
      color: BanterColors.textColor1,
      fontFamily: BanterFonts.balooBhai,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
    ql.HorizontalSpacing(horiSpaceLeft, horiSpaceRight),
    ql.VerticalSpacing(vertiSpaceLeft, vertiSpaceRight),
    ql.VerticalSpacing(lineSpaceLeft, lineSpaceRight),
    null,
  );
}
