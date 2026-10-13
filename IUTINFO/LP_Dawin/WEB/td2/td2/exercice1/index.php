<head>
    <meta charset="utf8" />
    <title>Dexter</title>
    <style>
        body {
            width: 600px;
            font-family: sans-serif;
            margin: auto;
            margin-top: 30px;
        }

        a {
            color: #c00;
        }
    </style>
</head>

<body>
    <div class="menu">
        <a href="index.html">Accueil</a> -
        <a href="saison1.html">Saison 1</a> -
        <a href="saison2.html">Saison 2</a> -
        <a href="saison3.html">Saison 3</a>
    </div>
    <?php
    if (isset($_GET['page'])) {
        switch ($_GET['page']) {
            case 1:
    ?>
                <h1>Bienvenue sur le site sur la série Dexter !</h1>

                <p>
                    Bienvenue ! Vous retrouverez ici le résumé des saisons de Dexter
                </p><?php
                    break;
                case 2:
                    ?>

                <h1>Saison 1</h1>

                <p>
                    Cette première saison est composée de 12 épisodes.
                </p>
                <p>
                    L'ambiance et l'intrigue de cette saison mettent en place les personnages et leur psychologie en faisant découvrir le monde de Dexter, son histoire, sa famille et son entourage. Dès le premier épisode est introduit l'arc narratif, du tueur au camion frigorifique (The Ice Truck Killer en VO).
                </p><?php
                    break;
                case 3:
                    ?>

                <h1>Saison 2</h1>

                <p>
                    Cette deuxième saison composée de 12 épisodes ne suit pas les évènements du livre de Jeff Lindsay, Le Passager noir, qui est la suite du premier livre Ce cher Dexter.
                </p>
                <p>
                    Dexter a tué Brian Moser, qui était en réalité son frère. De son côté, Doakes le soupçonne de plus de plus d'accomplir des meurtres. Tandis que Rita s'interroge sur Dexter quant à de potentiels problèmes de dépendance à l'alcool ou de drogue.
                </p><?php
                    break;
                case 4:
                    ?>

                <h1>Saison 3</h1>

                <p>
                    Cette troisième saison a été annoncée lors d'une soirée organisée par Showtime sur le thème de la série début novembre 2007 par le président de la chaîne, Robert Greenblatt, lorsque des journalistes lui ont demandé si une troisième saison était prévue.
                </p>
                <p>
                    Composée de 12 épisodes, elle a été diffusée à partir du 28 septembre 2008 sur Showtime aux États-Unis, et a été diffusée en France à la suite de la deuxième saison dès le 19 février 2009, soit deux mois après la fin de la diffusion originale.
                </p>
                <p>
                    Dexter et Rita avancent dans leur relation, ils découvrent que cette dernière est enceinte de lui. Batista est promu sergent au poste laissé vacant par Doakes. Un assistant procureur fait la connaissance de Dexter et va apprendre beaucoup de lui. Une collègue de Dexter gravement malade lui demande un énorme service.
                </p><?php
                    break;
            }
        }
                    ?>
</body>