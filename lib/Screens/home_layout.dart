// ignore_for_file: avoid_print

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_app/Screens/add_notes.dart';
import 'package:note_app/business_logic/cubit/app_cubit.dart';
import 'package:note_app/database.dart';

import '../shared/components.dart';
import '../shared/constants.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              bottom: PreferredSize(
                preferredSize: const Size(double.infinity, 1.0),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 2.0),
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.white,
                ),
              ),
              elevation: 0,
              backgroundColor: primaryColor,
              title: TextButton(
                onPressed: () {
                  cubit
                      .insertDatabase(
                    title: "First",
                    message: "Hello",
                    date: "apr 2 ,2032",
                  )
                      .then((_) {
                    print(cubit.notes);
                    print("database = ${cubit.database}");
                  });
                },
                child: const Text(
                  "Notes",
                  style: TextStyle(fontSize: 25.0, color: Colors.white),
                ),
              ),
              actions: [
                Container(
                  decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 8.0),
                  width: 60.0,
                  height: 40.0,
                  child: IconButton(
                    onPressed: () {
                      print("${cubit.notes}");
                      print("${cubit.pressedIndex}");
                      print("${cubit.notes[cubit.pressedIndex]["message"]}");
                    },
                    icon: const Icon(
                      CupertinoIcons.search,
                      size: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: Theme.of(context).backgroundColor,
            body: ConditionalBuilder(
              condition: cubit.notes.isNotEmpty,
              builder: (context) => Container(
                  width: double.infinity,
                  color: Theme.of(context).backgroundColor,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20.0,
                        ),
                        defaultStaggeredGridView(
                          cubit.notes,
                          cubit,
                        ),
                      ])),
              fallback: (context) => Center(
                child: Image.asset(
                  "assets/images/empty.gif",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            floatingActionButton: defaultFloatingActionButton(
                context, Icons.add, (context) => AddNoteScreen()),
          ),
        );
      },
    );
  }
}
