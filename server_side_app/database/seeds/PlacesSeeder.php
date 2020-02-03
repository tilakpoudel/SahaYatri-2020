<?php

use Illuminate\Database\Seeder;

class PlacesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //
        
        DB::table('places')->insert([
            [
                'name' => 'Hill Park',
                'address' => 'Butwal',
                'category' => '4',
                'description' => 'Hill park is nice place to visit',
                'visits'=>0,
                'image_path'=>'',
                'video_path'=>'',

            ],
            [
                'name' => 'Peace Park',
                'address' => 'Butwal 14 Dhabaha',
                'category' => '4',
                'description' => 'Peace park is nice place to visit',
                'visits'=>0,
                'image_path'=>'',
                'video_path'=>'',

            ],[
                'name' => 'Lumbini',
                'address' => 'Lumbini',
                'category' => '3',
                'description' => 'Lumbini is the birth palce of Gautam BUddha',
                'visits'=>0,
                'image_path'=>'',
                'video_path'=>'',

            ],[
                'name' => 'Tilaura Kot',
                'address' => 'Kapilvastu',
                'category' => '2',
                'description' => 'Tilaurakot is nice place to visit',
                'visits'=>0,
                'image_path'=>'',
                'video_path'=>'',

            ],
        ]);
    }
}
