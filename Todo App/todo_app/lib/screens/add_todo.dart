import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/controller/providers.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/widgets/button.dart';
import 'package:todo_app/widgets/textfield.dart';

class AddToDo extends StatefulWidget {
  const AddToDo({Key? key}) : super(key: key);

  @override
  _AddToDoState createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _customAppBar(context),
              Container(
                width: 200.w,
                height: 50.h,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Center(
                  child: Text(
                    "Add ToDo",
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 40.h),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      GetTextField(
                        hintText: "Title",
                        controller: titleController,
                        obscureText: false,
                        validator: (input) {
                          if (input!.isEmpty) {
                            return 'Enter a title';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      GetTextField(
                        hintText: "Description",
                        controller: descController,
                        obscureText: false,
                        validator: (input) {
                          if (input!.isEmpty) {
                            return 'Enter description';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 45.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 90.w,
                            child: GetTextButton(
                              btnText: "Clear",
                              backgroundColor: Colors.orange,
                              onPressed: () {
                                _allClear();
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          SizedBox(
                            width: 90.w,
                            child: Consumer(
                              builder: (context, ref, child) {
                                return GetTextButton(
                                  btnText: "Add",
                                  backgroundColor: Colors.green,
                                  onPressed: () async {
                                    ToDoModel toDoModel = ToDoModel();

                                    if (validateAndSave()) {
                                      toDoModel.title = titleController.text;
                                      toDoModel.description =
                                          descController.text;
                                      toDoModel.id = 0;

                                      Map<String, String> map =
                                          toDoModel.toStringJson();

                                      await ref
                                          .watch(addToDoProvider)
                                          .onSubmit(map, 'addToDo');

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('ToDo added'),
                                        ),
                                      );
                                      _allClear();
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _allClear() {
    setState(() {
      titleController.text = "";
      descController.text = "";
    });
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  _customAppBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.5.w, vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.black.withOpacity(0.9),
              size: 30.sp,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          // IconButton(
          //   icon: Icon(
          //     FontAwesomeIcons.search,
          //     color: Colors.black.withOpacity(0.9),
          //     size: 30.sp,
          //   ),
          //   onPressed: () {},
          // ),
        ],
      ),
    );
  }
}
