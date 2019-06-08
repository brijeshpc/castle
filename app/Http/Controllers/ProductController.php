<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Imports\ProductsImport;
use Maatwebsite\Excel\Facades\Excel;
use Maatwebsite\Excel\Concerns\WithValidation;
use App\Product;

class ProductController extends Controller
{

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    public function index()
    {

        $products = Product::get();
        return view('admin/product',compact('products'));
    }

    /**
    * @return \Illuminate\Support\Collection
    */
    public function importExport()
    {
       return view('admin/import-export');
    }
   
    /**
    * @return \Illuminate\Support\Collection
    */
    /*public function export() 
    {
        return Excel::download(new ProductsExport, 'users.xlsx');
    }*/
   
    /**
    * @return \Illuminate\Support\Collection
    */
    public function importExcel(Request $request) 
    {
        $request->validate([
            'import_file' => 'required'
        ]);
        Excel::import(new ProductsImport,request()->file('import_file'));
        return back()
            ->with('success','Products imported successfully.');
    }
}
