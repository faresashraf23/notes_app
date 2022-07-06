import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:note_app/shared/constants.dart';
import 'Screens/home_layout.dart';
import 'business_logic/bloc/bloc_observer.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      // Use cubits...
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        backgroundColor: primaryColor,
        primaryColor: primaryColor,
        buttonTheme: ButtonThemeData(buttonColor: Color(0xff1B2430)),
      ),
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
    );
  }
}










