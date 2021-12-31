import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/controller/providers.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/screens/view_todo.dart';

class AllToDo extends StatefulWidget {
  const AllToDo({Key? key}) : super(key: key);

  @override
  _AllToDoState createState() => _AllToDoState();
}

class _AllToDoState extends State<AllToDo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _customAppBar(context),
            Container(
              width: 220.w,
              height: 50.h,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Center(
                child: Text(
                  "My ToDos",
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            _allToDo(context),
          ],
        ),
      ),
    );
  }

  _allToDo(BuildContext context) {
    return Expanded(
      child: Container(
        // color: Theme.of(context).primaryColorLight,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 35.h),
        child: Consumer(
          builder: (context, ref, child) {
            AsyncValue<List<ToDoModel>> allToDo = ref.watch(getAllTodoProvider);

            return allToDo.when(
              error: (error, stack) => Center(
                child: Text(
                  error.toString(),
                ),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              data: (allToDo) => ListView.builder(
                itemCount: allToDo.length,
                itemBuilder: (context, int index) {
                  return Column(
                    children: [
                      Card(
                        color: Colors.green[300],
                        elevation: 5.0,
                        child: ListTile(
                          leading: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                          title: Text(
                            "${allToDo[index].title}",
                            style: TextStyle(
                              fontSize: 21.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewToDo(
                                          index: index,
                                          allToDo: allToDo,
                                        )));
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  _customAppBar(BuildContext context) {
    return Container(
      // color: Colors.red[100],
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
          IconButton(
            icon: Icon(
              FontAwesomeIcons.search,
              color: Colors.black.withOpacity(0.9),
              size: 30.sp,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearch(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null.toString());
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  final recentTodo = ["Task 1", "Task 5", "Task 6", "Task 8"];
  final todo = [
    "Taaaassssk 1",
    "Taaaask 2",
    "Task 3",
    "Task 4",
    "Task 5",
    "Task 6",
    "Task 7",
    "Task 8"
  ];

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? recentTodo
        : todo.where((t) => t.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
        );
      },
      itemCount: suggestions.length,
    );
  }
}
