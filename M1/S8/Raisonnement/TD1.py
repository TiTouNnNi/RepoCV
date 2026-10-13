
__GRIDSIZE__ = 4

def inBound(x):
   if x < 0 or x >= __GRIDSIZE__: return False
   return True

def around(coord):
   (x,y) = coord
   toret = []
   for (dx,dy) in [(-1,0), (0,1), (1,0), (0,-1)]:
      if inBound(dx+x) and inBound(dy+y):
         toret.append((dx+x, dy+y))
   return toret

def varToStr(symbol, coord):
   return symbol+str(coord)

def printConstraint(symbol1, symbol2, coord):
   for (x,y) in around(coord):
      print(varToStr(symbol1, coord)+" -> "+varToStr(symbol2,(x,y)))

def printConstraintNeg(symbol1, symbol2, coord):
   for (x,y) in around(coord):
      print("not " + varToStr(symbol1, coord)+" -> not "+varToStr(symbol2,(x,y)))

def printConstraintNeg(symbol1, symbol2, coord):
   for (x,y) in around(coord):
      print("not " + varToStr(symbol1, coord)+" -> not "+varToStr(symbol2,(x,y)))

def printExclusionConstraint(symbol1, symbol2, coord):
   print(varToStr(symbol1,coord) + "-> not " + varToStr(symbol2,coord))
   print(varToStr(symbol2,coord) + "-> not " + varToStr(symbol1,coord))

def printAllConstraints(coord):
   printConstraint("T", "V", coord) # A Hole implies wind all around
   printConstraint("M", "O", coord) # A Monster implies odors all around
   printConstraintNeg("O", "M", coord) # No Odor means no monster all around
   printConstraintNeg("V", "T", coord) # No wind implies no hole all around
   printExclusionConstraint("M","T",coord) # A cell cannot contain a Monster and a Hole
   printExclusionConstraint("G","T",coord) # A cell cannot contain a Gold and a Hole
   printExclusionConstraint("G","M",coord) # A cell cannot contain a Gold and a Monster

TYPE = {'M':1,'O':2,'T':3,'V':4,'G':5}
encode = lambda symb, x, y: 100 * TYPE[symb] + 10 * x + y

def getAllClauses(coord):
    x, y = coord
    clauses = []
    # Pour chaque case voisine (xp, yp)
    for (xp, yp) in around(coord):
        # M(x,y) => O(xp,yp)  équivaut à  -M v O
        # On ajoute une liste d'entiers : [ -ID_M, ID_O ]
        clauses.append([ -encode('M', x, y), encode('O', xp, yp) ])
        
        # T(x,y) => V(xp,yp)  équivaut à  -T v V
        clauses.append([ -encode('T', x, y), encode('V', xp, yp) ])
        
        # O(x,y) => M(xp,yp)  équivaut à  -O v M
        clauses.append([ -encode('O', x, y), encode('M', xp, yp) ])
        
        # V(x,y) => T(xp,yp)  équivaut à  -V v T
        clauses.append([ -encode('V', x, y), encode('T', xp, yp) ])
        
        # Note : Les deux lignes suivantes dans votre code original semblaient
        # inverser la logique (O => non M ?). Je les laisse telles quelles 
        # syntaxiquement, mais vérifiez votre logique métier :
        clauses.append([ encode('O', x, y), -encode('M', xp, yp) ])
        clauses.append([ encode('V', x, y), -encode('T', xp, yp) ])

    return clauses

def saveClause(filename):
    with open(filename, 'w') as f:
        for x in range(__GRIDSIZE__):
            for y in range(__GRIDSIZE__):
                clauses = getAllClauses((x,y))
                for clause in clauses:
                    # On convertit chaque entier en str, on joint avec espace
                    # Et on ajoute " 0" à la fin (avec un espace avant le 0 !)
                    f.write(' '.join(str(v) for v in clause) + ' 0\n')


    #not O(x,y) => not M(xp,yp) = -encode(O)

# Now prints all the constaints

saveClause("kb.cnf")

#for x in range(__GRIDSIZE__):
  #for y in range(__GRIDSIZE__):
    #printAllConstraints((x,y))


