import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:note_app/business_logic/cubit/app_cubit.dart';
import 'package:note_app/shared/components.dart';

import '../shared/constants.dart';

class EditNoteScreen extends StatelessWidget {
  EditNoteScreen({Key? key}) : super(key: key);

  var titleController = TextEditingController();
  var messageController = TextEditingController();
  var dateController = TextEditingController();

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
            backgroundColor: primaryColor,
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
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
                  margin: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 8.0),
                  width: 60.0,
                  child: IconButton(
                    onPressed: () {
                      dateController.text =
                          DateFormat.yMMMd().format(DateTime.now()).toString();
                      cubit
                          .updateDatabase(
                        title: titleController.text,
                        date: dateController.text,
                        message: messageController.text,
                        id: cubit.selectedIndex,
                      )
                          .then((_) {
                        Navigator.pop(context);
                      });
                    },
                    icon: const Text(
                      "Update",
                      style: TextStyle(fontSize: 12.0),
                    ),
                    // splashRadius: 20.0,
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: double.infinity,
                      ),
                      child: defaultFormFeild(
                          initialText: cubit.notes[cubit.pressedIndex]['title'],
                          mycontroller: titleController,
                          textInputType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          hint: "Title",
                          hintColor: titleColor,
                          weight: titleTextStyle,
                          size: titleTextSize),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: double.infinity,
                      ),
                      child: defaultFormFeild(
                        initialText: cubit.notes[cubit.pressedIndex]['message'],
                        mycontroller: messageController,
                        textInputType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        hint: "Type something...",
                        hintColor: messageColor,
                        weight: messageTextStyle,
                        size: messageTextSize,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
