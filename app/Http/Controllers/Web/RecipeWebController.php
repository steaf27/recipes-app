<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Recipe;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class RecipeWebController extends Controller
{
    public function index()
    {
        $recipes = Recipe::latest()->get();

        return view(
            'recipes.index',
            compact('recipes')
        );
    }

    public function create()
    {
        return view('recipes.create');
    }

    public function store(Request $request)
    {
        $request->validate([

            'title' => 'required',

            'description' => 'required',

            'image' => 'nullable|image|mimes:jpg,jpeg,png|max:2048'
        ]);

        $imagePath = null;

        if ($request->hasFile('image')) {

            $imagePath = $request
                ->file('image')
                ->store('recipes', 'public');
        }

        Recipe::create([
    'title' => $request->title,
    'description' => $request->description,
    'ingredients' => $request->ingredients,
    'tools' => $request->tools,
    'steps' => $request->steps,
    'image' => $imagePath,

    'user_id' => auth()->id()
]);

        return redirect('/recipes')
            ->with(
                'success',
                'Resep berhasil ditambahkan'
            );
    }

    public function edit($id)
{
    $recipe = Recipe::findOrFail($id);

    return view(
        'recipes.edit',
        compact('recipe')
    );
}

public function update(Request $request, $id)
{
    $recipe = Recipe::findOrFail($id);

    $request->validate([

        'title' => 'required',

        'description' => 'required',

        'image' => 'nullable|image|mimes:jpg,jpeg,png|max:2048'
    ]);

    $imagePath = $recipe->image;

    if ($request->hasFile('image')) {

        if ($recipe->image) {

            Storage::disk('public')
                ->delete($recipe->image);
        }

        $imagePath = $request
            ->file('image')
            ->store('recipes', 'public');
    }

   $recipe->update([

    'title' => $request->title,

    'description' => $request->description,

    'ingredients' => $request->ingredients,

    'tools' => $request->tools,

    'steps' => $request->steps,

    'image' => $imagePath

    ]);

    return redirect('/recipes')
        ->with(
            'success',
            'Resep berhasil diperbarui'
        );
}

public function destroy($id)
{
    $recipe = Recipe::findOrFail($id);

    if ($recipe->image) {

        Storage::disk('public')
            ->delete($recipe->image);
    }

    $recipe->delete();

    return redirect('/recipes')
        ->with(
            'success',
            'Resep berhasil dihapus'
        );
}

public function show($id)
{
    $recipe = Recipe::with([
        'comments.user'
    ])->findOrFail($id);

    return view(
        'recipes.show',
        compact('recipe')
    );
}
}