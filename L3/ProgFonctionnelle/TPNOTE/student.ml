(* Nom:KAHLOUL *)
(* Prénom: Aissa*)
(* Groupe: INF501A4 *)

(*** Section 1: Préléminaires ***)
(** 1- remove_duplicates récursive terminale **)
let remove_duplicates l = let rec aux doublon l2 = match l2 with | [] -> [] | head :: tail -> if List.mem head doublon then aux doublon tail else aux (head :: doublon) tail
in aux [] l;;

(* 'a list -> 'a list *)

(** 2- pairs_flatten récursive terminale **)
let pairs_flatten pairs = let rec aux acc rest = match rest with | [] -> [] | (x, y) :: tail -> aux (y :: x :: acc) tail
in aux [] pairs;;
(* ('a * 'a) list -> 'a list *)

(** 3- exists **)
let rec exists predicate l = match l with | [] -> false | head::tail -> if predicate head then true else exists predicate tail
(* ('a -> bool) -> 'a list -> bool *)

(*** Section 2: Arcs ***)
type arc = A of int * int

(** 4- constructeur/accesseurs pour type arc **)
let make_arc origin extremity = A (origin, extremity)
(* int -> int -> arc *)

let arc_origin arc = match arc with | (o, _) -> o
(* arc -> int *)

let arc_extremity arc = match arc with | (_, e) -> e
(* arc -> int *)

(** 5- reverse_arc **)
let reverse_arc arc = make_arc (arc_extremity arc) (arc_origin arc)
(* arc -> arc *)

(** 6- pair_to_arc **)
let pair_to_arc pair = match pair with | (o, e) -> make_arc o e
(* int * int -> arc *)

(** 7- arc_to_pair **)
let arc_to_pair arc = match arc with | (o, e) -> (o, e)
(* arc -> int * int *)  

(** 8- pairs_to_arcs **)
let rec pairs_to_arcs pairs = match pairs with | [] -> [] | head::tail -> make_arc (arc_origin head) (arc_extremity head) :: pairs_to_arcs tail
(* (int * int) list -> arc list *)

(** 9- arcs_to_pairs arcs **)
let rec arcs_to_pairs arcs = match arcs with | [] -> [] | head::tail -> (arc_origin head, arc_extremity head) :: arcs_to_pairs tail
(* arc list -> (int * int) list *)

(*** Section 3: Graphes ***)
type graph = { arcs : arc list; isolated_nodes : int list }
(** 10- Constructeur/accesseurs pour le type graph **)

let make_graph arcs isolated_nodes = { arcs; isolated_nodes; }
(* arc list -> int list -> graph *)
  
let graph_arcs graph = match graph with | {arcs; _;} -> arcs
(* graph -> arc list *)
    
let graph_isolated_nodes graph = match graph with | { arcs; isolated_nodes;} -> isolated_nodes
(* graph -> int list *)

(** 11- **)
let mygraph = make_graph [A (1, 2); A (1, 3); A (3, 4); A (4, 1); A (5, 6)] [7]

(** 12- Visualisation - facultatif **)
(* #use "dot.ml" *)
(* graph_view mygraph *)

(** 13- nodes_from_arcs **)
let nodes_from_arcs arcs = let jsp = (pairs_flatten (arcs_to_pairs arcs)) in remove_duplicates jsp
(* arc list -> int list *)

(** 14- graph_nodes **)
let graph_nodes graph = match graph with | {arcs; isolated_nodes} -> (nodes_from_arcs arcs) :: isolated_nodes
(* graph -> int list *)

(** 15- node_neighbours **)
let rec node_neighbours node arcs = match arcs with | [] -> [] | (x, y)::tail -> if x = node then y :: node_neighbours node tail else node_neighbours node tail
(* int -> arc list -> int list *)

(** 16- mark_from_nodes *)
let mark_from_nodes nodes arcs marked = marked :: node_neighbours nodes arcs 
(*  int list -> arc list -> int list -> int list *)

(** 17- mark_from_node **)
(* let mark_from_node node arcs = *)
(* int -> arc list -> int list *)

(** 18- unorient_arcs arcs **)
let rec unorient_arcs arcs = match arcs with | [] -> [] | (x,y)::tail -> make_arc x y :: make_arc y x :: unorient_arcs tail
(* arc list -> arc list *)

(** 19- graph_connected_p **)
let graph_connected_p graph = let unorientedgraph = unorient_arcs graph in 
(* graph -> bool *)

(** 20- graph_has_circuit **)
(* let graph_has_circuit_p graph = *)
(* graph -> bool *)
