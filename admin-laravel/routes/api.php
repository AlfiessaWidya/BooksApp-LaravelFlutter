<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ArticlesController;
use App\Http\Controllers\UserController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::post('/register', [UserController::class, 'register']);
Route::post('/login', [UserController::class, 'login']);
Route::get('/user', [UserController::class, 'getCurentUser']);
Route::post('/update', [UserController::class, 'update']);
Route::get('/logout', [UserController::class, 'logout']);

Route::get('/welcome-info', [ArticlesController::class, 'welcomeInfo']);
Route::get('/articles', [ArticlesController::class, 'readAll']);
//recommended
Route::get('/recommendedarticles/', [ArticlesController::class, 'getRecommended']);
Route::get('/allarticles/', [ArticlesController::class, 'allArticles']);