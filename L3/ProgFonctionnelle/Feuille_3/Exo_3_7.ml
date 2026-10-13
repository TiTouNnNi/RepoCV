type carburant = Diesel | Essence | Electrique;;

type vehicule = carburant * int;;

let make_vehicule (c:carburant) (roues:int) : vehicule = (c,roues);;

let carburant_of ( v : vehicule) :carburant = let (c,_) = v in c;;

let wheels_of ( v : vehicule) :int = let (_,wheels) = v in wheels;;

let consommation v n = 
    if carburant_of v = Electrique then (float_of_int(n) *. 0.1) *. 0.25 
    else if carburant_of v = Diesel then (float_of_int(n) *. 0.06) *. 1.5 
    else (float_of_int(n) *. 0.08 ) *. 1.5;;
