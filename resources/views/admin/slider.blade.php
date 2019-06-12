@extends('layouts.admin.master')

@section('content')
<div class="row">
    <!-- left column -->
    <div class="col-md-12">
        <!-- general form elements -->
        <div class="box box-primary">
        <div class="box-header with-border">
        <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css"> -->
        <style type="text/css">
            .gallery
            {
                display: inline-block;
                margin-top: 20px;
            }
            .action .close-icon {
                border-radius: 0;
                position: initial;
                right: 5px;
                top: -10px;
                padding: 9px 29px;
                background: #3c8dbc;
                border: 0;
                border-radius: 3px;
            }
            .form-image-upload{
                background: #e8e8e8 none repeat scroll 0 0;
                padding: 15px;
            }
            .action {
            width: 25%;
            float: left;
            padding-top: 10px;
            }
            .image {
            width: 21%;
            float: left;
            padding-right: 4%;
            height: 60px;
            overflow: hidden;
            }
            .title-txt {
            float: left;
            width: 18%;
            padding-right: 0;
            margin-right: 7%;
            }
            .main-section {
            width: 100%;
            float: left;
            background: #fff;
            background: #e8e8e8 none repeat scroll 0 0;
            padding: 9px 35px;
            box-shadow: 1px 2px 28px 5px #bdadad;
            margin: 10px 1px;
            }
            img.img-act {
            width: 100%;
            height: auto;
            }
            .list-gallery {
            margin-top: 50px;
            padding: 0 20px;
            max-width: 77%;
            margin: 30px auto 0;
            float: left;
            }
            .text-muted {
            color: #000 !important;
            font-size: 18px;
            text-transform: capitalize;
            }
            h2.sect-title {
            text-align: center;
            }
            .form-image-upload {
            background: #e8e8e8 none repeat scroll 0 0;
            padding: 35px;
            box-shadow: 1px 2px 28px 5px #bdadad;
            margin: 10px 1px;
            }
            .list-gallery th {
            padding: 10px 36px;
            color: #fff;
            width: 27%;
            }
            .list-gallery table {
            width: 100%;
            background: #3c8dbc;
            margin-top: 20px;
            }
            .list-gallery th.img-ttl {
            padding-left: 0;
            }
            .list-gallery th.img-nm {
            padding-left: 0;
            }
            .list-gallery th.pag-ttl {
            padding-right: 18px;
            }
            .list-gallery th.act {
            padding-left: 0;
            }
            h3.box-title.txt-cent {
            width: 100%;
            margin-bottom: 17px;
            }
        </style>
        
        <h3 class="box-title">Add Banner/Prmotion Images</h3>
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
                <span style="color:red"> Please upload an image having mimimum resolution: 650 * 360 </span><br><br>
                <div class="row">
                    <div class="col-md-5">
                        <strong>Select Page:</strong>
                        <select name="page" class="form-control" style="width: 100%;">
                              <option value="">Select Page</option>
                              <option value="home" >Home</option>
                              <option value="promotions" >Promotions</option>
                        </select>
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
                 <h3 class="box-title txt-cent">Image Listing</h3>

                <div class="selection-box">
                    
                <form method="post" action="{{ url('view-gallery') }}">
                    {!! csrf_field() !!}
                   
                    <select name="select_page" class="form-control" style="width: 100%;">
                        <option value="">Select Page</option>
                        <option value="home" >Home</option>
                        <option value="promotions" >Promotions</option>
                    </select>
                    <button type="submit" class="btn btn-primary">Submit</button> 
                </form>
                    <!-- <input type="text" name="title" class="form-control" placeholder="Title"> -->
                </div>


                            <table>
                             <tbody>
                                 <tr>
                                     <th class="pag-ttl">Page Title</th>
                                     <th class="img-ttl">Image Title</th>
                                     <th class="img-nm">Image</th>
                                     <th class="act">Action</th>
                                 </tr>
                             </tbody>
                         </table>
                    @if($images->count())
                        @foreach($images as $image)


                        <div class='main-section'>
                            <div class="title-txt">
                            <h2 class='text-muted'>{{ $image->page }}</h2>
                            </div>
                            <div class="title-txt">
                            <h2 class='text-muted'>{{ $image->title }}</h2>
                            </div>
                            <div class="image">
                            <img class="img-act" alt="" src="{{ asset('public/images').'/'.$image->image}}" />
                            </div>
                            <div class='action'>
                                <form action="{{ url('image-gallery',$image->id) }}" method="POST">
                                <input type="hidden" name="_method" value="delete">
                                {!! csrf_field() !!}
                                <button type="submit" class="close-icon btn btn-danger">Delete</i></button>
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
@endsection


