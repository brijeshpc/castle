@extends('layouts.admin.master')

@section('content')

<div class="row">
    <!-- left column -->
    <div class="col-md-12">
        <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-header">
              <h3 class="box-title">Products</h3>
            </div>
            <!-- /.box-header -->
              <div class="box">
            <!-- /.box-header -->
            <div class="box-body">
              <table id="example1" class="table table-bordered table-striped">
                <thead>
                  <tr>
                    <th>SNo.</th>
                    <th>Feed Product Type</th>
                    <th>Item Sku</th>
                    <th>Brand Name</th>
                    <th>Item Name</th>
                    <th>Manufacturer</th>
                    <th>Item Type</th>
                    <th>Standard Price</th>
                    <th>Quantity</th>
                    <th>Is Adult Product</th>
                    <th>Product For</th>
                    <th>Exclusive</th>
                    <th>Created At</th>
                  </tr>
                </thead>
                <tbody>
                   @foreach ($products as $product)
                      <tr>
                        <td>{{ isset($product->id) ? $product->id : 'Not Available' }}</td>
                        <td>{{ isset($product->feed_product_type) ? $product->feed_product_type : 'Not Available' }}</td>
                        <td>{{ isset($product->item_sku) ? $product->item_sku : 'Not Available' }}</td>
                        <td>{{ isset($product->brand_name) ? $product->brand_name : 'Not Available' }}</td>
                        <td>{{ isset($product->item_name) ? $product->item_name : 'Not Available' }}</td>
                        <td>{{ isset($product->manufacturer) ? $product->manufacturer : 'Not Available' }}</td>
                        <td>{{ isset($product->item_type) ? $product->item_type : 'Not Available' }}</td>
                        <td>{{ isset($product->standard_price) ? $product->standard_price : 'Not Available' }}</td>
                        <td>{{ isset($product->quantity) ? $product->quantity : 'Not Available' }}</td>
                        <td>{{ isset($product->is_adult_product) ? $product->is_adult_product : 'Not Available' }}</td>
                        <td>{{ isset($product->product_for) ? $product->product_for : 'Not Available' }}</td>
                        <td>{{ isset($product->exclusive) ? $product->exclusive : 'Not Available' }}</td>
                        <td>{{ $product->created_at }}</td>
                    </tr>
                   @endforeach
                </tbody>
                <tfoot>
                  <tr>
                    <th>SNo.</th>
                    <th>Feed Product Type</th>
                    <th>Item Sku</th>
                    <th>Brand Name</th>
                    <th>Item Name</th>
                    <th>Manufacturer</th>
                    <th>Item Type</th>
                    <th>Standard Price</th>
                    <th>Quantity</th>
                    <th>Is Adult Product</th>
                    <th>Product For</th>
                    <th>Exclusive</th>
                    <th>Created At</th>
                  </tr>
                </tfoot>
              </table>
            </div>
            <!-- /.box-body -->
          </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->

          
          <!-- /.box -->
        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->
    </section>

    </div>
</div>

<!-- /.box -->
@endsection