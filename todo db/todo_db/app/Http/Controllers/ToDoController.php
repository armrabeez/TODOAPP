<?php

namespace App\Http\Controllers;

use App\Models\todo;
use Illuminate\Http\Request;

class ToDoController extends Controller
{
    //
    public function addToDo(Request $request) {

        $todo = new todo();

        $todo->title = $request->title;
        $todo->description = $request->description;

        $todo->save();
        return $todo;
    }

    public function updateToDo(Request $request, $id) {

        $todo = todo::find($id);
        
        $todo->title = $request->title;
        $todo->description = $request->description;

        $todo->save();
        return $todo;
    }

    public function getAllToDo() {

        $data = todo::all();

        return $data;
    }

    public function deleteToDo($id) {

        todo::find($id)->delete();

        $data = todo::all();

        return $data;
    }
}
