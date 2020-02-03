@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header"> Places Info:
                    <a href="{{route('places.create')}}" style="float:right">Add New Places</a>
                </div>
                {{-- <div></div> --}}

                <div class="card-body">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <td> Place Name</td>
                                <td>Address</td>
                                <td>Description</td>
                                <td>Category</td>
                                {{-- <td></td> --}}
                            </tr>
                        </thead>
                        <tbody>
                            @foreach ($places as $place)
                            <tr>
                                <td>{{$place->name}}</td>
                                <td>{{$place->address}}</td>
                                <td>{{$place->description}}</td>
                                <td>{{$place->categories[0]->name}}</td>
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