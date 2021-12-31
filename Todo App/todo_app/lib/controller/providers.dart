import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/controller/todo_list_database.dart';
import 'package:todo_app/models/todo_model.dart';

final getAllTodoProvider =
    FutureProvider.autoDispose<List<ToDoModel>>((ref) async {
  return getAllToDo();
});

final deleteToDoProvider =
    FutureProvider.autoDispose.family<List<ToDoModel>, int?>((ref, id) async {
  return deleteMenu(id!);
});

class AddMenuNotifier extends ChangeNotifier {
  AddMenuNotifier() : super();

  Future<bool> onSubmit(Map<String, String> body, String api) async {
    return await addToDo(body, api);
  }
}

final addToDoProvider =
    ChangeNotifierProvider.autoDispose<AddMenuNotifier>((ref) {
  return AddMenuNotifier();
});

class UpdateMenuNotifier extends ChangeNotifier {
  UpdateMenuNotifier() : super();

  Future<bool> onUpdate(Map<String, String> body, String api) async {
    return await updateToDo(body, api);
  }
}

final updateToDoProvider =
    ChangeNotifierProvider.autoDispose<UpdateMenuNotifier>((ref) {
  return UpdateMenuNotifier();
});
