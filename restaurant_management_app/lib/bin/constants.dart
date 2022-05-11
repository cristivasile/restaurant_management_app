// table images paths. WARNING they do not include extensions = .png
import 'dart:ui';

import 'package:flutter/material.dart';

const twoTablePath = "assets/2Table";
const threeTablePath = "assets/3Table";
const fourTablePath = "assets/4Table";
const sixTablePath = "assets/6Table";
const eightTablePath = "assets/8Table";
const feedbackPath = "Feedback";
// --------------------------------

// widths of the table images. Heights are equal to 92 for all images so smallTableWidth can be used
const smallTableWidth = 92;
const largeTableWidth = 140;
// --------------------------------

const double floorMargin = 10;

//const smallModifier = 0.5;
//const largeModifier = 1.5;

//color scheme
const Color mainColor = Color.fromRGBO(222, 160, 87, 1);
const Color accent1Color = Color.fromRGBO(224, 216, 176, 1);
const Color accent2Color = Color.fromRGBO(252, 255, 231, 1);
// --------------------------------

//menu sections
List<String> sections = [
  "Appetizers",
  "Main courses",
  "Sides",
  "Soft drinks",
  "Spirits"
];

Map sectionIcons = {
  'Appetizers': Icons.apple,
  'Main courses': Icons.food_bank,
  'Sides': Icons.food_bank_outlined,
  'Soft drinks': Icons.local_drink,
  'Spirits': Icons.wine_bar
};
//---------------------------------