# Use a SAT solver to solve the wumpus world
import random
import sys

class WumpusWorld():

    _tokensDescr = { "O": "There is an odor in this cell",
            "M": "There is a monster in this cell",
            "B": "There is a breeze in this cell",
            "H": "There is a hole in this cell",
            "G": "Gold !"}

    def __init__(self, size=10):
        self._size = size
        self._grid = [[[]  for _ in range(size)] for _ in range(size)] # Don't try to access directy to this !
        self._visited = [[False for _ in range(size)] for _ in range(size)]
        self._tokens = list(WumpusWorld._tokensDescr.keys())
        self._x, self._y = (0, 0)
        self._visited[self._x][self._y] = True
        self._nbMoves = 0
        self._generateGrid()

    def _generateGrid(self):
        print(self._grid)
        i = 0
        while i < self._size:
            x, y = random.randint(1, self._size-1), random.randint(1, self._size-1)
            if "M" in self._grid[x][y] or "H" in self._grid[x][y] or "G" in self._grid[x][y]:
                continue
            token = "MH"[random.randint(0,1)] if i > 0 else "G"
            self._grid[x][y].append(token)
            if token != "G":
                effect = {"M":"O", "H":"B"}[token]
                for (xx, yy) in self._around((x,y)):
                    if effect not in self._grid[xx][yy]:
                        self._grid[xx][yy].append(effect)
            i += 1
    
    def _inBound(self, x):
        if x < 0 or x >= self._size: return False
        return True

    def _around(self, coord):
        (x,y) = coord
        toret = []
        for (dx,dy) in [(-1,0), (0,1), (1,0), (0,-1)]:
            if self._inBound(dx+x) and self._inBound(dy+y):
                toret.append((dx+x, dy+y))
        return toret            
    
    def _printSolution(self): # Do not use this!
        for x in range(self._size):
            for y in range(self._size):
                print("".join(self._grid[x][y]).ljust(4), end="")
            print()
    
    ########################################
            
    def getTokens(self):
        return self._tokens
    
    def tokenDescription(self, token):
        if token not in WumpusWorld._tokenDescr:
            return "Not a token"
        return WumpusWorld._tokenDescr[token]

    def getPosition(self):
        return self._x, self._y
    
    def moveHero(self, x, y):
        ''' Move the hero to coordinates (x,y). 
            The new position must be one cell away (no diagonals) from the current pos.
            Returns a string in ["G", "M", "H"] (game finished) or
                      None if the game is not finished'''
        if x < 0 or y < 0 or x >= self._size or y >= self._size:
            print("ERROR IN MOVE")
            sys.exit(1)
        ok = False
        for (dx,dy) in [(-1,0), (0,1), (1,0), (0,-1)]:
            if (self._x + dx == x) and (self._y + dy == y):
                ok = True
                break
        if not ok:
            print("ERROR IN MOVE")
            sys.exit(1)

        self._x, self._y = x, y
        self._visited[self._x][self._y] = True
        self._nbMoves += 1
        for o in self._grid[self._x][self._y]:
            if o in ["G", "M", "H"]:
                return o
        return None

    def __str__(self):
        toret =  f"Position: ({self._x}, {self._y})\n"
        toret += f"Nb Moves: {self._nbMoves}\n\n"
        for x in range(self._size):
            for y in range(self._size):
                toret += "".join(self._grid[x][y] if self._visited[x][y] else ["??"]).ljust(4)
            toret += "\n"
        return toret
    
    def observe(self):
        '''Returns the observations in this cell'''
        return self._grid[self._x][self._y].copy()


class SolveWumpus(): # Your class must inherit from it

    def __init__(self, size = 10):
        self._wumpus = WumpusWorld(size)
        self._observations = [[[None]  for _ in range(size)] for _ in range(size)]
        self._size = size

    def solve(self):
        ''' You will have to change this by using your SAT-based reasoner '''
        x, y = self._wumpus.getPosition() # Starting Position
        self._observations[x][y] = self._wumpus.observe() # Init the starting position observation
        steps = 0
        while steps < 1000:
            possibleMoves = []
            for (dx,dy) in [(-1,0), (0,1), (1,0), (0,-1)]:
                if x+dx >= 0 and y+dy >= 0 and x+dx < self._size and y+dy < self._size:
                    if ("B" not in self._observations[x][y] and \
                       "O" not in self._observations[x][y]) or \
                       (self._observations[x+dx][y+dy] == []):
                          possibleMoves.append((x+dx, y+dy))
            assert len(possibleMoves) > 0
            move = random.choice(possibleMoves)
            x, y = move
            tokens = self._wumpus.moveHero(x, y)
            if None in self._observations[x][y]:
                self._observations[x][y] = self._wumpus.observe()
            print(self._wumpus)
            if tokens is not None and "G" in tokens:
                print("I FOUND THE GOLD!!!")
                self._wumpus._printSolution()
                sys.exit(0)
            steps += 1

wumpus = WumpusWorld()
wumpus._printSolution()
print(wumpus)
SolveWumpus().solve()
