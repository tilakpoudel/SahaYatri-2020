@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header"> Booking Information:
                    {{-- <a href="{{route('guides.create')}}" style="float:right">Add New Guide</a> --}}
                </div>
                {{-- <div></div> --}}

                <div class="card-body">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <td>Guide Name</td>
                                <td>Tourist Name</td>
                                <td>Country</td>
                                <td>Duaration</td>
                                <td>Visit Area</td>
                                {{-- <td>Status</td> --}}
                            </tr>
                        </thead>
                        <tbody>
                            @foreach ($bookings as $booking)
                            <tr>
                                <td>{{$booking->guide[0]->name}}</td>
                                <td>{{$booking->tourist_name}}</td>
                                <td>{{$booking->country}}</td>
                                <td>{{$booking->start_day}} - {{$booking->end_day}}</td>
                                <td>{{$booking->start_location}} -
                                    {{$booking->visit_area[0]->name}},{{$booking->visit_area[0]->address}}</td>
                                {{-- <td>{{$booking->status}}</td> --}}
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