
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(),
  inputDecorationTheme: InputDecorationTheme(
     focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.black)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
                color: Colors.black)),
  )
);

ThemeData darkTheme =
    ThemeData(brightness: Brightness.dark, colorScheme: ColorScheme.dark(),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),

        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),

        borderSide: BorderSide(color: Colors.white)
      )
    )
    );


            // ThemeData(
            //     scaffoldBackgroundColor: Colors.white,
            //     primaryColor: Colors.white,
            //     appBarTheme: AppBarTheme(backgroundColor: Colors.white),
            //     dialogTheme: DialogTheme(
            //       backgroundColor: Colors.white,
            //     ),
            //     dialogBackgroundColor: Colors.white),