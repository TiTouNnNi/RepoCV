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