import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/shared/constants.dart';
import 'Screens/home_layout.dart';
import 'business_logic/bloc/bloc_observer.dart';
import 'business_logic/cubit/app_cubit.dart';

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
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()..createDatabase())
      ],
      child: MaterialApp(
        theme: ThemeData(
          backgroundColor: primaryColor,
          primaryColor: primaryColor,
          buttonTheme: ButtonThemeData(buttonColor: Color(0xff1B2430)),
        ),
        debugShowCheckedModeBanner: false,
        home: HomeLayout(),
      ),
    );
  }
}










