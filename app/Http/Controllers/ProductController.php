<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Imports\ProductsImport;
use Maatwebsite\Excel\Facades\Excel;

class ProductController extends Controller
{
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