let rec seq_aux n = 
    if n = 0 then ( 0 , 1)
    else let (un_1, un) = seq_aux (n - 1) in  (* Récursivement calcule (un-1, un) *)
    (un, -un + 2 * un_1)  (* Calcule (un, un+1) en fonction de (un-1, un) *);;