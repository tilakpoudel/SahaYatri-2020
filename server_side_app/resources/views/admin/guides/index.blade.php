@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header"> Guides Information:
                    <a href="{{route('guides.create')}}" style="float:right">Add New Guide</a>
                </div>
                {{-- <div></div> --}}

                <div class="card-body">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <td>Name</td>
                                <td>Address</td>
                                <td>Contact_no</td>
                                <td>Email</td>
                                <td>National Id</td>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach ($guides as $guide)
                            <tr>
                                <td>{{$guide->name}}</td>
                                <td>{{$guide->address}}</td>
                                <td>{{$guide->contact_no}}</td>
                                <td>{{$guide->email}}</td>
                                <td>{{$guide->national_id_no}}</td>

                            </tr>
                            @endforeach

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection