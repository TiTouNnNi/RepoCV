import sys
from pysat.solvers import Glucose3
from wumpusWorld import SolveWumpus, WumpusWorld

class MonstreSAT(SolveWumpus):
    
    # --- 1. INTÉGRATION DU CODE ISSU DE TD1.PY ---
    
    # Je reprends votre dictionnaire TYPE. 
    # Note : Le WumpusWorld utilise 'H' pour Trou (Hole) et 'B' pour Vent (Breeze).
    # Je ferai le mapping lors de l'observation.
    TYPE = {'M':1, 'O':2, 'T':3, 'V':4, 'G':5}

    def __init__(self, size=10):
        super().__init__(size)
        self.solver = Glucose3()
        # On remplace la variable globale __GRIDSIZE__ par self._size
        self._visited_cells = set()
        self._init_knowledge_base()

    def inBound(self, x):
        # Code original adapté pour utiliser self._size
        if x < 0 or x >= self._size: return False
        return True

    def around(self, coord):
        # Code original de TD1.py
        (x,y) = coord
        toret = []
        for (dx,dy) in [(-1,0), (0,1), (1,0), (0,-1)]:
            if self.inBound(dx+x) and self.inBound(dy+y):
                toret.append((dx+x, dy+y))
        return toret

    def encode(self, symb, x, y):
        # Code original de TD1.py adapté légèrement pour la taille variable
        # "100 * TYPE[symb] + 10 * x + y" ne marche que si x < 10.
        # Pour respecter l'énoncé (mondes de tailles différentes), j'adapte le multiplicateur.
        multiplier = max(10, self._size) 
        return 100 * self.TYPE[symb] + multiplier * x + y

    def getAllClauses(self, coord):
        # C'est VOTRE fonction TD1.py, copiée/collée et adaptée aux méthodes de classe (self)
        x, y = coord
        clauses = []
        # Pour chaque case voisine (xp, yp)
        for (xp, yp) in self.around(coord):
            # M(x,y) => O(xp,yp)  équivaut à  -M v O
            clauses.append([ -self.encode('M', x, y), self.encode('O', xp, yp) ])
            
            # T(x,y) => V(xp,yp)  équivaut à  -T v V
            # Note: T=Trou, V=Vent (correspond à H et B dans wumpusWorld)
            clauses.append([ -self.encode('T', x, y), self.encode('V', xp, yp) ])
            
            # O(x,y) => M(xp,yp)  équivaut à  -O v M
            # Note: Cette implication dans TD1 (Odeur ici => Monstre voisin) est suffisante pour la sécurité
            clauses.append([ -self.encode('O', x, y), self.encode('M', xp, yp) ])
            
            # V(x,y) => T(xp,yp)  équivaut à  -V v T
            clauses.append([ -self.encode('V', x, y), self.encode('T', xp, yp) ])
            
            # Les lignes "inversées" de votre TD1 original (utiles pour la déduction dans les deux sens)
            clauses.append([ self.encode('O', x, y), -self.encode('M', xp, yp) ])
            clauses.append([ self.encode('V', x, y), -self.encode('T', xp, yp) ])

        return clauses

    # --- 2. ADAPTATION POUR L'ARCHITECTURE JOUEUR (ENONCÉ) ---

    def _init_knowledge_base(self):
        """Au lieu de saveClause(filename), on injecte direct dans le solveur pysat"""
        for x in range(self._size):
            for y in range(self._size):
                clauses = self.getAllClauses((x,y))
                for clause in clauses:
                    self.solver.add_clause(clause)

    def _bfs_move_to(self, start, target):
        """Pathfinding simple pour aller vers une case sûre (car moveHero est local)"""
        queue = [(start, [])]
        seen = {start}
        while queue:
            curr, path = queue.pop(0)
            if curr == target: return path
            # On ne se déplace que sur des cases VISITÉES (donc sûres)
            for n in self.around(curr):
                if n in self._visited_cells and n not in seen:
                    seen.add(n)
                    queue.append((n, path + [n]))
                elif n == target: # La cible est voisine
                    return path + [n]
        return None

    def solve(self):
        # Logique principale demandée dans l'énoncé
        x, y = self._wumpus.getPosition()
        # Fait initial: Pas de Monstre ni Trou au départ
        self.solver.add_clause([-self.encode('M', x, y)])
        self.solver.add_clause([-self.encode('T', x, y)])
        
        steps = 0
        while steps < 1000:
            current = (x, y)
            self._visited_cells.add(current)
            
            # 1. OBSERVATION
            percepts = self._wumpus.observe()
            self._observations[x][y] = percepts
            print(f"Position: {current}, Perçus: {percepts}")

            if "G" in percepts:
                print("I FOUND THE GOLD!!!")
                sys.exit(0)

            # 2. ENCODAGE DES FAITS (Mapping Wumpus -> TD1)
            # Wumpus 'O' -> TD1 'O'
            has_odor = "O" in percepts
            self.solver.add_clause([self.encode('O', x, y) if has_odor else -self.encode('O', x, y)])

            # Wumpus 'B' (Breeze) -> TD1 'V' (Vent)
            has_breeze = "B" in percepts
            self.solver.add_clause([self.encode('V', x, y) if has_breeze else -self.encode('V', x, y)])

            # Case courante safe (redondant mais sain)
            self.solver.add_clause([-self.encode('M', x, y)])
            self.solver.add_clause([-self.encode('T', x, y)])

            # 3. DÉDUCTION & DÉCISION
            # On cherche les voisins non visités de toutes nos cases visitées
            candidates = set()
            for v_cell in self._visited_cells:
                for n_cell in self.around(v_cell):
                    if n_cell not in self._visited_cells:
                        candidates.add(n_cell)
            
            safe_target = None
            for (cx, cy) in candidates:
                # On teste si la case peut contenir un danger
                # Hypothèse : "Il y a un Monstre en (cx, cy)"
                monstre_possible = self.solver.solve(assumptions=[self.encode('M', cx, cy)])
                # Hypothèse : "Il y a un Trou en (cx, cy)"
                trou_possible = self.solver.solve(assumptions=[self.encode('T', cx, cy)])
                
                # Si le solveur dit UNSAT (Impossible) pour les deux, c'est sûr !
                if not monstre_possible and not trou_possible:
                    safe_target = (cx, cy)
                    break # On en prend une au hasard
            
            if not safe_target:
                print("Aucun coup sûr trouvé (ou bloqué).")
                break

            # 4. DÉPLACEMENT
            path = self._bfs_move_to(current, safe_target)
            if path:
                for (px, py) in path:
                    self._wumpus.moveHero(px, py)
                    x, y = px, py # Mise à jour position
                    # Vérif or en passant
                    obs = self._wumpus.observe()
                    if "G" in obs:
                         print("I FOUND THE GOLD en passant !!!")
                         sys.exit(0)
            else:
                print("Erreur de déplacement.")
                break
                
            steps += 1

if __name__ == "__main__":
    player = MonstreSAT(size=10) # Vous pouvez changer la taille ici
    player.solve()