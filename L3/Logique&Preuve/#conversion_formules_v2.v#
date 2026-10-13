Require Import List.

(* Un exemple de mini développement Coq, pour montrer trois choses:
   - la similarité avec Ocaml pour l'écriture de programmes purement fonctionnels
   - l'écriture de spécifications précises pour un programme
   - le fait qu'on peut prouver que le programme respecte la spécification écrite *)

(* Chaque commande Theorem, Lemma ou Example énonce une propriété, elle est alors suivie
   par un bloc qui commence par Proof et qui se termine par Qed: ce bloc est un 'script
   de preuve'. *)

(* N'essayez pas de comprendre comment fonctionnent ces scripts de preuves; le but est 
   seulement de montrer qu'il est possible, dans le même système Coq, d'à la fois écrire
   des fonctions (des programmes) et prouver des théorèmes sur ces fonctions.

   Comme la plupart des fonctions sont récursives, il n'est pas surprenant que la plupart
   des preuves soient par induction (tactique induction dans les scripts de preuve) *)

(* Tous les _programmes_ et types ci-dessous ont des équivalents simples dans le langage
   Ocaml. Les théorèmes, eux, n'ont pas d'équivalents: Ocaml est seulement un langage de
   programmation. *)

(* Dans ce fichier, on va formaliser un certain nombre de notions présentées dans le
   chapitre sur la logique propositionnelle usuelle, et à chaque fois, prouver en Coq les
   théorèmes du cours. *)

(* On commence par poser la base: la notion de formule propositionnelle, en définissant
   un type formule. À ce stade, les choses ont un équivalent naturel dans le langage Ocaml *)

(* Un petit ensemble de variables *)
Inductive var := 
| P: var
| Q: var
| R: var
| S: var
| T: var
.
(* Version Ocaml: type var = P | Q | R | S | T;; *)

(* Définition inductive: le type des formules *)
Inductive formula := 
| At (v: var) : formula
| Non (f: formula) : formula
| Et (f1 f2: formula) : formula
| Ou (f1 f2: formula) : formula
| Implique (f1 f2: formula) : formula
| NonEt (f1 f2: formula) : formula
.
(* Version Ocaml:
  type formula =
  | At of var
  | Non of formula
  | Et of formula * formula
  | Ou of formula * formula
  | Implique of formula * formula
  | NonEt of formula * formula
*)

Coercion At: var >-> formula.
Notation "'~ A" := (Non A) (at level 75).
Notation "A '/\ B" := (Et A B) (at level 80, right associativity).
Notation "A '\/ B" := (Ou A B) (at level 85, right associativity).
Notation "A '-> B" := (Implique A B) (at level 90, right associativity).

(* Quelques exemples de formules *)
(* La formule P->(P/\Q) *)
Definition p_pq := P '-> (P '/\ Q).
Print p_pq.
(* Version Ocaml: Implique( (At P), Et( (At Q), (At P))) *)

(* La formule de Peirce *)
Definition peirce := ((P '-> Q) '-> P) '-> P.
(* Version Ocaml: let peirce = Implique (Implique(Implique((At P),(At Q)),(At P)),(At P)) *)

(* Notion de valuation: fonction des variables vers les booléens *)
Definition valuation := (var -> bool).

(* Quelques exemples de valuations *)
Definition alltrue : valuation := fun _ => true. (* tout à vrai *)
Definition allfalse : valuation := fun _ => false. (* tout à faux *)
(* Versions Ocaml: alltrue : valuation := fun _ -> true
                   allfalse : valuation := fun _ -> false *)

(* Un autre exemple de valuation: P et Q à vrai, les autres à faux *)
Definition v1 : valuation := fun x => 
  match x with
  | P => true
  | Q => true
  | _ => false
end.

(* Extension de la notion de valuation à une formule 
   La version etendue de va, c'est (evalue va) *)
(* Fixpoint, c'est la version Coq de let rec *)
Fixpoint evalue (va: valuation) (f: formula) : bool := 
match f with
| At v => va v
| Non f => negb (evalue va f)
| Et f1 f2 => andb (evalue va f1) (evalue va f2)
| Ou f1 f2 => orb (evalue va f1) (evalue va f2)
| Implique f1 f2 => implb (evalue va f1) (evalue va f2)
| NonEt f1 f2 => negb (andb (evalue va f1) (evalue va f2))
end.
(* On ecrit explicitement un cas recursif pour chaque constructeur *)
(* Remarque: c'est à cet endroit du code qu'on décrit les tables de vérité associées 
   aux différents connecteurs *)

(* Prédicat sur les formules: n'utilise que le connecteur NAND *)
Inductive only_nand : formula -> Prop :=
| Atomic (v: var): only_nand (At v)
| Nand_root (f1 f2: formula): only_nand f1 -> only_nand f2 -> only_nand (NonEt f1 f2)
.
(* Pas de version équivalente simple en Ocaml qui n'a pas d'équivalent de Prop *)

(* Version booléenne: une fonction qui retourne true si le prédicat précédent est vrai *)
Fixpoint only_nandb (f:formula) : bool :=
match f with
| At _ => true
| Non _ => false
| Et _ _ => false
| Ou _ _ => false
| Implique _ _ => false
| NonEt f1 f2 => andb (only_nandb f1) (only_nandb f2)
end.
(* Là il y a une version Ocaml:
let rec all_nandb f = match f with
| At _ -> true
| Non _ -> false
| Et (_,_) -> false
| Ou (_,_) -> false
| Implique (_,_) ->  false
| NonEt (f1, f2) -> (all_nandb f1) && (all_nandb f2)
*)

(* Les versions booléenne et propositionnelle sont équivalentes (on ne s'en servira
   pas, mais c'est une bonne idée de le vérifier) *)
Theorem nandb_eq_nand: forall (f:formula), only_nand f <-> only_nandb f = true.
Proof.
split.
- intro H. induction H.
  + reflexivity.
  + simpl. rewrite IHonly_nand1, IHonly_nand2. reflexivity.
- induction f.
  { intro H; constructor. }
  all: try (intro H; simpl in H; discriminate).
  simpl. intro H.
  apply andb_prop in H as [H1 H2].
  constructor.
  + apply IHf1; assumption.
  + apply IHf2; assumption.
Qed.

(* Equivalence extensionnelle de deux formules:
   toute valuation évalue les deux
   formules en le même booléen *)
Definition equiv (f1 f2: formula) := forall v: valuation, evalue v f1 = evalue v f2.
(* Pas d'équivalent en Ocaml: c'est une proposition *)

(* Un exemple d'équivalence: entre P->Q et (~P \/ Q) *)
Example e0: equiv (P '-> Q) 
                  ('~ P '\/ Q).
Proof.
intro v.
unfold evalue.
case (v Q); case (v P).
all: reflexivity.
Qed.

(* Toute formule est equivalente a elle-même *)
Lemma equiv_self: forall f, equiv f f.
Proof.
intros f v. reflexivity.
Qed.

(* L'équivalence est une relation symétrique *)
Lemma equiv_sym: forall f g, equiv f g -> equiv g f.
Proof.
unfold equiv. intros f g Hfg v.
rewrite Hfg. reflexivity.
Qed.

(* L'équivalence est transitive *)
Lemma equiv_trans: forall  f g h, equiv f g -> equiv g h -> equiv f h.
Proof.
intros f g h Hfg Hgh v.
rewrite Hfg.
rewrite Hgh.
reflexivity.
Qed.

(* Prédicat sur les formules: être tautologique *)
Definition tautologie (f: formula) := forall v: valuation, evalue v f = true.

Example e1: tautologie (P '-> P).
Proof.
intro v.
unfold evalue.
apply Bool.implb_same.
Qed.


Example e2: tautologie peirce.
Proof.
intro v.
unfold peirce, evalue.
case (v P); case (v Q); reflexivity.
Qed.

Section Conversion.
(* Dans cette section, on formalise une partie de l'exercice 7. Dans cet exercice,
   on était censé prouver "sur le papier" que toute formule est équivalente à une
   formule où le seul connecteur est le connecteur NAND (NonEt dans notre définition).

   La preuve de l'exercice est constructive: on décrit une façon systématique de trouver
   la formule, c'est-à-dire qu'on écrit une fonction qui prend en entrée une formule
   propositionnelle quelconque f, et qui retourne une formule propositionnelle f' qui 
   a les deux propriétés: f' n'utilise que NAND comme connecteur, et f' est équivalente
   à f. *)

(* On procède en trois temps: on va 
  - définir une fonction de conversion d'une formule en une autre
    (une fonction de type formula -> formula)
  - écrire une spécification pour cette fonction
    (formaliser la propriété que notre fonction est censée satisfaire)
  - prouver que la fonction qu'on a écrite respecte cette spécification
*)

(* La fonction de conversion: on a une clause par constructeur de formule *)
Fixpoint conversion (f: formula) : formula := 
match f with
| At _ => f
| Non f' => NonEt (conversion f') (conversion f')
| Et f1 f2 => NonEt (NonEt (conversion f1) (conversion f2)) 
                    (NonEt (conversion f1) (conversion f2))
| Ou f1 f2 => NonEt (NonEt (conversion f1) (conversion f1))
                    (NonEt (conversion f2) (conversion f2))
| Implique f1 f2 => NonEt (conversion f1) (NonEt (conversion f2) (conversion f2))
| NonEt f1 f2 => NonEt (conversion f1) (conversion f2)
end.
(* On a une solution pour se débarrasser de chaque connecteur autre que NonEt, 
   et on l'utilise, en utilisant des appels récursifs pour les sous-formules *)
(* Il est très simple d'écrire une fonction équivalente en Ocaml; le contenu des
   différentes clauses fait l'objet d'un exercice de la feuille de TD *)

(* La spécification (ce que doit satisfaire la fonction de conversion): la formule produite
   doit n'utiliser que NAND comme connecteur, et
   être équivalente à la formule de départ, et ce, pour toute formule en entree *)
Definition conversion_spec (transfo: formula -> formula) :=
  forall (f:formula), equiv (transfo f) f /\ only_nand (transfo f). 

(* À ce stade, l'objectif est de prouver: conversion_spec conversion *)

(* La première partie: l'équivalence; par induction sur la formule à convertir *)
Lemma conv_equiv: forall (f:formula), equiv (conversion f) f.
Proof.
intros f v.
induction f as [| f IHf| f1 IHf1 f2 IHf2 | f1 IHf1 f2 IHf2
                | f1 IHf1 f2 IHf2| f1 IHf1 f2 IHf2].
{ reflexivity. } 
{ simpl; rewrite IHf; case (evalue v f); reflexivity. } 
all: simpl; rewrite IHf1; rewrite IHf2; case (evalue v f1); case (evalue v f2); reflexivity.
Qed.

(* La deuxième partie: la formule obtenue n'utilise que le connecteur NonEt *)
Lemma conv_only_nand: forall (f: formula), only_nand (conversion f).
Proof.
intros f.
induction f.
{ simpl. apply Atomic. }
{ simpl. apply Nand_root. assumption. assumption. }
{ simpl; apply Nand_root. apply Nand_root. assumption. assumption. 
         apply Nand_root. assumption. assumption. } 
{ simpl. apply Nand_root. apply Nand_root. assumption. assumption.
         apply Nand_root. assumption. assumption. } 
{ simpl. apply Nand_root. assumption.
         apply Nand_root. assumption. assumption. }
{ simpl. apply Nand_root. assumption. assumption. }
Restart. (* on peut écrire une autre preuve, beaucoup plus compacte *)
intros f; induction f; simpl; repeat constructor; assumption.
Qed.

(* Le théorème principal *)
Theorem conversion_correct: conversion_spec conversion.
Proof.
unfold conversion_spec.
intro f.
split.
- apply conv_equiv.
- apply conv_only_nand.
Qed.

Theorem conversion_nand: 
   forall (f:formula), exists (f': formula), equiv f' f /\ only_nand f'.
Proof.
intros f. exists (conversion f). 
apply conversion_correct.
Qed.

End Conversion.

(* Bonus: on développe la notion de substitution (uniforme) *)
Section Substitutions.

(* On a besoin d'une fonction booléenne qui teste l'égalité de deux variables *)
Definition eqv (v1 v2: var) : bool := match v1,v2 with
| P, P => true
| Q, Q => true
| R, R => true
| S, S => true
| T, T => true
| _,_ => false
end.

(* On prouve qu'elle est correcte : eqv v1 v2 = true si et seulement si v1=v2 *)
Lemma eqv_correct: forall v1 v2, eqv v1 v2 = true <-> v1=v2.
Proof.
intros v1 v2; split.
- case v1; case v2.
  all: simpl; intro H; try reflexivity; try discriminate H.
- intro H; rewrite H; case v2; reflexivity.
Qed.

(* Définition de la fonction de substitution: étant donnés v, g et f, on
   calcule la formule f[v/g] *)
Fixpoint substitution (v: var) (g: formula) (f: formula):= 
match f with
| At v' => if eqv v v' then g else f
| Non f' => Non (substitution v g f')
| Et f1 f2 => Et (substitution v g f1) (substitution v g f2)
| Ou f1 f2 => Ou (substitution v g f1) (substitution v g f2)
| Implique f1 f2 => Implique (substitution v g f1) (substitution v g f2)
| NonEt f1 f2 => NonEt (substitution v g f1) (substitution v g f2)
end.
(* Il y a un équivalent Ocaml facile *)

(* théorème d'équivalence: si on effectue, dans une même formule, deux
   substitutions par des formules équivalentes, on obtient deux formules équivalentes *)
Theorem eq_subst_right: forall f v g1 g2, 
  equiv g1 g2 -> equiv (substitution v g1 f) (substitution v g2 f).
Proof.
intros f v g1 g2 Hg1g2. revert f.
induction f.
{ simpl. case (eqv v v0). assumption. apply equiv_self. }
{ intro va. simpl. rewrite IHf. reflexivity. }
all: intro va; simpl; rewrite IHf1; rewrite IHf2; reflexivity.
Qed.

(* Second théorème d'équivalence: si on effectue la _même_ substitution dans deux
   formules équivalentes, on obtient aussi deux formules équivalentes *)

(* On ne peut pas procéder par induction à la fois sur les deux formules, donc il faut
   trouver un autre argument. On va décrire le résultat de l'évaluation de A[x/B] comme
   celui de l'évaluation de A pour une _autre_ valuation que v. *)

(* La valeur sous valuation v de A[x/B], c'est la valeur de A 
   sous une autre valuation v'. Définissons cette valuation v': c'est celle qui donne
   comme valeur à x, le résultat de l'évaluation sous v de B (et laisse inchangée la 
   valeur des autres variables). *)

Definition valsubst (v: valuation) (x:var) (B: formula) : valuation := fun y =>
  if eqv x y then evalue v B else v y.

(* Et montrons ce lien entre évaluation de A sous v', et evaluation de (A susbsituée)
   sous v. *)
Lemma eval_subst: forall v x B A, 
  evalue v (substitution x B A) = evalue (valsubst v x B) A.
Proof.
intros v x B A. 
induction A.
{ simpl. case_eq (eqv x v0).
  - intro H. unfold valsubst. rewrite H. reflexivity.
  - intro H. unfold valsubst. rewrite H. reflexivity. }
{ simpl. rewrite IHA. reflexivity. } 
all: simpl; rewrite IHA1; rewrite IHA2; reflexivity.
Qed.

(* Une fois connu ce lemme, le second théorème d'équivalence ne nécessite même pas
   d'induction. *)
Theorem eq_subst_left: forall f1 f2 v g, 
  equiv f1 f2 -> equiv (substitution v g f1) (substitution v g f2).
Proof.
intros f1 f2 v g H va.
repeat rewrite eval_subst.
apply H.
Qed.

End Substitutions.


Section Substitutions2.
(* Notre notion de substitution n'est pas totalement satisfaisante: on ne peut pas
   faire de substitution simultanée sur plus d'une variable.

   On redéfinit la notion pour prévoir des substitutions simultanées sur chaque
   variable. *)

(* Une substitution, c'est une fonction qui associe une formule à chaque variable *)
Definition sub:= var -> formula.

(* Un peu comme une valuation: on l'étend en une fonction des formules vers les formules *)
Fixpoint substitue (s: sub) (f: formula) : formula := 
match f with
| At v => s v
| Non f' => Non (substitue s f')
| Et f1 f2 => Et (substitue s f1) (substitue s f2)
| Ou f1 f2 => Ou (substitue s f1) (substitue s f2)
| Implique f1 f2 => Implique (substitue s f1) (substitue s f2)
| NonEt f1 f2 => NonEt (substitue s f1) (substitue s f2)
end.

(* On retrouve la première notion de substitution comme cas particulier *)
Definition sub_unique (x:var) (A: formula) : sub := fun (y:var) => 
  if eqv x y then A else (At y)
.

(* C'est bien de dire que c'est un cas particulier, mais c'est mieux de le prouver *)
Lemma sub_eq_sub: forall (x:var) (A B: formula),
  substitue (sub_unique x A) B = substitution x A B.
Proof.
intros x A B. induction B.
{ simpl. unfold sub_unique. reflexivity. }
{ simpl. rewrite IHB. reflexivity. }
all: simpl; rewrite IHB1; rewrite IHB2; reflexivity.
Qed.

(* Comme on est plus général, on est obligé de reprouver les deux théorèmes 
   de substitution *)

(* On commence par le second *)

(* Il nous faut une nouvelle version de valsubst *)
Definition valsubst' (v: valuation) (s: sub): valuation := fun (x: var) => 
  evalue v (s x).

Lemma eval_subst': forall (v:valuation) (s: sub) (f: formula), 
  evalue v (substitue s f) = evalue (valsubst' v s) f.
Proof.
intros v s f. induction f.
{ simpl. unfold valsubst'. reflexivity. }
{ simpl. rewrite IHf. reflexivity. } 
all: simpl; rewrite IHf1; rewrite IHf2; reflexivity.
Qed.

Theorem eq_subst_right_bis: forall (s: sub) (f1 f2: formula), 
  equiv f1 f2 -> equiv (substitue s f1) (substitue s f2).
Proof.
intros s f1 f2 H va.
repeat rewrite eval_subst'.
apply H.
Qed.

(* Le premier théorème de substitution est plus compliqué, non pas à démontrer, 
   mais à formuler! L'hypothèse est que, pour chaque variable, les deux fonctions
   de substitution donnent des formules équivalentes *)
Theorem eq_subst_left_bis: forall (s1 s2: sub) (f:formula),
  (forall x:var, equiv (s1 x) (s2 x)) -> equiv (substitue s1 f) (substitue s2 f).
Proof.
intros s1 s2 f H va. unfold equiv in H.
induction f.
{ simpl. rewrite H. reflexivity. } 
{ simpl. rewrite IHf. reflexivity. }
all: simpl; rewrite IHf1; rewrite IHf2; reflexivity.
Qed.

End Substitutions2.

Section Remplacement.
(* Bonus 2: la notion de remplacement. *)

(* On veut montrer le théorème suivant: si deux formules f1 et f2 sont équivalentes, 
   alors pour toute formule A et toute formule B qui peut être obtenue en remplaçant
   dans A, certaines occurrences de f1 comme sous-formule (mais pas forcément toutes),
   est équivalente à A. *)

(* La difficulté est que cette opération de remplacement n'est pas déterministe: il y
   a plusieurs façons de la faire, on ne peut donc pas décrire ça par une fonction; il va
   falloir passer par une relation. *)

(* Dans cette définition, f1 et f2 sont des paramètres fixes; "remplacement f1 f2 A B"
   est la propriété que, en remplaçant un nombre quelconque d'occurrences de f1 dans A
   par des f2, on peut obtenir B. *)
Inductive remplacement (f1 f2: formula): formula -> formula -> Prop :=
| Egales: forall A, remplacement f1 f2 A A (* Cas trivial: A = B *)
| Base: remplacement f1 f2 f1 f2 (* Second cas de base: A=f1, B=f2 *)
(* Puis tous les cas correspondant à des connecteurs: si A et B ont le même connecteur
   principal et que leurs sous-formules sont en relation de remplacement, alors c'est le
   cas de A et B *) 
| Ind_not: forall f f', remplacement f1 f2 f f' -> remplacement f1 f2 (Non f) (Non f')
| Ind_et: forall f f' g g', remplacement f1 f2 f f' -> remplacement f1 f2 g g' -> 
    remplacement f1 f2 (Et f g) (Et f' g')
| Ind_ou: forall f f' g g', remplacement f1 f2 f f' -> remplacement f1 f2 g g' -> 
    remplacement f1 f2 (Ou f g) (Ou f' g')
| Ind_implique: forall f f' g g', remplacement f1 f2 f f' -> remplacement f1 f2 g g' -> 
    remplacement f1 f2 (Implique f g) (Implique f' g')
| Ind_NonEt: forall f f' g g', remplacement f1 f2 f f' -> remplacement f1 f2 g g' -> 
    remplacement f1 f2 (NonEt f g) (NonEt f' g')
.
(* Ici on a le droit d'avoir un petit instant de doute: est-ce que la définition
   ci-dessus couvre bien tous les cas possibles? *)

(* En tout cas, pour la relation qu'on a définie, le théorème est correct *)
Theorem remplacement_equiv: forall A B F G, equiv A B -> remplacement A B F G -> equiv F G.
Proof.
intros a b f g Hab Hr.
induction Hr.
 { apply equiv_self. }
 { assumption. }
 { intro v; simpl; unfold equiv in IHHr; rewrite IHHr; reflexivity. }
all: intro v; simpl; unfold equiv in *; rewrite IHHr1, IHHr2; reflexivity.
Qed.

End Remplacement.