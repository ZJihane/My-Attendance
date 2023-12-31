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
        Schema::create('parent_s', function (Blueprint $table) {
            $table->id('ID_Parent');
            $table->string('CIN');
            $table->string('Nom');
            $table->string('Prenom');
            $table->string('Num_Telephone');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('parent_s');
    }
};
