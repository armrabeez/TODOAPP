import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/controller/providers.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/screens/edit_todo.dart';
import 'package:todo_app/widgets/button.dart';

class ViewToDo extends StatefulWidget {
  const ViewToDo({Key? key, this.allToDo, required this.index})
      : super(key: key);

  final int index;
  final List<ToDoModel>? allToDo;

  @override
  _ViewToDoState createState() => _ViewToDoState();
}

class _ViewToDoState extends State<ViewToDo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _customAppBar(context),
              _customHeader(),
              _customBody(context),
            ],
          ),
        ),
      ),
    );
  }

  _customBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 35.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 3.0,
            color: Colors.green[100],
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Title",
                    style: TextStyle(
                      fontSize: 20.h,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 20.sp,
                      ),
                      SizedBox(
                        width: 15.h,
                      ),
                      Text(
                        "${widget.allToDo![widget.index].title}",
                        style: TextStyle(
                          fontSize: 30.h,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 45.h,
                  ),
                  Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 20.h,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 20.sp,
                      ),
                      SizedBox(
                        width: 15.h,
                      ),
                      Text(
                        "${widget.allToDo![widget.index].description}",
                        style: TextStyle(
                          fontSize: 30.h,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 45.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 100.w,
                child: GetTextButton(
                  btnText: "Edit",
                  backgroundColor: Colors.orange[600],
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => EditToDo(
                              index: widget.index,
                              allToDo: widget.allToDo,
                            )));
                  },
                ),
              ),
              SizedBox(
                width: 40.h,
              ),
              SizedBox(
                width: 100.w,
                child: Consumer(
                  builder: (context, ref, child) {
                    return GetTextButton(
                      btnText: "Delete",
                      backgroundColor: Colors.red[700],
                      onPressed: () {
                        showDialog(
                          barrierColor: Colors.black54,
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Do you want to delete?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    ref.watch(deleteToDoProvider(
                                        widget.allToDo![widget.index].id));

                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: Colors.red[600],
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _customHeader() {
    return Container(
      width: 280.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Center(
        child: Text(
          "Selected ToDo",
          style: TextStyle(
            fontSize: 30.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
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
