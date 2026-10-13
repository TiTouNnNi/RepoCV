"""Visualisation d'un MDP fini dont les transitions et récompenses sont des dictionnaires.

Dépendances : numpy, matplotlib.
Usage dans un notebook : from visualiser_mdp import visualiser_mdp
                        visualiser_mdp(mdp)
"""

import numpy as np
import matplotlib.pyplot as plt
from matplotlib.patches import Circle, FancyArrowPatch
from matplotlib.path import Path


def mdp_display(mdp, noms_etats=None, noms_actions=None, afficher=True):
    """Dessine P(s'|s,a) > 0 et R(s,a). Retourne (figure, axes).

    Une distribution entièrement nulle représente une action indisponible.
    Les autres distributions doivent sommer à 1.
    Les transitions vers un même état sont regroupées sur une flèche.
    Lecture : état -- action/probabilité -- récompense --> état suivant.
    """
    n = mdp.nb_states
    if n < 1:
        raise ValueError("Le MDP doit contenir au moins un état.")
    noms_etats = list(noms_etats) if noms_etats is not None else [f"s{s}" for s in range(n)]
    noms_actions = list(noms_actions) if noms_actions is not None else [f"a{a}" for a in range(mdp.nb_actions)]
    if len(noms_etats) != n or len(noms_actions) != mdp.nb_actions:
        raise ValueError("Le nombre de noms doit correspondre au nombre d'états/actions.")

    transitions = {}
    for s in range(n):
        for a in range(mdp.nb_actions):
            probs = np.array([mdp.transition_prob.get((s, a, sp), 0.0) for sp in range(n)], dtype=float)
            if not np.all(np.isfinite(probs)) or np.any(probs < 0) or np.any(probs > 1):
                raise ValueError(f"Probabilités invalides pour (s={s}, a={a}).")
            if np.all(probs == 0):
                continue
            if not np.isclose(probs.sum(), 1.0):
                raise ValueError(f"Les probabilités de (s={s}, a={a}) somment à {probs.sum()}, pas à 1.")
            reward = mdp.reward.get((s, a), 0.0)
            for sp, p in enumerate(probs):
                if p > 0:
                    transitions.setdefault((s, sp), []).append(
                        (f"{noms_actions[a]}/{p:.3g}", f"r={reward:.3g}")
                    )

    angles = np.linspace(0, 2 * np.pi, n, endpoint=False) + np.pi / 2
    positions = np.column_stack((np.cos(angles), np.sin(angles)))
    radius = min(0.13, 0.6 / max(n, 1))
    fig, ax = plt.subplots(figsize=(11, 9))
    label_style = dict(ha="center", va="center", fontsize=9,
                       bbox=dict(facecolor="white", edgecolor="none", alpha=0.9, pad=2))

    for (s, sp), lines in transitions.items():
        start, end = positions[s], positions[sp]
        action_label = "\n".join(line[0] for line in lines)
        reward_label = "\n".join(line[1] for line in lines)
        if s == sp:
            # Boucle située à l'extérieur du cercle des états.
            outward = start / np.linalg.norm(start)
            tangent = np.array([-outward[1], outward[0]])
            # Les deux attaches restent sur la moitié extérieure du nœud.
            # Toute la boucle est ainsi à l'extérieur du cercle des états,
            # tandis que les transitions entre états passent à l'intérieur.
            attachment_angle = np.deg2rad(40)
            p1 = start + radius * (np.cos(attachment_angle) * outward
                                   - np.sin(attachment_angle) * tangent)
            p2 = start + radius * (np.cos(attachment_angle) * outward
                                   + np.sin(attachment_angle) * tangent)
            # Réduire la largeur pour les graphes comportant beaucoup d'états.
            loop_width = min(0.30, 0.55 * np.sin(np.pi / max(n, 2)))
            loop_depth = 0.55
            control1 = start + (radius + loop_depth) * outward - loop_width * tangent
            control2 = start + (radius + loop_depth) * outward + loop_width * tangent
            path = Path([p1, control1, control2, p2],
                        [Path.MOVETO, Path.CURVE4, Path.CURVE4, Path.CURVE4])
            arrow = FancyArrowPatch(path=path,
                                    arrowstyle="-|>", mutation_scale=16, color="0.4")
            ax.add_patch(arrow)
            def point(t):
                return ((1-t)**3 * p1 + 3*(1-t)**2*t * control1
                        + 3*(1-t)*t**2 * control2 + t**3 * p2)
        else:
            direction = end - start
            unit = direction / np.linalg.norm(direction)
            p1, p2 = start + radius * unit, end - radius * unit
            curvature = 0.22 if (sp, s) in transitions else 0.0
            arrow = FancyArrowPatch(p1, p2, connectionstyle=f"arc3,rad={curvature}",
                                    arrowstyle="-|>", mutation_scale=16, color="0.4")
            ax.add_patch(arrow)
            # Points sur la courbe quadratique utilisée par arc3.
            dx, dy = p2 - p1
            control = (p1 + p2) / 2 + curvature * np.array([dy, -dx])
            def point(t):
                return (1-t)**2 * p1 + 2*(1-t)*t * control + t**2 * p2
        if s == sp:
            # Placer les étiquettes hors de la boucle pour ne pas la masquer.
            # L'alignement les fait s'étendre de part et d'autre de la boucle.
            action_pos = point(0.30) - 0.10 * tangent + 0.07 * outward
            reward_pos = point(0.70) + 0.10 * tangent + 0.07 * outward
            action_style = dict(label_style)
            reward_style = dict(label_style)
            if abs(tangent[0]) >= abs(tangent[1]):
                action_style['ha'] = 'right' if tangent[0] > 0 else 'left'
                reward_style['ha'] = 'left' if tangent[0] > 0 else 'right'
            else:
                action_style['va'] = 'top' if tangent[1] > 0 else 'bottom'
                reward_style['va'] = 'bottom' if tangent[1] > 0 else 'top'
            ax.text(*action_pos, action_label, **action_style)
            ax.text(*reward_pos, reward_label, **reward_style)
        else:
            ax.text(*point(0.30), action_label, **label_style)
            ax.text(*point(0.70), reward_label, **label_style)

    for s, pos in enumerate(positions):
        ax.add_patch(Circle(pos, radius, facecolor="#dbeafe", edgecolor="#2563eb", linewidth=2, zorder=3))
        ax.text(*pos, noms_etats[s], ha="center", va="center", fontsize=11, zorder=4)

    ax.set_title(f"MDP : {n} états, {mdp.nb_actions} actions, γ={mdp.gamma}\n"
                 "Lecture : état — action/probabilité — récompense → état suivant\n"
                 "Si plusieurs actions partagent une flèche, les lignes se correspondent.")
    ax.set_aspect("equal")
    ax.set_xlim(-1.85, 1.85)
    ax.set_ylim(-1.85, 1.85)
    ax.axis("off")
    fig.tight_layout()
    if afficher:
        plt.show()
    return fig, ax


if __name__ == "__main__":
    from types import SimpleNamespace

    # Les entrées absentes valent zéro. Chaque action disponible somme à 1.
    mdp = SimpleNamespace(
        nb_states=3,
        nb_actions=2,
        gamma=0.9,
        transition_prob={
            (0, 0, 0): 0.2, (0, 0, 1): 0.8,
            (0, 1, 2): 1.0,
            (1, 0, 0): 1.0,
            (1, 1, 2): 1.0,
            (2, 0, 2): 1.0,
            (2, 1, 2): 1.0,
        },
        reward={(0, 0): 0, (0, 1): -1, (1, 0): 0,
                 (1, 1): 5, (2, 0): 0, (2, 1): 0},
    )
    mdp_display(mdp)
