let rec interval_list n p =
  if n > p then []
  else n :: interval_list (n + 1) p

let rec map f lst =
  match lst with
  | [] -> []
  | head :: tail -> f head :: map f tail

let rec list_length lst =
  match lst with
  | [] -> 0
  | _ :: tail -> 1 + list_length tail

let rec filter pred lst =
  match lst with
  | [] -> []
  | head :: tail -> if pred head then head :: filter pred tail else filter pred tail

let rec list_of_mylist mylst =
  match mylst with
  | Nil -> []
  | C (head, tail) -> head :: list_of_mylist tail

let rec mylist_of_list lst =
  match lst with
  | [] -> Nil
  | head :: tail -> C (head, mylist_of_list tail)

let rec replicate x k =
  if k <= 0 then []
  else x :: replicate x (k - 1)

let replicate_tail x k =
  let rec aux acc n =
    if n <= 0 then acc
    else aux (x :: acc) (n - 1)
  in aux [] k

let rec reverse lst =
  match lst with
  | [] -> []
  | head :: tail -> reverse tail @ [head]

let reverse_tail lst =
  let rec aux acc = function
    | [] -> acc
    | head :: tail -> aux (head :: acc) tail
  in aux [] lst

let rec iota_r n =
  if n <= 0 then []
  else n :: iota_r (n - 1)

let iota n =
  let rec aux acc k =
    if k <= 0 then acc
    else aux (k :: acc) (k - 1)
  in List.rev (aux [] n)

let rec member x lst =
  match lst with
  | [] -> false
  | head :: tail -> head = x || member x tail

let rec count x lst =
  match lst with
  | [] -> 0
  | head :: tail -> (if head = x then 1 else 0) + count x tail
