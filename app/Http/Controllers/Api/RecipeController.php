<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Recipe;
use Illuminate\Http\Request;

class RecipeController extends Controller
{
    public function index()
    {
        return Recipe::all();
    }

    public function store(Request $request)
    {
        $recipe = Recipe::create($request->all());

        return response()->json([
            'message' => 'Recipe berhasil ditambahkan',
            'data' => $recipe
        ]);
    }

    public function show($id)
    {
        return Recipe::findOrFail($id);
    }

    public function update(Request $request, $id)
    {
        $recipe = Recipe::findOrFail($id);

        $recipe->update($request->all());

        return response()->json([
            'message' => 'Recipe berhasil diupdate',
            'data' => $recipe
        ]);
    }

    public function destroy($id)
    {
        Recipe::destroy($id);

        return response()->json([
            'message' => 'Recipe berhasil dihapus'
        ]);
    }
}