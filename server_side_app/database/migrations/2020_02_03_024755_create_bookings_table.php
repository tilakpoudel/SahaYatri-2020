<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateBookingsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {

        Schema::create('bookings', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->integer('tourist_id');
            $table->string('tourist_name')->nullable();
            $table->string('email')->nullable();
            $table->string('phone_number');
            $table->string('country');
            $table->integer('travel_guide_id');
            $table->string('start_location');
            $table->integer('destination_location');
            $table->string('start_day');
            $table->string('end_day');

            $table->timestamps();
        });
    }
    // public\uploads\places_photos\1580679580.png

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('bookings');
    }
}
