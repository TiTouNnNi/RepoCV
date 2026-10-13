<?php

/**
 * Calcule la somme des n premiers entiers
 */
function somme_entiers($n)
{
    $somme = 0;
    for ($i = 1; $i <= $n; $i++) {
        $somme += $i;
    }
    return $somme;
}

if (somme_entiers(5) == 5 + 4 + 3 + 2 + 1) {
    echo "OK: somme_entiers\n";
}

/**
 * Cherche la plus petite des valeurs d'un tableau
 */
function valeur_min($tab)
{
    $min = $tab[0];
    foreach ($tab as $nombre) {
        if ($nombre < $min) {
            $min = $nombre;
        }
    }
    return $min;
}

if (valeur_min([5, 23, 8, 19, 28, 3, 55, -52, 100, 82, 75, 22]) == -52) {
    echo "OK: valeur_min\n";
}

/**
 * Cherche l'indice de la plus petite des valeurs d'un tableau
 */
function valeur_min_indice($tab)
{
    $min = null;
    $indice = -1;
    foreach ($tab as $i => $nombre) {
        if ($min == null){
            $min = $nombre;
            $indice = $i;
        }
        if ($nombre < $min) {
            $min = $nombre;
            $indice = $i;
        }
    }
    return $indice;
}

// indices: 0 1  2 3  4  5 6  7   8   9  10 11
if (valeur_min_indice([5, 23, 8, 19, 28, 3, 55, -52, 100, 82, 75, 22]) == 7) {
    echo "OK: valeur_min_indice\n";
}

/**
 * Retourne la somme des éléments du tableau
 */
function somme_tableau($tab)
{
    $somme = 0;
    foreach ($tab as $nombre) {
        $somme += $nombre;
    }
    return $somme;
}

if (somme_tableau([12, 23, 4]) == 39) {
    echo "OK: somme_tableau\n";
}

/**
 * Trie le tableau $tab à l'aide de valeur_min_indice() (sans utiliser sort())
 */
function tri($tab)
{
    $tempTab = [];
    $val = 0;
    $taille = count($tab);
    for ($i = 0; $i < $taille; $i++) {
        $val = valeur_min_indice($tab);
        $tempTab[$i] = $tab[$val];
        unset($tab[$val]);
    }
    return $tempTab;
}

if (tri([8, 5, 2, 9, 3, 55, 2]) == [2, 2, 3, 5, 8, 9, 55]) {
    echo "OK: tri\n";
}
