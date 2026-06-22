<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Web\AuthWebController;
use App\Http\Controllers\Web\RecipeWebController;
use App\Http\Controllers\Web\FavoriteController;
use App\Http\Controllers\Web\CommentController;

Route::get('/', function () {
    return redirect('/login');
});

Route::get('/login', [AuthWebController::class, 'showLogin']);
Route::post('/login', [AuthWebController::class, 'login']);

Route::get('/register', [AuthWebController::class, 'showRegister']);
Route::post('/register', [AuthWebController::class, 'register']);

Route::middleware('auth')->group(function () {

    Route::post('/logout', [AuthWebController::class, 'logout']);

    Route::resource('recipes', RecipeWebController::class);

    Route::get('/recipes/create',
    [RecipeWebController::class, 'create']);

    Route::post('/recipes',
    [RecipeWebController::class, 'store']);

    Route::get(
    '/recipes/{id}/edit',
    [RecipeWebController::class, 'edit']);

    Route::put(
    '/recipes/{id}',
    [RecipeWebController::class, 'update']);
    
    Route::delete(
    '/recipes/{id}',
    [RecipeWebController::class, 'destroy']);
    
    Route::get(
    '/recipes/{id}',
    [RecipeWebController::class, 'show']);

    Route::post(
    '/favorites/{id}',
    [FavoriteController::class,'toggle']);

    Route::get(
    '/favorites',
    [FavoriteController::class,'index']);

    Route::post(
    '/recipes/{id}/comment',
    [CommentController::class,'store']);

    Route::get('/profile', function () {

    $recipeCount =
        \App\Models\Recipe::where(
            'user_id',
            auth()->id()
        )->count();

    return view(
        'profile',
        compact('recipeCount')
    );
    
    })->middleware('auth');
});