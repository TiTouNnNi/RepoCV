type date = { day : int; month : int; year : int }

let today = { day = 4; month = 11; year = 2024 }

let date_infeg date1 date2 =
  if date1.year < date2.year then true
  else if date1.year > date2.year then false
  else if date1.month < date2.month then true
  else if date1.month > date2.month then false
  else date1.day <= date2.day

type 'a mylist = Nil | C of 'a * 'a mylist

let rec mylist_length = function
  | Nil -> 0
  | C (_, tail) -> 1 + mylist_length tail

let rec interval_list n p =
  if n > p then Nil
  else C (n, interval_list (n + 1) p)

let rec map f = function
  | Nil -> Nil
  | C (head, tail) -> C (f head, map f tail)

let rec filter pred = function
  | Nil -> Nil
  | C (head, tail) -> if pred head then C (head, filter pred tail) else filter pred tail

type peano = Zero | Succ of peano

let rec peano_add m n =
  match m with
  | Zero -> n
  | Succ m' -> Succ (peano_add m' n)

let rec peano_mult m n =
  match m with
  | Zero -> Zero
  | Succ m' -> peano_add n (peano_mult m' n)

let rec peano_of_int n =
  if n <= 0 then Zero else Succ (peano_of_int (n - 1))

let rec int_of_peano = function
  | Zero -> 0
  | Succ p -> 1 + int_of_peano p

let factorial n =
  let rec aux acc n =
    if n <= 1 then acc
    else aux (acc * n) (n - 1)
  in aux 1 n

let sum n p =
  let rec aux acc n =
    if n > p then acc
    else aux (acc + n) (n + 1)
  in aux 0 n

let mylist_length_tail lst =
  let rec aux acc = function
    | Nil -> acc
    | C (_, tail) -> aux (acc + 1) tail
  in aux 0 lst

let interval_list_tail n p =
  let rec aux acc current =
    if current < n then acc
    else aux (C (current, acc)) (current - 1)
  in if n > p then Nil else aux Nil p
