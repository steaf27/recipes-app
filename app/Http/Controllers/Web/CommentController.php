<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Comment;
use Illuminate\Http\Request;

class CommentController extends Controller
{
    public function store(Request $request,$id)
    {
        $request->validate([
            'comment' => 'required'
        ]);

        Comment::create([

            'user_id' => auth()->id(),

            'recipe_id' => $id,

            'comment' => $request->comment
        ]);

        return back()->with(
            'success',
            '💬 Komentar berhasil ditambahkan'
        );
    }
}