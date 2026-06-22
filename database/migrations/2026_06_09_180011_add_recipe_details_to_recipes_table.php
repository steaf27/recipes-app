<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
public function up(): void
{
    Schema::table('recipes', function ($table) {

        $table->longText('ingredients')->nullable();

        $table->longText('tools')->nullable();

        $table->longText('steps')->nullable();

    });
}
};
