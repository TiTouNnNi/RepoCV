<?php

namespace App\Http\Controllers;

use App\Models\Building;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;

class BuildingsController extends Controller
{
    public function index()
    {
        if(Auth::user()->is_admin){
        // retourne la vue de la liste des bâtiments
        $buildings = Building::all();
        return view("buildings.index", ["buildings" => $buildings]);
        }else{
            return redirect("/login");
        }
    }

    public function create()
    {
        if(Auth::user()->is_admin){
        // retourne la vue de création de bâtiment
        return view('buildings.form');
        }else{
            return redirect("/login");
        }
    }

    public function store(Request $request)
    {
        if(Auth::user()->is_admin){
        // valide les données reçues depuis le formulaire de création
        $validatedData = $request->validate([
            'name' => 'required|string',
            'capacity' => 'required|integer',
        ]);

        $building = new Building;
        $building->name = $validatedData["name"];
        $building->capacity = $validatedData["capacity"];
        $building->save();        
        // redirige vers la page de détails du bâtiment
        return redirect("/buildings");
        }else{
            return redirect("/login");
        }
    }

    public function show($id)
    {
        if(Auth::user()->is_admin){
        // trouve le bâtiment correspondant à l'ID
        $building = Building::findOrFail($id);

        // retourne la vue de détails du bâtiment
        return view("buildings.form", [
            'building' => $building,
        ]);
        }else{
            return redirect("/login");
        }
    }

    public function update(Request $request, $id)
    {
        if(Auth::user()->is_admin){
        // trouve le bâtiment correspondant à l'ID
        $building = Building::findOrFail($id);

        // valide les données reçues depuis le formulaire de modification
        $validatedData = $request->validate([
            'name' => 'required|string',
            'capacity' => 'required|integer',
        ]);

        // met à jour le bâtiment avec les données validées
        $building->update($validatedData);

        // redirige vers la page de détails du bâtiment
        return redirect("/buildings");

        }else{
            return redirect("/login");
        }
    }

    public function delete($id)
    {
        if(Auth::user()->is_admin){
            // trouve le bâtiment correspondant à l'ID
            $building = Building::findOrFail($id);

            // supprime le bâtiment
            $building->delete();

            // redirige vers la page de liste des bâtiments
            return redirect("/buildings");
        }
        else{
            return redirect("/login");
        }
    }
}