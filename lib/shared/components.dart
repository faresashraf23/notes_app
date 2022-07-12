// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../Screens/view_notes.dart';
import '../business_logic/cubit/app_cubit.dart';
import 'constants.dart';

Widget defaultTextAnimated(
        String text, BuildContext context, int index, AppCubit cubit) =>
    SizedBox(
      width: 250.0,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 20.0,
          fontFamily: 'Agne',
          color: Colors.white,
        ),
        child: GestureDetector(
          child: AnimatedTextKit(
            totalRepeatCount: 1,
            animatedTexts: [
              TypewriterAnimatedText(
                text,
                speed: const Duration(milliseconds: 100),
              ),
            ],
            onTap: () {
              cubit.changeIndex(index);
              print("selected index ${cubit.pressedIndex}");
              print("delete index = ${cubit.selectedIndex}");

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ViewNotesScreen()));
            },
          ),
          onLongPress: () {
            cubit.changeIndex(index);
            _alertDialog(context: context);
            print("Long press");
          },
        ),
      ),
    );

_alertDialog({
  required context,
}) async {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Delete"),
      content: const Text("You want to delete this item?"),
      actions: [
        TextButton(
          onPressed: () {
            AppCubit cubit = AppCubit.get(context);

            cubit.deleteDatabase(cubit.selectedIndex);
            print("selecedIndex = ${cubit.selectedIndex}}");

            Navigator.pop(context);
          },
          child: const Text("Yes"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("No"),
        ),
      ],
    ),
  );
}

Widget defaultStaggeredGridView(List notes, AppCubit cubit) => Expanded(
      child: StaggeredGridView.countBuilder(
        mainAxisSpacing: 2.0,
        crossAxisSpacing: 2.0,
        itemCount: notes.length,
        crossAxisCount: 2,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Card(
              color: CardColor.getColor(cardColors),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    defaultTextAnimated(
                        "${notes[index]['title']}", context, index, cubit),
                    Text("${notes[index]['date']}"),
                  ],
                ),
              ),
            ),
          );
        },
        staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
      ),
    );

Widget defaultFormFeild({
  required TextEditingController mycontroller,
  required TextInputType textInputType,
  required TextInputAction textInputAction,
  required String hint,
  required Color hintColor,
  required FontWeight weight,
  required double size,
  String? initialText,
}) =>
    TextFormField(
      restorationId: initialText,
      cursorColor: titleColor,
      maxLines: null,
      minLines: 1,
      controller: mycontroller,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      style: TextStyle(
        color: hintColor,
        fontSize: size,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        hintStyle: TextStyle(
          color: hintColor,
          fontSize: 30.0,
          fontWeight: weight,
        ),
        border: InputBorder.none,
        hintText: hint,
      ),
    );

Widget defaultFloatingActionButton(
  BuildContext context,
  IconData icon,
  pageroute,
) =>
    FloatingActionButton(
      autofocus: true,
      elevation: 50.0,
      backgroundColor: primaryColor,
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: pageroute));
      },
      child: Icon(
        icon,
        size: 35.0,
        color: Colors.white,
      ),
    );

Widget defaultAppBar({
  required BuildContext context,
  required AppCubit cubit,
  required Widget icon,
  required void Function()? iconPress,
}) =>
    AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: primaryColor,
      title: Container(
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
        width: 60.0,
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
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
          margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
          // width: 60.0,
          child: IconButton(
            onPressed: iconPress,
            icon: icon,
            // splashRadius: 20.0,
          ),
        ),
      ],
    );
