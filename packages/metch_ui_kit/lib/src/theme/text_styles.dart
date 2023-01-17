import 'package:flutter/material.dart';
import 'package:metch_ui_kit/metch_ui_kit.dart';

const _metchFontFamily = 'Tahoma';

const _textSizeParagraph = 18.0;

const _textSizeTitle = 35.0;

const _textSizeHeadline1 = 24.0;

const _textSizeHeadline2 = 22.0;

const _textSizeHeadline3 = 20.0;

const _textSizeHeadline4 = 18.0;

const paragraph = TextStyle(
  fontFamily: _metchFontFamily,
  fontSize: _textSizeParagraph,
  color: Color(0xffc6d9e5),
);

const paragraphBold = TextStyle(
  fontFamily: _metchFontFamily,
  fontSize: _textSizeParagraph,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

TextStyle caption(double size , Color color) {
  return TextStyle(
    fontFamily: _metchFontFamily,
    fontSize: size,
    color: color,
  );
}

const title = TextStyle(
  fontFamily: _metchFontFamily,
  fontSize: _textSizeTitle,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

TextStyle headline1(double size) {
  return TextStyle(
    fontFamily: _metchFontFamily,
    fontSize: size,
    color: textGrayColor,
  );
}

const headline1HomeScreen = TextStyle(
  fontFamily: _metchFontFamily,
  fontSize: _textSizeHeadline1,
  color: Colors.white,
);

const headline2 = TextStyle(
  fontFamily: _metchFontFamily,
  fontSize: _textSizeHeadline2,
  color: Colors.white,
);

const headline3 = TextStyle(
  fontFamily: _metchFontFamily,
  fontSize: _textSizeHeadline3,
  color: textGrayColor,
);

const headline4 = TextStyle(
  fontFamily: _metchFontFamily,
  fontSize: _textSizeHeadline4,
  color: textGrayColor,
);

const headline4Black = TextStyle(
  fontFamily: _metchFontFamily,
  fontSize: _textSizeHeadline4,
  color: Colors.black,
);

const headline1Bold = TextStyle(
  fontFamily: _metchFontFamily,
  fontSize: _textSizeHeadline1,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

const secondaryText = TextStyle(
  fontFamily: _metchFontFamily,
  color: textGrayColor,
  fontSize: 18,
);

const buttonText = TextStyle(
  fontFamily: _metchFontFamily,
  color: Colors.white,
  fontSize: 20,
);
