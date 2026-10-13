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


