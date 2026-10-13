# A few helper functions for the Sudoku Exercises

def printClause(clause):
    print(" ".join([str(v) for v in clause]) + " 0")

def equals1a(arrayOfVars):
    printClause(arrayOfVars)
    for i, x in enumerate(arrayOfVars):
        for y in arrayOfVars[i+1:]:
            printClause([-x, -y])

# second way: with a callback function (useful to add clauses to a solver)
def equals1(l, callback=printClause):
    callback(l)
    for i, x in enumerate(l):
        for y in l[i+1:]:
            callback([-x, -y])
            
def encode(x, y, val):
    return 100 * x + 10 * y + val

def generateConstraints(callback=printClause):
    r = range(1,10)

    #1. exactement une valeur par case
    for x in r:
        for y in r:
            cell = [encode(x,y,val) for val in r]
            equals1(cell, callback)

    #2. exactement une valeur par ligne x
    for x in r:
        for val in r:
            row = [encode(x,y,val) for y in r]
            equals1(row,callback)

    #3. exactement une valeur par colonne y
    for x in r:
        for val in r:
            line = [encode(x,y,val) for x in r]
            equals1(line,callback)

    #4. exactement une valeur par bloc de 3 cases par 3 cases.
    for x in range(1,4):
        for y in range(1,4):
            for val in r:
                vars_block = [] # On prépare la liste pour ce bloc
                for dx in range(3):
                    for dy in range(3):
                        real_row = (x - 1) * 3 + 1 + dx
                        real_col = (y - 1) * 3 + 1 + dy
                        
                        vars_block.append(encode(real_row, real_col, val))
                # On applique la contrainte sur l'ensemble des 9 cases du bloc
                equals1(vars_block, callback)

    # TODO (Q1): generate all Sudoku constraints here
    pass


if __name__ == "__main__":
    generateConstraints()