<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Recipe extends Model
{
    protected $fillable = [
    'title',
    'description',
    'ingredients',
    'tools',
    'steps',
    'image',
    'user_id'
];

    public function favorites()
{
    return $this->hasMany(Favorite::class);
}

public function comments()
{
    return $this->hasMany(Comment::class);
}
}