
(*for repl without dune *)
(*
#use "mycomplex.ml"
or
#load "mycomplex.cmo"
  if file already compiled
*)

open Mycomplex

(* A point in a 2-dimensional space is represented by a complex of type mycomplex *)
let make_point x y = make_complex x y

(* A zone is represented as a function that takes a point as a parameter and returns true
   if and only if the point is in the zone, and false otherwise.
*)

(* A zone that contains every point. A point is always in this zone. *)
let everywhere = fun _ -> true

(* A zone that contains no points.  A point is never in this zone. *)
(* let nowhere = *)

let nowhere = fun _ -> false

(* point_in_zone_p (make_point 3.5 2.1) everywhere *)

(*  To determine whether a point is in a zone, just call this function. *)
let point_in_zone_p point zone = zone point

(* Create a circular zone with center in (0,0) with the indicated radius. *)
let make_disk0 radius = fun point -> c_abs point <= radius

let make_disk radius point = 
  fun p -> let translated_point = c_dif p point in 
  c_abs translated_point <= radius

(* Given a zone, move it by a vector indicated as a complex number
   passed as the argument. *)
let translate_zone zone vector = fun p -> point_in_zone_p (c_dif p vector) zone

(* Scale a zone in two dimensions *)
let scale_zone0 zone coeff = fun p -> point_in_zone_p (c_mul p coeff) zone
                                   
(* Given two zones, create a zone that behaves as the intersection of the two. *)
let zone_intersection zone1 zone2 =
  fun p -> point_in_zone_p p zone1 && point_in_zone_p p zone2

(* Test all zone_manipulating code. *)
let test = 
  let c = make_disk0 1. in
  let c1 = translate_zone c (make_point 1. 0.) in
  assert (point_in_zone_p (make_point 0.0 0.5) c);
  assert (not (point_in_zone_p (make_point 1.0 0.5) c));
  assert (point_in_zone_p (make_point 0.5 0.) (zone_intersection c c1))

(* Make a rectangle in the first quadrant. *)
let make_rectangle width height = 
  let left_edge = fun p -> realpart p >= 0. in
  let right_edge = fun p -> realpart p <= width in
  let bottom_edge = fun p -> imagpart p >= 0. in
  let top_edge = fun p -> imagpart p <= height in
  fun p -> 
    point_in_zone_p p left_edge && 
    point_in_zone_p p right_edge && 
    point_in_zone_p p bottom_edge && 
    point_in_zone_p p top_edge


(* Given two zones, create a zone that behaves as the union of the two. *)

let zone_union zone1 zone2 =
  fun p -> point_in_zone_p p zone1 || point_in_zone_p p zone2

(* Given a zone, create a zone that contains every point not in zone. *)

let zone_complement zone = fun p -> not (point_in_zone_p p zone)
 

(* Given two zones, create a zone that contains every point in zone1 except the ones that are in zone2. *)
let zone_difference zone1 zone2 = fun p -> point_in_zone_p p zone1 && not (point_in_zone_p p zone2)

(* let make_disk radius center = *)

(* point_in_zone_p (make_point 2. 2.) (make_disk 1. (make_point 1.5 1.5)) *)
  
(* Test scale_zone *)
(* point_in_zone_p (make_point 5. 5.) (scale_zone0 (make_disk0 2.) (make_point 10. 10.)) *)

let scale_zone zone coeff point = 
  fun p -> 
    let translated_point = translate p (c_opp point) in
    let scaled_point = c_mul translated_point coeff in 
    let final_point = translate scaled_point point in 
    point_in_zone_p final_point zone

(*  
let _ = point_in_zone_p (make_point 6.0 0.5) (scale_zone0 (make_disk 1. (make_point 4.0 4.0)) (make_point 6.0 4.0))
*)

(* let c_i = make_point 0. -1. *)

(* let rotate_zone0 zone angle = *)
let rotate_zone0 zone angle =
  fun p -> point_in_zone_p (rotate0 p angle) zone
    
let rotate_zone zone angle point=
    fun p -> point_in_zone_p (rotate p angle point) zone
(* point_in_zone_p (make_point 0.5 8.) (rotate_zone0 (make_rectangle 10. 2.) (3.1416 /. 2.)) *)

(* let rotate_zone zone angle center = *)

let test_make_disk0 () =
  begin
    (* Tester make_disk0 *)
    let disk0 = make_disk0 1. in
    assert (point_in_zone_p (make_point 0.0 0.5) disk0);  
    assert (not (point_in_zone_p (make_point 1.0 1.0) disk0));  
    assert (point_in_zone_p (make_point 1.0 0.0) disk0);  
  end
  let test_makedisk() =
    begin
      let disk1 = make_disk 1. (make_point 2.0 2.0) in
      assert (point_in_zone_p (make_point 2.0 2.5) disk1);  
      assert (not (point_in_zone_p (make_point 3.0 3.0) disk1));  
      assert (point_in_zone_p (make_point 2.0 3.0) disk1);  
    end
