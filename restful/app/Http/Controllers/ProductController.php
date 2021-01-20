<?php

namespace App\Http\Controllers;
use App\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
class ProductController extends Controller
{
    public function index()
    {
        $record = Product::all();
        return response()->json($record);
    }

    public function create(Request $request)
    {
        $record = new Product;
        $record->name = $request->name;
        $record->price = $request->price;
        $record->category=$request->category;
        $record->qty = $request->qty;
        $record->description = $request->description;
        $record->save();
        
        return response()->json(array(
            'success' => true, 'mypets' => Product::findOrFail($record->id)));
    }

    public function update (Request $request, $id)
    {
        try{
           
            Product::findOrFail($id)->update(
                [
                 'price'=>$request->price,
                 'qty'=>$request->qty,
                 'category'=>$request->category
                 ]);

            return response()->json(array(
                    'products' => Product::findOrFail($id)));
         
        }catch(\Exception $e){
            return response()->json(['status'=>'Fail']);
        }
    }

    public function delete($id)
    {
        try{
            $record = Product::FindOrFail($id);
            $record -> delete();
            return response()->json(['status' => true, 'message'=>'Product Deleted']);
        }catch(\Exception $e){
            return response()->json(['status'=>'Fail']);
        }
    }
   
    public function frozen()
    {
        $product = DB::table('product')->where('category', 'frozen')->get();

        return response()->json($product);
    }
    public function canned()
    {
        $product = DB::table('product')->where('category', 'canned')->get();

        return response()->json($product);
    }
    public function foodpack()
    {
        $product = DB::table('product')->where('category', 'packed')->get();

        return response()->json($product);
    }
    public function beverages()
    {
        $product = DB::table('product')->where('category', 'beverages')->get();

        return response()->json($product);
    }
    public function medicine()
    {
        $product = DB::table('product')->where('category', 'pharmaceutical')->get();

        return response()->json($product);
    }
}


