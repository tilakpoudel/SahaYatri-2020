<?php

use Illuminate\Database\Seeder;

class RatingReviewSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //
               DB::table('rating_reviews')->insert([
            [
                'user_id' => 1,
                'location_id' => 1,
                'rating' => 2,
                'review' => 'Butwal is a nice city to visit'
            ],
           [
                'user_id' => 2,
                'location_id' => 1,
                'rating' => 3,
                'review' => 'Wow'
            ],
            [
                'user_id' => 3,
                'location_id' => 1,
                'rating' => 4,
                'review' => 'Nice'
            ],
           
        ]);
    }
}
