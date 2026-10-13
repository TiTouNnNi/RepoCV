open Ast

(* Annotation = partie du code que l'on traite*)
let apply_binop op se1 se2 ann=
  match op, se1, se2 with
  | Add, Cst_i(i1, _), Cst_i(i2, _) -> Cst_i(i1 + i2, ann)
  | Add, Cst_f(i1, _), Cst_f(i2, _) -> Cst_f(i1 +. i2, ann)
  | Add, _, _ -> failwith "Mauvais add"
  | Sub, Cst_i(i1, _), Cst_i(i2, _) -> Cst_i(i1 - i2, ann)
  | Sub, Cst_f(i1, _), Cst_f(i2, _) -> Cst_f(i1 -. i2, ann)
  | Sub, _,_ -> failwith "Mauvais Sub"
  | Mul, Cst_i(i1, _), Cst_i(i2, _) -> Cst_i(i1 * i2, ann)
  | Mul, Cst_f(i1, _), Cst_f(i2, _) -> Cst_f(i1 *. i2, ann)
  | Mul, _,_ -> failwith "Mauvais Mul"
  | Div, Cst_i(i1, _), Cst_i(i2, _) -> Cst_i(i1 / i2, ann)
  | Div, Cst_f(i1, _), Cst_f(i2, _) -> Cst_f(i1 /. i2, ann)
  | Div, _,_ -> failwith "Mauvais Div"
  | Mod, Cst_i(i1, _), Cst_i(i2, _) -> Cst_i(i1 mod i2, ann)
  | Mod, _,_ -> failwith "Mauvais mod"
  | Eq, Cst_i(i1, _), Cst_i(i2, _) -> Cst_b(i1 = i2, ann)
  | Eq, Cst_f(i1, _), Cst_f(i2, _) -> Cst_b(i1 = i2, ann)
  | Eq, Cst_b(i1, _), Cst_b(i2, _) -> Cst_b(i1 = i2, ann)
  | Eq, _,_ -> failwith "Mauvais Eq"
  | Neq, Cst_i(i1, _), Cst_i(i2, _) -> Cst_b(i1 <> i2, ann)
  | Neq, Cst_f(i1, _), Cst_f(i2, _) -> Cst_b(i1 <> i2, ann)
  | Neq, Cst_b(i1, _), Cst_b(i2, _) -> Cst_b(i1 <> i2, ann)
  | Neq, _,_ -> failwith "Mauvais Eq"
  | Lt, Cst_i(i1, _), Cst_i(i2, _) -> Cst_b(i1 < i2, ann)
  | Lt, Cst_f(i1, _), Cst_f(i2, _) -> Cst_b(i1 < i2, ann)
  | Lt, _,_ -> failwith "Mauvais Lt"
  | Leq, Cst_i(i1, _), Cst_i(i2, _) -> Cst_b(i1 <= i2, ann)
  | Leq, Cst_f(i1, _), Cst_f(i2, _) -> Cst_b(i1 <= i2, ann)
  | Leq, _,_ -> failwith "Mauvais Le"
  | Gt, Cst_i(i1, _), Cst_i(i2, _) -> Cst_b(i1 > i2, ann)
  | Gt, Cst_f(i1, _), Cst_f(i2, _) -> Cst_b(i1 > i2, ann)
  | Gt,_,_ -> failwith "Mauvais Gt"
  | Geq, Cst_i(i1, _), Cst_i(i2, _) -> Cst_b(i1 >= i2, ann)
  | Geq, Cst_f(i1, _), Cst_f(i2, _) -> Cst_b(i1 >= i2, ann)
  | Geq, _,_ -> failwith "Mauvais Geq"
  | And, Cst_b(i1, _), Cst_b(i2, _) -> Cst_b(i1 && i2, ann)
  | And, _,_ -> failwith "Mauvais And"
  | Or, Cst_b(i1, _), Cst_b(i2, _) -> Cst_b(i1 || i2, ann)
  | Or, _,_ -> failwith "Mauvais Or"
  | _ -> Binop(op, se1, se2, ann)

let rec simplify_expr expr =
  match expr with
  | Binop(op, e1, e2, ann) ->
      let se1 = simplify_expr e1 in
      let se2 = simplify_expr e2 in
      apply_binop op se1 se2 ann
  | _ -> failwith "simplify_expr"

let rec simplify_instruction instruction =
  ignore simplify_instruction;
  instruction
(*to modify*)
(*match instruction with
  | Affect (name, expr,annotation) -> instruction
  | Block (l,annotation) -> instruction
  | IfThenElse (test, i_then, i_else,annotation) -> instruction
  | While (test, body,annotation) -> instruction
  | Affect_array (name, pos, value,annotation) -> instruction
  | Array_decl (typ, name, size,annotation) -> instruction
  | Proc (name, args,annotation) -> instruction
  | Return (o,annotation) -> instruction
  | Print_str (s,annotation) -> instruction
  | Print_expr (expr,annotation) -> instruction
  | Var_decl (typ, name,annotation) -> instruction*)

let simplify_func_decl = function
  | Func_decl (typ, name, args, body, annotation) ->
      Func_decl (typ, name, args, simplify_instruction body, annotation)
