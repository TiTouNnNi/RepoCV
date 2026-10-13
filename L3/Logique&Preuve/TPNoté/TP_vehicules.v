Require Import Setoid.

(* forall_e Hypothese t: introduit une nouvelle hypothèse qui est ce 
   qu'on obtient quand on applique Hypothese de la forme
   forall x:T, ...
   au terme t:T   *)
Ltac forall_e H t := generalize (H t); intro.

(* Alternativement:
   specialize Hypothese with t
   specialize Hypotheses with (x:=t)
   specialize Hypothese with t as Ht
   specialize Hypothese with (x:=t) as Ht
   les deux premières formes remplacent l'hypothèse;
   specifier la variable à lier avec (x:=t) permet de sélectionner
   la variable x s'il y a plusieurs quantificateurs consécutifs,
   forall z y x, ...  *)

Section Vehicules.

(* Prenez le temps de vous familiariser avec les hypothèses, et de les
   interpréter mentalement: cela vous aidera pour vos preuves *)

  Variable vehicule: Type.
  
  Variable voiture: vehicule -> Prop.
  Variable velo: vehicule -> Prop.
  Variable rouge: vehicule -> Prop.
  Variable noir: vehicule -> Prop.
  Variable blanc: vehicule -> Prop.
  Variable ford: vehicule -> Prop.
  Variables totoche T: vehicule.

  Hypothesis Htot: rouge totoche.
  Hypothesis HT: ford T.
  Hypothesis Hford: forall v, ford v -> noir v.

  Hypothesis Hcouleur: forall v, rouge v \/ noir v \/ blanc v.
  Hypothesis Hrn: forall v, ~(rouge v /\ noir v).
  Hypothesis Hnb: forall v, ~(noir v /\ blanc v).
  Hypothesis Hrb: forall v, ~(rouge v /\ blanc v).

  Hypothesis Htype: forall v, voiture v \/ velo v.
  Hypothesis Hvv: forall v, ~(voiture v /\ velo v).

  Variable propulsion: Type.
  Variable categorie: vehicule -> propulsion -> Prop.
  Variable essence : propulsion.
  Variable electrique: propulsion.  
  Variable pedale: propulsion.

  Hypothesis Hve: ~(exists v, velo v /\ categorie v essence).

    
(* Un exemple *)

  Lemma Exemple: noir T.
  Proof.
    forall_e Hford T.
    apply H; assumption.
  Qed.

(* Un second exemple *)
  Lemma Exemple_bis: forall v:vehicule, ~voiture v -> velo v.
  Proof.
    intros.
    forall_e Htype v.
    destruct H0.
    - contradiction.
    - assumption.
  Qed. 

(* Les exercices commencent ici *)

(* Dans chaque Lemme, remplacer "Admitted" par votre propre script de preuve.
   N'oubliez pas de terminer chaque preuve par "Qed". *)

  Lemma Exercice1: ~ ford totoche.
  Proof.
  intro H.                  (* Suppose ford totoche *)
  forall_e Hford totoche.   (* Applique Hford à totoche *)
  apply H0 in H.            (* Obtient noir totoche *)
  assert (rouge totoche) by apply Htot. (* On sait que rouge totoche *)
  forall_e Hrn totoche. (* Applique Hrn à totoche *)
  destruct H2.
  split.     
  apply H1.
  apply H.                
  Qed.

  Lemma Exercice2: forall v:vehicule, noir v -> ~(rouge v \/ blanc v).
  Proof.
  intros v Hnoir [Hrouge | Hblanc].
  - (* Cas rouge v *)
    forall_e Hrn v.         (* Applique Hrn à v *)
    apply H.               (* Doit prouver rouge v /\ noir v *)
    split; assumption.
  - (* Cas blanc v *)
    forall_e Hnb v.         (* Applique Hnb à v *)
    apply H.               (* Doit prouver noir v /\ blanc v *)
    split; assumption.
  
  Qed.

  Lemma Exercice3: (forall v, velo v-> rouge v) -> (forall w, ford w -> voiture w).
  Proof.
  intros.
  forall_e Htype w.
  destruct H1 as [Hvoiture | Hvelo ].
  + assumption.
  + apply H in Hvelo.
  forall_e Hford w.
  apply H1 in H0.
  forall_e Hrn w.
  destruct H2.
  split.
  apply Hvelo.
  apply H0.
  Qed.

  Lemma Exercice4: ~(totoche=T).
  Proof.
  intro H.
  rewrite H in Htot.
  assert (ford T) by apply HT.
  forall_e Hford T.
  apply H1 in H0.
  forall_e Hrn T.
  apply H2.
  split.
  assumption.
  assumption.
  Qed.
    
  Lemma Exercice5: (exists v, blanc v /\ voiture v) -> exists v, voiture v /\ ~ford v.
  Proof.
  intros [v [Hblanc Hvoiture]].
  exists v.
  split.
  assumption.
  intro.
  forall_e Hford v.
  apply H0 in H.
  forall_e Hnb v.
  apply H1.
  split.
  assumption.
  assumption.
  Qed.

  Lemma Exercice6 : forall v, categorie v essence -> voiture v.
  Proof.
    intros v Hcat.
    destruct (Htype v) as [Hvoiture | Hvelo].  (* Cas sur le type de véhicule *)
    - (* Cas voiture v *) 
      assumption.
    - (* Cas velo v *)
      exfalso.  (* On cherche une contradiction *)
      apply Hve. (* On applique l'hypothèse Hve qui dit qu'aucun vélo n'a de catégorie essence *)
      exists v.  (* On montre qu'il existe un vélo avec catégorie essence *)
      split; assumption. (* Ce qui contredit Hve *)
  Qed.

End Vehicules.

(* Fin des exercices *)