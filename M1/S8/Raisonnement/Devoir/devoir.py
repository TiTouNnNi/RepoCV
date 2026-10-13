import sys
import random
from collections import deque
from wumpusWorld import SolveWumpus, WumpusWorld
from pysat import Solver

class Joueur(SolveWumpus):
    
    TYPE = {'M': 0, 'O': 1, 'T': 2, 'V': 3, 'G': 4} 

    def inBound(self, x):
        if x < 0 or x >= self._size: return False
        return True

    def around(self, coord):
        (x, y) = coord
        toret = []
        for (dx, dy) in [(-1, 0), (0, 1), (1, 0), (0, -1)]:
            if self.inBound(dx + x) and self.inBound(dy + y):
                toret.append((dx + x, dy + y))
        return toret

    def encode(self, symb, x, y):
        offset = self.TYPE[symb] * (self._size * self._size)
        return offset + (x * self._size + y) + 1

    def getAllClauses(self, coord):

        x, y = coord
        clauses = []
        neighbors = self.around(coord)

        # Règle 1 : M(x,y) => O(voisin) 
        for (xp, yp) in neighbors:
            clauses.append([-self.encode('M', x, y), self.encode('O', xp, yp)])

        # Règle 2 : T(x,y) => V(voisin)
        for (xp, yp) in neighbors:
            clauses.append([-self.encode('T', x, y), self.encode('V', xp, yp)])

        # Règle 3 : O(x,y) => (M(v1) OR M(v2) OR M(v3) OR M(v4))
        clause_odeur = [-self.encode('O', x, y)]
        for (xp, yp) in neighbors:
            clause_odeur.append(self.encode('M', xp, yp))
        clauses.append(clause_odeur)

        # --- Règle 4 : V(x,y) => (T(v1) OR T(v2) OR OR T(v2) OR T(v2)) ---
        clause_vent = [-self.encode('V', x, y)]
        for (xp, yp) in neighbors:
            clause_vent.append(self.encode('T', xp, yp))
        clauses.append(clause_vent)

        return clauses

    def __init__(self, size=10):
        super().__init__(size)
        self.clauses_depart = [] 
        self.clauses_observation = [] 
        
        self.cases_visitees = set()
        self.cases_sures = set() 
        
        for x in range(size):
            for y in range(size):
                self.clauses_depart.extend(self.getAllClauses((x,y)))

    def tester_hypothese(self, a_tester):
        solver = Solver()
        
        for c in self.clauses_depart:
            solver.addClause(c)
            
        for c in self.clauses_observation:
            solver.addClause(c)
            
        solver.addClause([a_tester])
        
        solver.buildDataStructure()
        result = solver.solve()
        
        return (result == 1) # True si SAT, False si UNSAT 

    def est_case_sure(self, x, y):
        if (x, y) in self.cases_sures:
            return True

        id_monstre = self.encode('M', x, y)
        possible_monstre = self.tester_hypothese(id_monstre)

        id_trou = self.encode('T', x, y)
        possible_trou = self.tester_hypothese(id_trou)

        if not possible_monstre and not possible_trou:
            self.cases_sures.add((x, y))
            return True
            
        return False

    def trouver_chemin(self, depart, arrivee):
        file = deque([(depart, [])])
        visites = {depart}
        
        while file:
            (cx, cy), chemin = file.popleft()
            if (cx, cy) == arrivee:
                return chemin
            
            for (nx, ny) in self.around((cx, cy)):
                if ((nx, ny) in self.cases_visitees or (nx, ny) == arrivee) and (nx, ny) not in visites:
                    visites.add((nx, ny))
                    file.append(((nx, ny), chemin + [(nx, ny)]))
        return None

    def solve(self):
        x, y = self._wumpus.getPosition()
        self.cases_visitees.add((x, y))
        self.cases_sures.add((x, y))
        
        self.clauses_observation.append([-self.encode('M', x, y)])
        self.clauses_observation.append([-self.encode('T', x, y)])

        steps = 0
        while steps < 2000:
            curr_pos = self._wumpus.getPosition()
            observations = self._wumpus.observe()
            

            has_smell = "O" in observations
            lit_odeur = self.encode('O', curr_pos[0], curr_pos[1])
            clause_odeur = [lit_odeur] if has_smell else [-lit_odeur]
            if clause_odeur not in self.clauses_observation:
                self.clauses_observation.append(clause_odeur)
            
            has_breeze = "B" in observations
            lit_vent = self.encode('V', curr_pos[0], curr_pos[1])
            clause_vent = [lit_vent] if has_breeze else [-lit_vent]
            if clause_vent not in self.clauses_observation:
                self.clauses_observation.append(clause_vent)
            
            if "G" in observations:
                print(f" Or trouvé en {curr_pos} après {steps} étapes.")
                sys.exit(0)

            frontiere = set()
            for (vx, vy) in self.cases_visitees:
                for (nx, ny) in self.around((vx, vy)):
                    if (nx, ny) not in self.cases_visitees:
                        frontiere.add((nx, ny))
            
            meilleure_cible = None
            
            candidats = sorted(list(frontiere), key=lambda c: abs(c[0]-curr_pos[0]) + abs(c[1]-curr_pos[1]))

            for cand in candidats:
                if self.est_case_sure(cand[0], cand[1]):
                    meilleure_cible = cand
                    break 
            
            if meilleure_cible:

                chemin = self.trouver_chemin(curr_pos, meilleure_cible)
                
                if chemin and len(chemin) > 0:
                    next_step = chemin[0]
                    res = self._wumpus.moveHero(next_step[0], next_step[1])
                    self.cases_visitees.add(next_step)
                    
                    clause_pas_monstre = [-self.encode('M', next_step[0], next_step[1])]
                    clause_pas_trou = [-self.encode('T', next_step[0], next_step[1])]

                    if clause_pas_monstre not in self.clauses_observation:
                        self.clauses_observation.append(clause_pas_monstre)
                    
                    if clause_pas_trou not in self.clauses_observation:
                        self.clauses_observation.append(clause_pas_trou)
                else:
                    print("Impossible de trouver un chemin vers la case sûre.")
                    break
            else:
                print("Aucune case sûre trouvée.")
                break 

            steps += 1

if __name__ == "__main__":
    w = WumpusWorld()
    print("Monde généré (caché) :")
    joueur = Joueur()
    joueur.solve()