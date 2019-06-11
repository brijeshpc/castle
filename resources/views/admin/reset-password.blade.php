@extends('layouts.admin.password')

@section('content')
<div class="container">
     <form action="{{ url('update-password') }}" method="post">
        {{ csrf_field() }}
        <div class="form-group">
            <label for="title">Password</label>
            <input type="password" class="form-control"   name="password">
        </div>
        
        <div class="form-group">
            <label for="description">Confirm Password</label>
            <input type="hidden" class="form-control"  value="{{ $token }}" name="token_value"/>
            <input type="password" class="form-control"  name="confirm_password"/>
        </div>
              @if ($errors->any())
            <div class="alert alert-danger">
                <ul>
                    @foreach ($errors->all() as $error)
                        <li>{{ $error }}</li>
                    @endforeach
                </ul>
            </div>
        @endif
        <button type="submit" class="btn btn-primary">Submit</button>
    </form>
</div>
@endsection
