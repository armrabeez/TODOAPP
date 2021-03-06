<?php

use App\Http\Controllers\ToDoController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/
Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::post('/addToDo', [ToDoController::class, 'addToDo']);
Route::post('/updateToDo/{id}', [ToDoController::class, 'updateToDo']);

Route::get('/getAllToDo', [ToDoController::class, 'getAllToDo']);
Route::get('/deleteToDo/{id}', [ToDoController::class, 'deleteToDo']);

