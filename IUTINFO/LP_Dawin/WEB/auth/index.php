<?php
require_once("auth.php");

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (isset($_POST["login"]) && isset($_POST["password"])) {
        $users = require("users.php");
        
        if (
            isset($users[$_POST["login"]]) &&
            $users[$_POST["login"]] === $_POST["password"]
        ) {
            logUser($_POST["login"]);
        }
    }
}

?>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>Espace protégé</title>
        <link rel="stylesheet" href="style.css">
    </head>
    <body>
        <h1>Connexion</h1>

        <?php include('menu.php'); ?>

        <p>
            Bienvenue. Afin d'accéder aux pages protégées de ce site, merci de vous identifier, à l'aide
            du formulaire ci-dessous:
        </p>

        <p>
            <form method="post">
                Identifiant: <input type="text" name="login" /><br/>
                Mot de passe: <input type="password" name="password" /><br/>
                <input type="submit" />
            </form>
        </p>
    </body>
</html>
