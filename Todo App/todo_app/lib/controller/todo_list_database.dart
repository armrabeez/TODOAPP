import 'package:http/http.dart' as http;
import 'package:todo_app/exceptions.dart';
import 'dart:convert';
import 'dart:io';
import 'package:todo_app/global.dart' as global;
import 'package:todo_app/models/todo_model.dart';

Future<List<ToDoModel>> getAllToDo() async {
  var url = Uri.parse("${global.url}/getAllToDo");

  dynamic responseJson;

  try {
    final response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      responseJson =
          parsed.map<ToDoModel>((json) => ToDoModel.fromJson(json)).toList();
    }
  } on SocketException {
    throw ApiException('No Internet Connection');
  } on HttpException {
    throw ApiException("Couldn't find the post");
  } on FormatException {
    throw ApiException("Bad response format");
  }
  return responseJson;
}

Future<List<ToDoModel>> deleteMenu(int id) async {
  var url = Uri.parse("${global.url}/deleteToDo/$id");

  dynamic responseJson;

  try {
    final response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      responseJson =
          parsed.map<ToDoModel>((json) => ToDoModel.fromJson(json)).toList();
    }
  } on SocketException {
    throw ApiException('No Internet Connection');
  } on HttpException {
    throw ApiException("Couldn't find the post");
  } on FormatException {
    throw ApiException("Bad response format");
  }
  return responseJson;
}

Future<bool> addToDo(Map<String, String> body, String api) async {
  String url = '${global.url}/$api';

  Map<String, String> headers = {
    'Content-Type': 'multipart/form-data',
  };
  var request = http.MultipartRequest('POST', Uri.parse(url))
    ..fields.addAll(body)
    ..headers.addAll(headers);

  var response = await request.send();

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> updateToDo(Map<String, String> body, String api) async {
  String url = '${global.url}/$api';

  Map<String, String> headers = {
    'Content-Type': 'multipart/form-data',
  };
  var request = http.MultipartRequest('POST', Uri.parse(url))
    ..fields.addAll(body)
    ..headers.addAll(headers);

  var response = await request.send();

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
