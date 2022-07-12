// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/Screens/edit_note.dart';
import 'package:note_app/Screens/home_layout.dart';
import 'package:note_app/shared/components.dart';
import 'package:note_app/shared/constants.dart';

import '../business_logic/cubit/app_cubit.dart';

class ViewNotesScreen extends StatelessWidget {
  ViewNotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        int index = cubit.pressedIndex;

        return Scaffold(
          backgroundColor: primaryColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: primaryColor,
            title: Container(
              decoration: BoxDecoration(
                color: containerColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
              width: 60.0,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  CupertinoIcons.back,
                ),
              ),
            ),
            actions: [
              Container(
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                width: 60.0,
                child: IconButton(
                  onPressed: () {
                    cubit.deleteDatabase(cubit.selectedIndex);
                    Navigator.pop(context);
                  },
                  icon: Icon(CupertinoIcons.delete),
                  splashRadius: 20.0,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      "${cubit.notes[index]['title']}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                        color: titleColor,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "${cubit.notes[index]['date']}",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "${cubit.notes[index]['message']}",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 25.0,
                        color: messageColor,
                      ),
                    ),
                  ]),
            ),
          ),
          floatingActionButton: defaultFloatingActionButton(
            context,
            Icons.edit,
            (context) => EditNoteScreen(),
          ),
        );
      },
    );
  }
}
