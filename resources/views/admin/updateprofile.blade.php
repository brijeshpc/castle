@extends('layouts.admin.master')

@section('content')
<div class="row">
    <!-- left column -->
    <div class="col-md-12">
        <!-- general form elements -->
        <div class="box box-primary">
        <div class="box-header with-border">
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
        <h3 class="box-title">Update User</h3>
            <form action="{{ url('update-profile') }}" class="form-image-upload" method="POST" enctype="multipart/form-data">
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
                    <div class="col-md-6">
                        <strong>First Name:</strong>
                        <input type="text" name = "first_name" id="first_name" value="{{ $user->first_name }}" class="form-control" placeholder="First Name">
                    </div>

                    <div class="col-md-6">
                        <strong>Last Name:</strong>
                        <input type="text" name = "last_name" id="last_name" value="{{ $user->last_name }}" class="form-control" placeholder="Last Name">
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <strong>City:</strong>
                        <input type="text" name = "city" id="city" value="{{ $user->city }}" class="form-control" placeholder="City">
                    </div>

                    <div class="col-md-6">
                        <strong>State:</strong>
                        <input type="text" name = "state" id="state" value="{{ $user->state }}" class="form-control" placeholder="State">
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <strong>Zip:</strong>
                        <input type="text" name = "zip" id="city" value="{{ $user->zip }}" class="form-control" placeholder="Zip">
                    </div>
                    <div class="col-md-6">
                        <strong>Email:</strong>
                        <input type="text" disabled="disabled" name = "email" id="email" value="{{ $user->email }}" class="form-control" placeholder="Email">
                    </div>
                </div><br>
                <div class="row">
                    <div class="col-md-6">
                        <strong>Gender:</strong>
                        <input type="text" name = "gender" id="gender" value="{{ $user->gender }}" class="form-control" placeholder="gender">
                    </div>
                </div><br>
                <div class="row">
                    <div class="col-md-6">
                        <input type="hidden" name = "id" id="zip" value="{{ $user->id }}">
                        <button type="submit" class="btn btn-primary">Update</button>
                    </div>
                </div>
                
            </form>
            </div>
        </div>
    </div>
</div>

@endsection


