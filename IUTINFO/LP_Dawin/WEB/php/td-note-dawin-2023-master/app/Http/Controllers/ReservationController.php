<?php

namespace App\Http\Controllers;
use App\Models\Building;
use App\Models\User;
use App\Models\Reservation;
use Illuminate\Support\Facades\Auth;

use Illuminate\Http\Request;

class ReservationController extends Controller
{
    public function reserve(Request $request)
    {
        $validatedData = $request->validate([
            'building' => 'required|string',
            'date' => 'required|date|after:today'
        ]);
    
        $reservations = Reservation::where('building', $request->building)
                                    ->where('date', $request->date)
                                    ->count();
    
        $maxCapacity = Building::where('name', $request->building)->first()->capacity;
        if($reservations >= $maxCapacity){
            return response()->json(['error' => 'Building at maximum capacity for selected date.'], 400);
        }
    
        $reservation = new Reservation;
        $reservation->user_id = Auth::id();
        $reservation->building = $request->building;
        $reservation->date = $request->date;
        $reservation->save();
    
        return response()->json(['message' => 'Reservation successful.'], 200);
    }

    public function dashboard()
    {
        $date = Carbon::now();
        $tomorrow = Carbon::now()->addDay();
        $buildings = Building::with(['reservations' => function ($query) use ($date, $tomorrow) {
            $query->where('date', $date->toDateString())->orWhere('date', $tomorrow->toDateString());
        }])->get();
        return view('dashboard', compact('buildings'));
    }

    public function reserveView(){
        $buildings = Building::all();
        return view('reserve',compact('buildings'));
    }

    public function index()
    {
        $reservations = Reservation::all();
        return view('reservations',compact('reservations'));
    }
}
