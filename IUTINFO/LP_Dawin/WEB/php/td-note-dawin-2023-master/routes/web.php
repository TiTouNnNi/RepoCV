<?php

use App\Http\Controllers\{Auth\LoginController, Auth\LogoutController, BuildingsController, HomeController};
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ReservationController;

Route::middleware("guest")->group(function () {
    Route::get("/login", [LoginController::class, "index"])->name("auth.login");
    Route::post("/login", [LoginController::class, "store"]);
});

Route::middleware("auth")->group(function () {
    Route::get("/", HomeController::class)->name("index");
    Route::get("/logout", LogoutController::class)->name("auth.logout");
    Route::get('/reserve', 'App\Http\Controllers\ReservationController@reserveView')->name('reserve.view');
    Route::post('/reserve', 'App\Http\Controllers\ReservationController@reserve')->name('reserve');
    Route::get('/reservations', 'App\Http\Controllers\ReservationController@index')->name('reservations');

    // Début des routes pour la gestion des bâtiments -----
    Route::prefix("buildings")->name("buildings.")->group(function () {
        Route::get("/", [BuildingsController::class, "index"]);
        Route::get("/create", [BuildingsController::class, "create"]);
        Route::post("/create", [BuildingsController::class, "store"]);
        Route::get("/{id}", [BuildingsController::class, "show"]);
        Route::post("/{id}", [BuildingsController::class, "update"]);
        Route::get("/{id}/delete", [BuildingsController::class, "delete"]);
    });
    // Fin des routes pour la gestion des bâtiments -------
});
