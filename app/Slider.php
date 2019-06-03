<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Slider extends Model
{

    protected $table = 'sliders';
    //
    protected $fillable = [
        'title',
        'image',
        'sort_order',
        'created_at',
        'updated_at'
    ];
}
