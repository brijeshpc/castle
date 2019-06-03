<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    //

    protected $fillable = [
        'feed_product_type',
        'item_sku',
        'brand_name',
        'item_name',
        'external_product_id',
        'external_product_id_type',
        'manufacturer',
        'item_type',
        'unit_count',
        'unit_count_type',
        'standard_price',
        'quantity',
        'update_delete',
        'main_image_url',
        'other_image_url1',
        'other_image_url2',
        'other_image_url3',
        'product_description',
        'bullet_point1',
        'bullet_point2',
        'bullet_point3',
        'bullet_point4',
        'bullet_point5',
        'color_name',
        'is_adult_product',
        'created_at',
        'updated_at'
    ];



}
