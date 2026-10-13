type mycomplex = C of float * float;;

let make_complex rp ip = C (rp, ip);;

let realpart i = let C (rp, _) = i in rp;;

let imagpart i = let C (_, ip) = i in ip;;

let c_sum c1 c2 = make_complex (realpart c1 +. realpart c2) (imagpart c1 +. imagpart c2);;

let c_dif c1 c2 = make_complex (realpart c1 -. realpart c2) (imagpart c1 -. imagpart c2);;

let c_mul c1 c2 = make_complex ((realpart c1 *. realpart c2) -. (imagpart c1 *. imagpart c2)) ((realpart c1 *. imagpart c2) +. (realpart c2 *. imagpart c1));;

let c_sqrt c = make_complex (sqrt (realpart c)) (sqrt (imagpart c));;

let c_opp c = let re, im = realpart c, imagpart c in make_complex (-.re) (-.im);;

let c_abs c = let re, im = realpart c, imagpart c in sqrt (re *. re +. im *. im);;

let c_sca lambda c = make_complex (realpart c *. lambda) (imagpart c *. lambda);;

let c_exp c = make_complex (exp (realpart c)) (exp (imagpart c));;

let translate vec aff = let rea,ima = realpart aff, imagpart aff in let rev,imv = realpart vec, imagpart vec in make_complex (rea+.rev) (ima +. imv);;

let rotate0 aff theta = let real, image = realpart aff, imagpart aff in make_complex ((real *. cos(theta)) -. (image *. sin(theta))) ((real *. sin(theta)) +.(image *. cos(theta)));;

let rotate aff theta center = let real, image = realpart aff, imagpart aff in make_complex ((real *. cos(theta)) -. (image *. sin(theta)) +. (realpart center)) ((real *. sin(theta)) +.(image *. cos(theta)) +. (imagpart center));;

let rotate aff theta center =
  let real, image = realpart aff, imagpart aff in 
  let real_center, image_center = realpart center, imagpart center in
  let real_rotated = ((real -. real_center) *. cos(theta)) -. ((image -. image_center) *. sin(theta)) in
  let image_rotated = ((real -. real_center) *. sin(theta)) +. ((image -. image_center) *. cos(theta)) in
  make_complex (real_rotated +. real_center) (image_rotated +. image_center);;
