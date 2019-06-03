<?php

namespace App\Imports;

use App\Product;
use Illuminate\Support\Collection;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\ToCollection;
use Maatwebsite\Excel\Row;
use Maatwebsite\Excel\Concerns\OnEachRow;

class ProductsImport implements ToModel
{
    /**
    * @param array $row
    *
    * @return \Illuminate\Database\Eloquent\Model|null
    */


    /*public function collection(Collection $rows)
    {   
        $count = 0;
        foreach ($rows as $row) 
        {
            $count ++;
            if($count > 3){
                echo "<pre>";
                print_r($row);
                echo "*******************************************************************"; 
                echo "<br>";
            }
        }
    }*/

    
    public function model(array $row)
    {
        static $count = 0;
        $count ++;

        if($count > 3){
            /*echo "<pre>";
            print_r($row);
            echo "*******************************************************************"; 
            echo "<br>";*/  

            return new Product([
                'feed_product_type' => $row[0],
                'item_sku' => $row[1],
                'brand_name' => $row[2],
                'item_name' => $row[3],
                'external_product_id' => $row[4],
                'external_product_id_type' => $row[5],
                'manufacturer' => $row[6],
                'item_type' => $row[7],
                'unit_count' => $row[8],
                'unit_count_type' => $row[9],
                'standard_price' => $row[10],
                'quantity' => $row[11],
                'update_delete' => $row[12],
                'main_image_url' => $row[13],
                'other_image_url1' => $row[14],
                'other_image_url2' => $row[15],
                'other_image_url3' => $row[16],
                'product_description' => $row[17],
                'bullet_point1' => $row[18],
                'bullet_point2' => $row[19],
                'bullet_point3' => $row[20],
                'bullet_point4' => $row[21],
                'bullet_point5' => $row[22],
                'color_name' => $row[23],
                'is_adult_product' => $row[24]
            ]);


        }
        
    }
}
