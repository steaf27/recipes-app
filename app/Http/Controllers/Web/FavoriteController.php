<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Favorite;
use App\Models\Recipe;

class FavoriteController extends Controller
{
    public function index()
    {
        $favorites = Favorite::with('recipe')
            ->where(
                'user_id',
                auth()->id()
            )
            ->latest()
            ->get();

        return view(
            'favorites.index',
            compact('favorites')
        );
    }

    public function toggle($id)
{
    $recipe = Recipe::findOrFail($id);

    $favorite = Favorite::where(
        'user_id',
        auth()->id()
    )->where(
        'recipe_id',
        $recipe->id
    )->first();

    if($favorite){

        $favorite->delete();

        return back()->with(
            'success',
            '❤️ Resep dihapus dari favorit'
        );

    }else{

        Favorite::create([
            'user_id' => auth()->id(),
            'recipe_id' => $recipe->id
        ]);

        return back()->with(
            'success',
            '❤️ Resep ditambahkan ke favorit'
        );
    }
}
}