<?php

use Illuminate\Database\Seeder;

class CategorySeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //
        DB::table('categories')->insert([
            [
                'name' => 'Adventure',
                'category_image' => '',
                'status'=>'1',
            ],
            [
                'category_image' => '',
                'name' => 'Historical',
                'status'=>'1',
            ],[
                'category_image' => '',
                'name' => 'Religious',
                'status'=>'1',
            ],[
                'category_image' => '',
                'name' => 'Nature',
                'status'=>'1',
            ],
        ]);
    }
}
