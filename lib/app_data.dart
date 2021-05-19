import 'dart:math';
import 'dart:ui';

import 'package:flutter/services.dart';

class AppData {
  static final Color primaryColor = Color(0xff00203F);
  static final Color secondaryColor = Color(0xffADEFD1);
  static final String appTitle = "Number Shapes";
  static final String topText = "Please input a number to see if it is square or cube";
  static final String yourNumberText = "Your number here";
  static int userInputNumber = -1;

  // method for removing 0 if it's the first character and the input has more than one character
  static String handleZeroFirstCharacter(String input) {
    return input.substring(1);
  }

  // method for checking if the input number is square
  static bool numberIsSquare(int number) {
    bool isSquare = false;

    if (number > 0) {
      //storing the value of the square root of the input number
      double root = sqrt(number);

      // if both the second power of root is equal to the input number and the root is an integer, the input number is square
      if (pow(root, 2) == number && pow(root, 2) is int && root is int)
        isSquare = true;
    }

    return isSquare;
  }

  // method for checking if the input number is cube
  static bool numberIsCube(int number) {
    bool isCube = false;

    if (number > 0) {
      // storing the rounded up value of the 3rd order root of the input number (e.g: 3.99996 ~ 4)
      int thirdOrderRoot = pow(number, 1 / 3).round();

      // looping from 1 to the rounded up 3rd order root and checking if its third power is equal to the input number => whole cube
      for (int counter = 1; counter <= thirdOrderRoot; ++counter)
        if (pow(counter, 3) == number) {
          isCube = true;
          break;
        }
    }

    return isCube;
  }

  // method for closing the app
  static void closeApp()
  {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}
