from ortools.sat.python import cp_model
def main() -> None:
    model = cp_model.CpModel()
# Decision variables: number of each potion to brew.
    x = model.NewIntVar(0, 399, "x")
    y = model.NewIntVar(0, 399, "y")
    model.Add(3 * x + 2 * y <= 800)
    model.Add(x + 3 * y <= 700)
    model.Add(x + 2 * y <= 400)
    model.Maximize(4 * x + 5 * y)
    solver = cp_model.CpSolver()
    status = solver.Solve(model)
    print("status:", solver.StatusName(status))
    if status == cp_model.OPTIMAL:
        print("objective:", solver.ObjectiveValue())
        print("x=", solver.Value(x), "y=", solver.Value(y))
    else:
        print("No optimal solution found.")
if __name__ == "__main__":
    main()