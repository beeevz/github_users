import 'package:flutter/material.dart';

// extension on ThemeData {
//   get favoriteBorder => Colors.red.shade800;
//   // get favoriteBorder => null;
// }
ThemeData get lightTheme {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    sliderTheme: SliderThemeData(
      activeTrackColor: Colors.red,
      disabledActiveTrackColor: Colors.grey,
    ),
  );
}
