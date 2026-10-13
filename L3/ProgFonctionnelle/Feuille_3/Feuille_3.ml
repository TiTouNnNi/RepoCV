fun x y -> (x, y);;
\\ Cette fonction est de type a, b -> a, b

let compose f g = fun x -> f (g x);;
\\ Cette fonction est de type : ( a ->b ) -> c -> a -> b
\\ Correction ( a -> b) -> (c -> a ) -> c -> b 

let rec fib n = 
    if n < 2
        then 1
    else 
        fib(n-1) + fib(n-2);;

let rec fib_aux n =
  if n = 0 then (1, 1)
  else 
    let (un_minus_1, un) = fib_aux (n - 1) in
    (un, un + un_minus_1)

let fib n = 
  let (result, _) = fib_aux (n - 1) in
  result;;

'x', 2.1, (true, 0) est de type -> ( char * float * ( boolean * int) )
3 + 2, false || 2 = 3, "bonjour" est de type -> int * boolean * string
let p = 1, 2 in sndp, fst p est de type -> (int * int)

Exercice 3.5 Pour chacun des types suivants, donner une expression ayant ce type ainsi que la valeur de
l’expression :

1/ int * bool * string
    5, true, "Mario"
2/ (int * bool) * string
    (5, false) , " Luigi "

3/ int * (bool * string)
    5, ( true, "Peach")

type couleur = Pique | Coeur | Carreau | Trefle ;;

type carte =
As of couleur
| Roi of couleur
| Dame of couleur
| Valet of couleur
| Numero of int * couleur;;

let couleur_carte carte = match carte with
 As(couleur) -> couleur
| Roi(couleur) -> couleur
| Dame(couleur) -> couleur
| Valet(couleur) -> couleur
| Numero(_,couleur) -> couleur ;;

let est_de_couleur carte couleur = 
    if couleur_carte carte = couleur then true
    else false 

type carburant = Diesel | Essence | Electrique;;

type vehicule = carburant * int;;

let make_vehicule (c:carburant) (roues:int) : vehicule = (c,roues);;

let carburant_of ( v : vehicule) :carburant = let (c,_) = v in c;;

let wheels_of ( v : vehicule) :int = let (_,wheels) = v in wheels;;

let consommation v n = 
    if carburant_of v = Electrique then (float_of_int(n) *. 0.1) *. 0.25 
    else if carburant_of v = Diesel then (float_of_int(n) *. 0.06) *. 1.5 
    else (float_of_int(n) *. 0.08 ) *. 1.5;;

type expr = 
    Var of string
    | Number of float
    | Plus of expr * expr
    | Minus of expr * expr
    | Mult of expr * expr
    | Exp of expr

let vx = Var("x");

let vy = Var("y");

let e1 = Plus(Mult(Number 2. , Var "x"), Number 1.);;

let e2 = Plus (Mult(Number 3., Mult(Var "x", Var "x")), Plus(Mult(Number 2. , Var "x"), Number 1.));;




