@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">Create Places:</div>

                <div class="card-body">
                    <form method="POST" action="{{route('places.store')}}" enctype="multipart/form-data">
                        @csrf
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="name">Name:</label>
                                    <input type="text" class="form-control" id="name" name="name"
                                        placeholder="Enter Place Name" required>
                                </div>
                                <div class="form-group">
                                    <label for="address">Address</label>
                                    <input type="text" class="form-control" id="address" name="address"
                                        placeholder="Address" required>
                                </div>
                                <div class="form-group">
                                    <label for="address">Category:</label>
                                    <select name="category" id="category" class="form-control">
                                        @foreach ($categories as $category)
                                        <option value="{{$category->id}}">{{$category->name}}</option>
                                        @endforeach
                                        {{-- <option value="1">Adventure</option>
                                        <option value="2">Historical</option>
                                        <option value="3">Religious</option>
                                        <option value="4">Nature</option> --}}

                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="description">Description</label>
                                    <textarea name="description" id="description" cols="30" rows="2"
                                        class="form-control" required></textarea>
                                </div>
                                <div class="form-group">
                                    <label for="image">Image:</label>
                                    <input type="file" class="form-control" id="image_path" name="image_path">
                                </div>
                                {{-- <div class="form-group">
                                    <label for="exampleInputPassword1">Video:</label>
                                    <input type="file" class="form-control" id="video_path" name="video_path">
                                </div> --}}
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary">Submit</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection