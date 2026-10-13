let epsilon = 1e-06;

let derivee f h x = (f(x +. h) -. f(x -. h)) /. (2. *. h);

let rec derivee_n n f h x =
    if n = 0 then f x
    else derivee_n (n - 1) (derivee f h) h x ;;

