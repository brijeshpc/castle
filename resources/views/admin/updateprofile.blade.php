@extends('layouts.admin.master')

@section('content')

<div class="row">
    <!-- left column -->
    <div class="col-md-12">
        <!-- general form elements -->
        <div class="box box-primary">
        <div class="box-header with-border">
          <h3 class="box-title">Import Products</h3>
        </div>
        <!-- /.box-header -->
        <!-- form start -->
        <form role="form" action="{{ url('update-profile') }}" method="post" enctype="multipart/form-data" >
          @csrf
          <div class="box-body">
            <div class="form-group">
                @if ($errors->any())
                    <div class="alert alert-danger">
                        <a href="#" class="close" data-dismiss="alert" aria-label="close">×</a>
                        <ul>
                            @foreach ($errors->all() as $error)
                                <li>{{ $error }}</li>
                            @endforeach
                        </ul>
                    </div>
                @endif
                @if (Session::has('success'))
                    <div class="alert alert-success">
                        <a href="#" class="close" data-dismiss="alert" aria-label="close">×</a>
                        <p>{{ Session::get('success') }}</p>
                    </div>
                @endif

              <label for="exampleInputFile">First Name</label>
              <input type="text" name = "first_name" id="first_name" value="{{ $user->first_name }}">


              <label for="exampleInputFile">Last Name</label>
              <input type="text" name = "last_name" id="last_name" value="{{ $user->last_name }}">

              <label for="exampleInputFile">City</label>
              <input type="text" name = "city" id="city" value="{{ $user->city }}">

              <label for="exampleInputFile">State</label>
              <input type="text" name = "state" id="state" value="{{ $user->state }}">

              <label for="exampleInputFile">Zip</label>
              <input type="number" name = "zip" id="zip" value="{{ $user->zip }}">

              <input type="hidden" name = "id" id="zip" value="{{ $user->id }}">

            </div>
        </div>
          <!-- /.box-body -->
         <div class="box-footer">
            <button type="submit" class="btn btn-primary">Upload</button>
        </div>
    </form>
</div>
          <!-- /.box -->
@endsection