Ltac forall_e H t := (generalize (H t); intro).

Require Import Setoid.


Section Gaulois.
  Variable personnage: Set.
  Variables humain gaulois romain animal: personnage -> Prop.
  Variables Idefix Panoramix: personnage.

  Hypothesis Hngr: forall p:personnage, ~(gaulois p /\ romain p).
  Hypothesis Hpers: forall p:personnage, animal p \/ gaulois p \/ romain p.
  Hypothesis Hhum: forall p:personnage, humain p <-> (gaulois p \/ romain p).
  Hypothesis Hnon_humain_animal:
    forall p:personnage, ~(humain p /\ animal p).

  Hypothesis Hidef: animal Idefix.
  Hypothesis Hpano: gaulois Panoramix.
  Hypothesis Hrom: exists p:personnage, romain p.

  Theorem Exemple: exists x:personnage, humain x /\ ~gaulois x.
  Proof.
    destruct Hrom as [y Hy].
    exists y.
    split.
    - rewrite Hhum.
      right.
      assumption.
    - forall_e Hngr y.
      intro Hgy.
      apply H.
      split.
      + assumption.
      + assumption.
  Qed.

(* Dans les 5 théorèmes ci-dessous, remplacez "Admitted." par un 
   script de preuve complet, que vous terminerez par "Qed."

   Barème indicatif: pour chaque théorème, 3.5 points pour un
   script qui prouve le théorème sans rien admetter; 0.5 point 
   supplémentaire si la preuve est structurée de manière à 
   permettre de la suivre sans interagir avec Coq (prendre exemple
   sur la preuve précédente).

   *)
  
  Theorem Exercice1: ~ gaulois Idefix.
  Proof.
  intro.
  apply Hnon_humain_animal with (p :=Idefix).
  split.
  rewrite Hhum.
  left.
  assumption.
  assumption.
  Qed.

  Theorem Exercice2:
    forall p:personnage, humain p -> ~romain p -> gaulois p.
  Proof.
  intros.
  rewrite Hhum in H.
  destruct H as [H1 | H2].
  assumption.
  contradiction.
Qed.

  Theorem Exercice3:
    exists p:personnage, humain p /\ ~gaulois p.
  Proof.
  destruct Hrom.
  exists x.
  split.
  apply Hhum.
  right.
  assumption.
  intro.
  apply Hngr with x.
  split.
  assumption.
  assumption.
  Qed.

  Theorem Exercice4:
    forall p, ~animal p -> gaulois p \/ romain p.
  Proof.
  intros.
  destruct (Hpers p).
  contradiction.
  assumption.
  Qed.

  Theorem Exercice5: Idefix <> Panoramix.
  Proof.
    (* Indication: on peut utiliser n'importe quel théorème, 
       y compris un qui a été prouvé comme exercice *)
  intro.
  (* subst Panoramix ( Remplace Panoramix par Idefix partout ) *)
  rewrite <- H in Hpano.
  apply Exercice1.
  assumption.
  Qed.

End Gaulois.