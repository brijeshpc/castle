<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Imports\ProductsImport;
use Maatwebsite\Excel\Facades\Excel;
use Maatwebsite\Excel\Concerns\WithValidation;
use App\Product;
use SpreadsheetReader;

class ProductController extends Controller
{

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth');
    }

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
    /*public function importExcel(Request $request) 
    {
        $request->validate([
            'import_file'   => 'required|mimes:xlsx,ods',
            //'extension' => 'required|xlsx,xls,odt,ods,odp'
        ]);
        Excel::import(new ProductsImport,request()->file('import_file'));
        return back()
            ->with('success','File Uploaded successfully.');
    }
    */
    public function importExcel(Request $request) 
    {
          require_once('library/php-excel-reader/excel_reader2.php');
          require_once('library/SpreadsheetReader.php');
          //echo "Excel"; die;

          $file = $request->file('import_file');
       
          //Display File Name
          echo 'File Name: '.$file->getClientOriginalName();
          echo '<br>';
       
          //Display File Extension
          echo 'File Extension: '.$file->getClientOriginalExtension();
          echo '<br>';
       
          //Display File Real Path
          echo 'File Real Path: '.$file->getRealPath();
          echo '<br>';
       
          //Display File Size
          echo 'File Size: '.$file->getSize();
          echo '<br>';
       
          //Display File Mime Type
          echo 'File Mime Type: '.$file->getMimeType();
       
          //Move Uploaded File
          $destinationPath = public_path().'/uploads/';
          $file->move($destinationPath,$file->getClientOriginalName());

          //echo "Uploaded"; die;
            //Move Uploaded File
            $targetPath = public_path().'/uploads/'.$file->getClientOriginalName();

            $Reader = new SpreadsheetReader($targetPath);
      
        
            $sheetCount = count($Reader->sheets());

            //echo $sheetCount; die;

            $flagCount = 0;

            for($i=0;$i<$sheetCount;$i++)
            {
                $flagCount++;
                $Reader->ChangeSheet($i);

                
                foreach ($Reader as $Row)
                {
                    echo "<pre>"; print_r($Row);

                    $name = "";
                    if(isset($Row[0])) {
                        $name = mysqli_real_escape_string($conn,$Row[0]);
                    }
                    
                    $description = "";

                    if(isset($Row[1])) {
                        $description = mysqli_real_escape_string($conn,$Row[1]);
                    }

                    if (!empty($name) || !empty($description)) {
                        $query = "insert into tbl_info(name,description) values('".$name."','".$description."')";
                        $result = mysqli_query($conn, $query);
                    
                        if (! empty($result)) {
                            $type = "success";
                            $message = "Excel Data Imported into the Database";
                        } else {
                            $type = "error";
                            $message = "Problem in Importing Excel Data";
                        }
                    } else {
                        $emptyRows[] = $flagCount;
                    }
                 }
            
             }
    }

  }
