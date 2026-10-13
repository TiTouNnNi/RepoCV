<span class="menu">
    <a href="report.php">
        <img src="lock.png" />
        Rapport
    </a>
    <a href="photo.php">
        <img src="lock.png" />
        Photo
    </a>
    <?php if (isConnected()) { ?>
        <a href="logout.php">Déconnexion</a>
    <?php } else { ?>
        <a href="index.php">Connexion</a>
    <?php } ?>
</span>