type couleur = Pique | Coeur | Carreau | Trefle ;;

type carte =
As of couleur
| Roi of couleur
| Dame of couleur
| Valet of couleur
| Numero of int * couleur;;

let couleur_carte carte = match carte with
 As(couleur) -> couleur
| Roi(couleur) -> couleur
| Dame(couleur) -> couleur
| Valet(couleur) -> couleur
| Numero(_,couleur) -> couleur ;;

let est_de_couleur carte couleur = 
    if couleur_carte carte = couleur then true
    else false 