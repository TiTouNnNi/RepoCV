<?php

session_start();

function redirect(string $url): void
{
    header("Location: $url");
    die();
}

function logUser(string $user): void
{
    $_SESSION["user"] = $user;
    redirect($_GET["url"] ?? "report.php");
}

function logout(): void
{
    unset($_SESSION["user"]);
    redirect("index.php");
}

function isConnected(): bool
{
    return isset($_SESSION["user"]);
}

function checkConnected(): void
{
    if (!isConnected()) {
        redirect("index.php?url=".$_SERVER["REQUEST_URI"]);
    }
}
