@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">Categories Info:
                    <a href="{{route('categories.create')}}" style="float:right">Add New Category</a>
                </div>
                {{-- <div></div> --}}

                <div class="card-body">
                    <table class="table table-striped table-hover ">
                        <thead>
                            <tr>
                                <td> Category Name</td>

                            </tr>
                        </thead>
                        <tbody>
                            @foreach ($categories as $category)
                            <tr>
                                <td>{{$category->name}}</td>
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