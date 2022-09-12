<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateProductsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('products', function (Blueprint $table) {
            $table->id();            
            $table->string('product_id');
            $table->string('productName');
            $table->integer('item_id');
            $table->integer('brand_id');
            $table->string('serialNumber');
            $table->string('attribute');
            $table->integer('user_id');
            $table->string('purcessDate');
            $table->boolean('warranty');
            $table->string('warrantyDetails');
            $table->integer('productStatus');
            $table->integer('assignStatus');
            $table->integer('deletionStatus');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('products');
    }
}
