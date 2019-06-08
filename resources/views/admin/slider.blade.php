@extends('layouts.admin.master')

@section('content')
<div class="row">
    <!-- left column -->
    <div class="col-md-12">
        <!-- general form elements -->
        <div class="box box-primary">
        <div class="box-header with-border">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
        <style type="text/css">
            .gallery
            {
                display: inline-block;
                margin-top: 20px;
            }
            .close-icon{
                border-radius: 50%;
                position: absolute;
                right: 5px;
                top: -10px;
                padding: 5px 8px;
            }
            .form-image-upload{
                background: #e8e8e8 none repeat scroll 0 0;
                padding: 15px;
            }
        </style>
        <h3 class="box-title">Slider Images</h3>
            <form action="{{ url('image-gallery') }}" class="form-image-upload" method="POST" enctype="multipart/form-data">
                {!! csrf_field() !!}
                @if (count($errors) > 0)
                    <div class="alert alert-danger">
                        <strong>Whoops!</strong> There were some problems with your input.<br><br>
                        <ul>
                            @foreach ($errors->all() as $error)
                                <li>{{ $error }}</li>
                            @endforeach
                        </ul>
                    </div>
                @endif

                <div class="row">

                    <div class="col-md-5">
                        <strong>Select Page:</strong>
                        <select name="page" class="form-control" style="width: 100%;">
                              <option value="">Select Page</option>
                              <option value="home" >Home</option>
                              <option value="promotions" >Promotions</option>
                        </select>
                        <!-- <input type="text" name="title" class="form-control" placeholder="Title"> -->
                    </div>

                    <div class="col-md-5">
                        <strong>Title:</strong>
                        <input type="text" name="title" class="form-control" placeholder="Title">
                    </div>
                    <div class="col-md-5">
                        <strong>Image:</strong>
                        <input type="file" name="image" class="form-control">
                    </div>
                    <div class="col-md-2">
                        <br/>
                        <button type="submit" class="btn btn-primary">Upload</button>
                    </div>
                </div>
            </form>

            <div class="row">
                @if ($message = Session::get('success'))
                <div class="alert alert-success alert-block">
                    <button type="button" class="close" data-dismiss="alert">×</button>
                        <strong>{{ $message }}</strong>
                </div>
                @endif
                <div class='list-gallery'>
                    @if($images->count())
                        @foreach($images as $image)
                        <div class='main-section'>
                            <div class="title">
                            <h2 class='text-muted'>{{ $image->page }}</h2>
                            </div>
                            <div class="title">
                            <h2 class='text-muted'>{{ $image->title }}</h2>
                            </div>
                            <div class="image">
                            <img class="img-act" alt="" src="{{ asset('public/images').'/'.$image->image}}" />
                            </div>
                            <div class='action'>
                                <form action="{{ url('image-gallery',$image->id) }}" method="POST">
                                <input type="hidden" name="_method" value="delete">
                                {!! csrf_field() !!}
                                <button type="submit" class="close-icon btn btn-danger"><i class="glyphicon glyphicon-remove"></i></button>
                                 </form>
                            </div>
                        </div>
                        @endforeach
                    @endif
                </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--  <script type="text/javascript">
$(document).ready(function(){
    $(".fancybox").fancybox({
        openEffect: "none",
        closeEffect: "none"
    });
});
</script> -->
@endsection


