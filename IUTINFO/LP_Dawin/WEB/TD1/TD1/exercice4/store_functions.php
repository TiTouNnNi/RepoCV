<?php

/**
 * Charge les produits
 */
$products = @include('products.php');

if (!is_array($products)) {
    $products = [];
}

/**
 * Liste les produits
 */
function storeList()
{
    global $products;

    echo "Liste des produits :\n";

    foreach ($products as $name => $infos) {
        printf("* %s, quantité: %d, prix: %g\n", $name, $infos['quantity'], $infos['price']);
    }
}

/**
 * Ajout d'élément au magasin
 */
function storeAdd($name, $quantity)
{
    global $products;

    if (!isset($products[$name])) {
        $products[$name] = [
            'price' => null,
            'quantity' => 0,
        ];
    }

    $products[$name]['quantity'] += $quantity;

    storePersist();
}

/**
 * Persiste les éléments dans le fichier
 */
function storePersist()
{
    global $products;

    file_put_contents('products.php', '<?php return ' . var_export($products, true) . ';');
}

function storeSetPrice($product, $price)
{
    global $products;

    $products[$product]['price'] = (int)$price;
    storePersist();
}

function storeRemove($product, $quantity)
{
    global $products;

    $products[$product]['quantity'] -= (int)$quantity;
    storePersist();
}

function storeSetDescription($product, $description)
{
    global $products;

    $products[$product]['description'] = $description;
    storePersist();
}

function storeSearch($description)
{
    global $products;

    foreach($products as $name => $datas){
        if(str_contains($name, $description) || str_contains($datas['description'], $description)){
            echo 'Produit : '.$name.' description : '.$datas['description']."\n";
        }
    }
}