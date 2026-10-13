Require Import Setoid.

(* forall_e Hypothese t: introduit une nouvelle hypothèse qui est ce 
   qu'on obtient quand on applique Hypothese de la forme
   forall x:T, ...
   au terme t:T   *)
Ltac forall_e H x:= generalize (H x); intro.

(* Alternativement:
   specialize Hypothese with t
   specialize Hypotheses with (x:=t)
   specialize Hypothese with t as Ht
   specialize Hypothese with (x:=t) as Ht
   les deux premières formes remplacent l'hypothèse;
   specifier la variable à lier avec (x:=t) permet de sélectionner
   la variable x s'il y a plusieurs quantificateurs consécutifs,
   forall z y x, ...  *)

Section Universite.

(* Prenez le temps de vous familiariser avec les hypothèses, et de les
   interpréter mentalement: cela vous aidera pour vos preuves *)

Variable cours: Type.
Variable individu: Type.

Variables etudiant professeur: individu -> Prop.

Variable connait: individu -> individu -> Prop.
Variables enseigne etudie: individu -> cours -> Prop.

Variables Alice Bob Charlie Diana: individu.
Variable Anglais: cours.

Hypothesis Huniv: forall x, professeur x \/ etudiant x.
Hypothesis Hetud_prof: forall c x y, enseigne x c -> etudie y c -> connait y x.
Hypothesis cours_pas_vide: forall c, exists y, etudie y c/\ ~professeur y.
Hypothesis cours_prof: forall c, exists x, enseigne x c.
Hypothesis enseignant: forall c x, enseigne x c -> professeur x.
Hypothesis All_english: forall x, etudiant x -> etudie x Anglais.
Hypothesis Etud_se_connaissent: forall x y c, etudie x c -> etudie y c -> connait x y.

Hypothesis Ha: etudiant Alice.
Hypothesis Hb: ~ professeur Bob.
Hypothesis Hc: forall x, connait x Charlie -> professeur x.
Hypothesis Hac: connait Alice Charlie.
Hypothesis Hd: enseigne Diana Anglais.

(* Un exemple *)

Lemma Exemple: etudiant Bob.
Proof.
  forall_e Huniv Bob.
  destruct H.
  - contradiction.
  - assumption.
Qed.

(* Les exercices commencent ici *)

(* Dans chaque Lemme, remplacer "Admitted" par votre propre script de preuve.
   N'oubliez pas de terminer chaque preuve par "Qed". *)

Lemma Exercice1: connait Alice Diana.
Proof.
apply Hetud_prof with (c := Anglais).
apply Hd.
apply All_english.
apply Ha.
Qed.

Lemma Exercice2: connait Alice Bob.
Proof.
apply Etud_se_connaissent with (c := Anglais).
apply All_english.
apply Ha.
apply All_english.
apply Exemple.
Qed.

Lemma Exercice3: exists x, professeur x /\ forall y, etudiant y -> connait y x.
Proof.
exists Diana.
split.
apply enseignant with (c := Anglais).
assumption.
intros.
apply Hetud_prof with (c:= Anglais).
assumption.
apply All_english.
assumption.
Qed.

Lemma Exercice4: forall x y, professeur x \/ professeur y \/ connait x y.
Proof.
 intros x y.
  forall_e Huniv x.
  forall_e Huniv y.
  destruct H; destruct H0.
  left. assumption.
  left. assumption.
  right. left. assumption.
  right. right.
  apply Etud_se_connaissent with (c := Anglais).
  apply All_english. assumption.
  apply All_english. assumption.
Qed.

Lemma Exercice5: exists x, professeur x /\ etudiant x.
Proof.
exists Alice.
split.
apply Hc.
assumption.
assumption.
Qed.


Lemma Exercice6: forall c, ~enseigne Charlie c.
Proof.
  intros c Henseigne.
  (* Si Charlie enseigne, alors il est professeur *)
  apply enseignant in Henseigne.  (* Henseigne : professeur Charlie *)
  
  (* Alice connaît Charlie (Hac), donc par Hc, Alice est professeur *)
  assert (professeur Alice) as HprofAlice
    by (apply Hc; exact Hac).
  
  (* Mais Alice est étudiante (Ha) - contradiction *)
  contradiction.
Qed.

End Universite.

(* Fin des exercices *)
