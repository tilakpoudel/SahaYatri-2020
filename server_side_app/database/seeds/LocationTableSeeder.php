<?php

use Illuminate\Database\Seeder;

class LocationTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //
        DB::table('locations')->insert([
            [
                'name' => 'Butwal',
                'lat' => '27.6866° N',
                'lang' => '83.4323° E',
                'description' => 'Butwal is a nice city to visit'
            ],
            [
                'name' => 'Bhairawa',
                'lat' => '27.5065° N',
                'lang' => '83.4377° E',
                'description' => 'Bhairawa is a nice city to visit'
            ],
            [
                'name' => 'Lumbini',
                'lat' => '27.6792° N',
                'lang' => '83.5070° E',
                'description' => 'Lumbini  is the birthplace of LOrd Gautam Buddha a nice palce to visit'
            ],
             [
                'name' => 'Banbatika, Tilottama, Ruapndehi',
                'lat' => '27.6792° N',
                'lang' => '83.5070° E',
                'description' => 'One of the to visit location around Tilottama.'
            ], [
                'name' => 'Manimukunda Sen Park',
                'lat' => '27.6792° N',
                'lang' => '83.5070° E',
                'description' => 'Place to recreate around Butwal.'
            ],
             [
                'name' => 'Hill Park',
                'lat' => '27.6792° N',
                'lang' => '83.5070° E',
                'description' => 'Place to recreate around Butwal and get view of butwal city.',
                // $filePath = storage_path('images');
                // 'picture' => $faker->image($filePath,400,300)
            ],
        ]);
    }
}
