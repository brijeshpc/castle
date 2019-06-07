@extends('layouts.admin.master')

@section('content')

<div class="row">
    <!-- left column -->
    <div class="col-md-12">
        <!-- general form elements -->
        <div class="box box-primary">
        <div class="box-header with-border">
          <h3 class="box-title">Users</h3>
        </div>
        <!-- /.box-header -->
        <!-- form start -->
        <form role="form" action="{{ url('importExcel') }}" method="post" enctype="multipart/form-data" >
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
              <label for="exampleInputFile">File Input</label>
              <input type="file" name = "import_file" id="exampleInputFile">
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