<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Favorite;

class FavoriteController extends Controller
{
    public function index(Request $request)
    {
        $favorites = Favorite::with('recipe')
            ->where('user_id', $request->user()->id)
            ->get();

        return response()->json($favorites);
    }

    public function store(Request $request)
    {
        $favorite = Favorite::create([
            'user_id' => $request->user()->id,
            'recipe_id' => $request->recipe_id
        ]);

        return response()->json([
            'message' => 'Berhasil ditambahkan ke favorit',
            'data' => $favorite
        ]);
    }

    public function destroy($id)
    {
        Favorite::destroy($id);

        return response()->json([
            'message' => 'Favorit berhasil dihapus'
        ]);
    }
}