# 4TST903U - Science des données et des réseaux

## Séance S42 Projection et filtrage

Borgatti, S. P., et al. (2009). "Network Analysis in the Social Sciences." Science 323(5916): 892-895,

identifie quatre types de relation qui donne lieu à des réseaux:

- des liens sociaux, c’est-à-dire familiaux, d’amitiés (réelles), des connaissances, etc.
- des interactions (des « contacts », rencontres effectives, appels téléphoniques, etc.)
- des similarités (même intérêts ou affinités, observé via des co-participation, etc.)
- des flux (d’information, de ressources financières ou autres, etc.)

<img src="./Borgatti_2009.png" width="80%">

Parmi ces types nous alons nous intéressser aux graphes induits de similarités.

### Graphes bipartis

Considérez l'exemple d'un graphe qui décrit la participation de personnes à des évènements, dont les arêtes sont précisément des couples $(p, e)$ où $p$ est une personne et $e$ est un évènement. Ce graphe a une particularité: aucune arête ne lien deux personnes directement, idem pour les évènements.

On dit alors que ce graphe est *biparti* -- on parle aussi de ***graphe 2_mode***. Ses sommets sont la somme de deux ensembles distincts $V = V_1 \oplus V_2$ et ses arêtes sont un sous-ensemble de $V_1 \times V_2$.

***Proposition***. Un graphe est biparti si et seulement si il ne contient pas de cycle de longueur impaire.

En effet, un cycle de longueur impaire impliquerait l'existence d'une arête entre deux sommets de $V_1$ ou de $V_2$. A l'inverse, dans un graphe qui ne contient pas de cycle de longueur impaire, on peut définir deux ensembles $V_1$ et $V_2$ comme suit:

```
on initialise $V_1$ avec un premier sommet u, que l'on marque comme étant "visité"
on insère u dans une file (ou une pile)


tant que la file (pile) n'est pas vide
soit v un sommet obtenu de la file (et qui en est extrait)
- si v appartient à V1 (resp V2),
 - on place les voisins non marqués de v dans V2 (resp V1)
 - et on les insere dans la file
```

Ce processus est bien défini. On ne rencontre jamais de cas où sommet serait placé dans le même ensemble que ses voisins puisqu'alors on aurait mis la main sur un cycle de longueur impaire.

----

Donné une graphe biparti, les centralités vues aux séabces précédentes ne se prêtent pas aux graphes bipartis. Le caractère biparti du graphe impacte les notion sde centralités, dès lors qu'on est intéressé à interpréter les lienss entre sommets d'un même type -- tout simplement parce qu'il n'y a aucune arête entre sommets d'un même type (!).

### Projection

Donné un graphe biparti, avec $V = V_1 \oplus V_2$, on peut calculer sa projection en un graphe 1-mode sur l'ensemble $V_1$ (ou $V_2$). Plus précisément, à partir de $G = (V_1 \oplus V_2, E)$ on construit un autre graphe $H = (V_1, E')$ où deux sommets $u_1, v_1 \in V_1$ sont liés si et seulement il existe au moins un sommet $w_2 \in V_2$ et deux arêtes $(u_1, w_2), (w_2, v_1) \in E$ dans $G$.

- Densité des graphes projetés
- Cardinalité des arêtes - comptage des sommets $w_2 \ V_2$ donnant lieu à une arête $(u_1, v_1)$
- Seuillage des arêtes du graphe
- Poids de Giatsidis $\omega(e) = \sum_{w \in V_2, u \in N_G(w)} \frac{1}{\deg_G(w)}$


Désavantage des approches "seuillage par poids", appliqué de manière uniforme sur tout le graphe.

Approche de Zachary Neal. Calcul de la probabilité que deux acteurs participants resp à $P_i$ et $P_j$ évènememnts, aient participé à $C$ évènements en commun (parmi $E$ évènements au total).

$P(P_i \cap P_J = C) = \frac{{E \choose C}{E-C \choose P_i - C}{E-P_i \choose P_i - C}}{{E \choose P_i}{E \choose P_j}}$

Les valeurs $E, P_i$ et $P_j$ étant fixées, cette probabilité varie en fonction de la valeur du paramètre $C$, où $0 \leq C \leq \min(P_i, P_j)$. On peut alors déterminer la valeur seuil $\tau$ pour laquelle $P(P_i \cap P_J = \tau)
\leq \alpha$ (avec $\alpha$ souvent fixé à 5%), et on n'induit une arête entre les deux sommets que si la valeur observée satisfait $C \geq \tau$.

