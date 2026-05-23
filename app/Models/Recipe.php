<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Recipe extends Model
{
    protected $fillable = [
        'title',
        'description',
        'image'
    ];

    public function favorites()
{
    return $this->hasMany(Favorite::class);
}
}