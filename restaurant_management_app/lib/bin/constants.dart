// table images paths. WARNING they do not include extensions = .png
import 'package:flutter/material.dart';

const twoTablePath = "assets/2Table";
const threeTablePath = "assets/3Table";
const fourTablePath = "assets/4Table";
const sixTablePath = "assets/6Table";
const eightTablePath = "assets/8Table";
const feedbackPath = "Feedback";
// --------------------------------

// max number of floors for floorplan
const maxFloors = 10;

// possible zooms for tables
List<double> zoomFactors = [0.5, 0.65, 0.75, 1.0, 1.25, 1.5];

const smallTblWidth = 112;
const largeTblWidth = 168;
const tblHeight = 112;

enum AssetPaths {
  small2,
  small2highlighted,
  small2selected,
  small2selectedhighlighted,
  small2feedback,

  small3,
  small3highlighted,
  small3selected,
  small3selectedhighlighted,
  small3feedback,

  small4,
  small4highlighted,
  small4selected,
  small4selectedhighlighted,
  small4feedback,

  large6,
  large6highlighted,
  large6selected,
  large6selectedhighlighted,
  large6feedback,

  large8,
  large8highlighted,
  large8selected,
  large8selectedhighlighted,
  large8feedback
}

extension AssetPathsExtension on AssetPaths {
  String get value {
    switch (this) {
      case AssetPaths.small2:
        return 'assets/tables/small/small_2';
      case AssetPaths.small2highlighted:
        return 'assets/tables/small/small_2_highlighted';
      case AssetPaths.small2selected:
        return 'assets/tables/small/small_2_selected';
      case AssetPaths.small2selectedhighlighted:
        return 'assets/tables/small/small_2_selected_highlighted';
      case AssetPaths.small2feedback:
        return 'assets/tables/small/small_2_feedback';

      case AssetPaths.small3:
        return 'assets/tables/small/small_3';
      case AssetPaths.small3highlighted:
        return 'assets/tables/small/small_3_highlighted';
      case AssetPaths.small3selected:
        return 'assets/tables/small/small_3_selected';
      case AssetPaths.small3selectedhighlighted:
        return 'assets/tables/small/small_3_selected_highlighted';
      case AssetPaths.small3feedback:
        return 'assets/tables/small/small_3_feedback';

      case AssetPaths.small4:
        return 'assets/tables/small/small_4';
      case AssetPaths.small4highlighted:
        return 'assets/tables/small/small_4_highlighted';
      case AssetPaths.small4selected:
        return 'assets/tables/small/small_4_selected';
      case AssetPaths.small4selectedhighlighted:
        return 'assets/tables/small/small_4_selected_highlighted';
      case AssetPaths.small4feedback:
        return 'assets/tables/small/small_4_feedback';

      case AssetPaths.large6:
        return 'assets/tables/large/large_6';
      case AssetPaths.large6highlighted:
        return 'assets/tables/large/large_6_highlighted';
      case AssetPaths.large6selected:
        return 'assets/tables/large/large_6_selected';
      case AssetPaths.large6selectedhighlighted:
        return 'assets/tables/large/large_6_selected_highlighted';
      case AssetPaths.large6feedback:
        return 'assets/tables/large/large_6_feedback';

      case AssetPaths.large8:
        return 'assets/tables/large/large_8';
      case AssetPaths.large8highlighted:
        return 'assets/tables/large/large_8_highlighted';
      case AssetPaths.large8selected:
        return 'assets/tables/large/large_8_selected';
      case AssetPaths.large8selectedhighlighted:
        return 'assets/tables/large/large_8_selected_highlighted';
      case AssetPaths.large8feedback:
        return 'assets/tables/large/large_8_feedback';
    }
  }
}

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

//reservation Section

const int availableHours = 3;

//---------------------------------