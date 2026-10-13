(define (domain action-castle)
   (:requirements :strips :typing)
   (:types player location direction monster item food character)

   (:action go
      :parameters (?dir - direction ?p - player ?l1 - location ?l2 - location)
      :precondition (and (at ?p ?l1) (connected ?l1 ?dir ?l2) (not (blocked ?l1 ?dir ?l2)))
      :effect (and (at ?p ?l2) (not (at ?p ?l1)))
   )

   (:action get
      :parameters (?p - player ?i - item ?l - location)
      :precondition (and (at ?p ?l) (at ?i ?l))
      :effect (and (not (at ?i ?l)) (has ?p ?i)) 
   )

   (:action drop
      :parameters (?p - player ?i - item ?l - location)
      :precondition (and (at ?p ?l) (has ?p ?i))
      :effect (and (at ?i ?l)(not (has ?p ?i)))
   )

   (:action gofish
      :parameters (?p - player ?l - location )
      :precondition (and (at ?p ?l) (has ?p fishingrod) (haslake ?l))
      :effect (and (has ?p fish))
   )

   (:action feed
      :parameters (?p - player ?f - food ?m - monster ?l - location)
      :precondition (and (at ?p ?l) (at ?m ?l) (has ?p ?f))
      :effect (and (not (has ?p ?f)) (not(hungry ?m)))
   )

   (:action give
      :parameters (?p - player ?i - item ?c - character ?l - location)
      :precondition( and(at ?p ?l) (at ?c ?l) (has ?p ?i))
      :effect (and (not(has ?p ?i)) (has ?c ?i))
   )

   (:action unlockway
      :parameters(?m - monster ?l1 - location ?d - direction ?l2 - location)
      :precondition(and (not(hungry ?m))(at ?m ?l1))
      :effect(and (not(blocked ?l1 ?d ?l2)))
   )

   (:action stun
      :parameters(?p - player ?l1 - location ?d - direction ?l2 - location ?c - character)
      :precondition(and (has ?p branch)(at ?p ?l1)(at ?c ?l1))
      :effect(and (not(blocked ?l1 ?d ?l2))(not (has ?p branch)))
   )
   
)