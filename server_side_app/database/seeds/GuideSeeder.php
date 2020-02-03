<?php

use Illuminate\Database\Seeder;

class GuideSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //
        DB::table('guides')->insert([
            [
                'name' => 'Hari Thapa',
                'address' => 'Butwal',
                'contact_no' => '9800000000',
                'email' => 'hari@gmail.com',
                'national_id_no'=>'25-41-1457',
                'national_id_issue_district'=>'Rupandehi',
                'image_path'=>'',
                'booked_number'=>1,
                'status'=>'0',//status 0 = not availabel , 1 = free , 2 = booked

            ],
            [
                'name' => 'Ram khadka',
                'address' => 'Kathmandu',
                'contact_no' => '9800001111',
                'email' => 'ram@gmail.com',
                'national_id_no'=>'25-41-1157',
                'national_id_issue_district'=>'Kapilvastu',
                'image_path'=>'',
                'booked_number'=>2,
                'status'=>'1',//status 0 = not availabel , 1 = free , 2 = booked

            ],[
                'name' => 'Geeta',
                'address' => 'Pokhara',
                'contact_no' => '9800000000',
                'email' => 'geeta@gmail.com',
                'national_id_no'=>'25-41-5857',
                'national_id_issue_district'=>'Kaski',
                'image_path'=>'',
                'status'=>'2',//status 0 = not availabel , 1 = free , 2 = booked
                'booked_number'=>2
            ],
        ]);
    }
}
