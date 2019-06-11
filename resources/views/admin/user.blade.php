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
              <h3 class="box-title">Users</h3>
            </div>
            <!-- /.box-header -->
              <div class="box">
            <!-- /.box-header -->
            <div class="box-body">
              <table id="example1" class="table table-bordered table-striped">
                <thead>
                  <tr>
                    <th>SNo.</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email</th>
                    <th>City</th>
                    <th>State</th>
                    <th>Gender</th>
                    <th>Created At</th>
                    <th>Action</th>
                  </tr>
                </thead>
                <tbody>
                   <?php $count = 1;?>
                   @foreach ($users as $user)
                      <tr>
                        <td>{{ $count++ }}</td>
                        <td>{{ isset($user->first_name) ? $user->first_name : 'Not Available' }}</td>
                        <td>{{ isset($user->last_name) ? $user->last_name : 'Not Available' }}</td>
                        <td>{{ isset($user->email) ? $user->email : 'Not Available' }}</td>
                        <td>{{ isset($user->city) ? $user->city : 'Not Available' }}</td>
                        <td>{{ isset($user->state) ? $user->state : 'Not Available' }}</td>
                        <td>{{ isset($user->gender) ? $user->gender : 'Not Available' }}</td>
                        <td>{{ $user->created_at }}</td>
                        <td><a href="{{ url('/edit-profile/'.$user->id) }}" >Edit</a>&nbsp;&nbsp;<a href="{{ url('/delete-profile/'.$user->id) }}" >Delete</a></td>
                    </tr>
                   @endforeach
                </tbody>
                <tfoot>
                  <tr>
                    <th>SNo.</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email</th>
                    <th>City</th>
                    <th>State</th>
                    <th>Gender</th>
                    <th>Created At</th>
                    <th>Action</th>
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