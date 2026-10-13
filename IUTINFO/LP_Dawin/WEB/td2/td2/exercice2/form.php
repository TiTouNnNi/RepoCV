<?php

function traitement($prenom, $nom, $genre)
{
    echo 'Vous vous nommez ' . htmlspecialchars($prenom) . ' ' . htmlspecialchars($nom) . ' ' . htmlspecialchars($genre);
    echo '<hr/>';
}

?>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf8" />
    <title>Formulaire</title>
</head>

<body>
    <h1>Formulaire</h1>

    <?php
    if ($_SERVER['REQUEST_METHOD'] == 'POST') {

        if (isset($_POST['genre']) && isset($_POST['prenom']) && isset($_POST['nom']) && filter_var($_POST['mail'], FILTER_VALIDATE_EMAIL)) {
            // Le formulaire est valide et bien rempli, appel du traitement
            // sur les données
            traitement($_POST['prenom'], $_POST['nom'], $_POST['genre']);
        }
    }
    ?>

    <form method="post">
        Votre prénom&nbsp;:
        <input type="text" name="prenom" /><br />
        Votre nom&nbsp;:
        <input type="text" name="nom" /><br />
        Votre email&nbsp;:
        <input type="email" name="mail" /><br />
        <select name="genre">
            <option value="homme">Homme</option>
            <option value="femme">Femme</option>
        </select>
        <br>
        Vous savez programmé en&nbsp;:
        <label>
            <input type='checkbox' name="langage[0]">
            HTML
        </label><label>
            <input type='checkbox' name="langage[1]">
            CSS
        </label><label>
            <input type='checkbox' name="langage[2]">
            JS
        </label><label>
            <input type='checkbox' name="langage[3]">
            PHP
        </label>
        <hr />
        <input type="submit" value="Envoyer" />
    </form>
</body>

</html>