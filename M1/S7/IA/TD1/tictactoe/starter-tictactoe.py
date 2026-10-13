# -*- coding: utf-8 -*-

import time
import Tictactoe 
from random import randint,choice

victory = [0]
defeat = [0]
draw = [0]
nb_node = [0]

def RandomMove(b):
    '''Renvoie un mouvement au hasard sur la liste des mouvements possibles'''
    return choice(b.legal_moves())

def deroulementRandom(b):
    '''Effectue un déroulement aléatoire du jeu de morpion.'''
    print("----------")
    print(b)
    if b.is_game_over():
        res = getresult(b)
        if res == 1:
            print("Victoire de X")
        elif res == -1:
            print("Victoire de O")
        else:
            print("Egalité")
        return
    b.push(RandomMove(b))
    deroulementRandom(b)
    b.pop()

def explorePossibilites(b, victory, draw, defeat, nb_node):
    if b.is_game_over():
        if getresult(b) == 1:
            victory[0] += 1
        elif getresult(b) == 0:
            draw[0] += 1
        else :
            defeat[0] += 1
        return
    moves = b.legal_moves()
    for move in moves:
        nb_node[0] += 1
        b.push(move)
        explorePossibilites(b, victory, draw, defeat, nb_node)
        b.pop()


def getresult(b):
    '''Fonction qui évalue la victoire (ou non) en tant que X. Renvoie 1 pour victoire, 0 pour 
       égalité et -1 pour défaite. '''
    if b.result() == b._X:
        return 1
    elif b.result() == b._O:
        return -1
    else:
        return 0


board = Tictactoe.Board()
print(board)

### Deroulement d'une partie aléatoire
###deroulementRandom(board)
explorePossibilites(board, victory, draw, defeat, nb_node)
print("Victoire : " + str(victory[0]) + "\n Défaite : "+ str(defeat[0]) + "\n Draw : " + str(draw[0]) + "\n Nombre de noeuds : "+ str(nb_node[0]))

print("Apres le match, chaque coup est défait (grâce aux pop()): on retrouve le plateau de départ :")
print(board)

