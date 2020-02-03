@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">Add Guide information:</div>

                <div class="card-body">
                    <form method="POST" action="{{route('guides.store')}}" enctype="multipart/form-data">
                        @csrf
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="name">Name:</label>
                                    <input type="text" class="form-control" id="name" name="name"
                                        placeholder="Enter Guide Name" required>
                                </div>
                                <div class="form-group">
                                    <label for="address">Address</label>
                                    <input type="text" class="form-control" id="address" name="address"
                                        placeholder="Address" required>
                                </div>
                                <div class="form-group">
                                    <label for="address">Contact Number</label>
                                    <input type="text" class="form-control" id="contact_no" name="contact_no"
                                        placeholder="contact_no" required>
                                </div>
                                <div class="form-group">
                                    <label for="address">Email</label>
                                    <input type="text" class="form-control" id="email" name="email" placeholder="email"
                                        required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="national_id">National Id</label>
                                    <input type="text" id="national_id_no" class="form-control" name="national_id_no"
                                        required>
                                </div>
                                <div class="form-group">
                                    <label for="national_id">National Id Issue District</label>
                                    <input type="text" name="national_id_issue_district" id="national_id_issue_district"
                                        class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="image">Image:</label>
                                    <input type="file" class="form-control" id="image_path" name="image_path">
                                </div>
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