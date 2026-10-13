# Représentation de l'arbre et algorithme alpha-beta

class Node:
	def __init__(self, name, is_max, children=None, value=None):
		self.name = name
		self.is_max = is_max
		self.children = children or []
		self.value = value  # None si pas une feuille

def alphabeta(node, alpha, beta, depth=0):
	indent = '  ' * depth
	alpha_name = f"alpha_{depth+1}"
	beta_name = f"beta_{depth+1}"
	if node.value is not None:
		print(f"{indent}Feuille {node.name}: valeur={node.value}")
		return node.value
	print(f"{indent}{'MAX' if node.is_max else 'MIN'} {node.name}: {alpha_name}={alpha}, {beta_name}={beta}")
	if node.is_max:
		v = float('-inf')
		for i, child in enumerate(node.children):
			val = alphabeta(child, alpha, beta, depth+1)
			v = max(v, val)
			old_alpha = alpha
			alpha = max(alpha, v)
			print(f"{indent}  [MAX] {node.name}: v={v}, {alpha_name}={old_alpha}→{alpha}, {beta_name}={beta}")
			if beta <= alpha:
				print(f"{indent}  Coupure beta dans {node.name} ({beta_name} <= {alpha_name})")
				break
		print(f"{indent}Retour MAX {node.name}: {v}")
		return v
	else:
		v = float('inf')
		for i, child in enumerate(node.children):
			val = alphabeta(child, alpha, beta, depth+1)
			v = min(v, val)
			old_beta = beta
			beta = min(beta, v)
			print(f"{indent}  [MIN] {node.name}: v={v}, {alpha_name}={alpha}, {beta_name}={old_beta}→{beta}")
			if beta <= alpha:
				print(f"{indent}  Coupure alpha dans {node.name} ({beta_name} <= {alpha_name})")
				break
		print(f"{indent}Retour MIN {node.name}: {v}")
		return v



# Construction de l'arbre avec alternance correcte MAX/MIN
# Feuilles
N3a = Node('N3a', False, value=3)
N3b = Node('N3b', False, value=5)
N4a = Node('N4a', False, value=3)
N4b = Node('N4b', False, value=8)
N6a = Node('N6a', False, value=3)
N6b = Node('N6b', False, value=2)
N6c = Node('N6c', False, value=1)
N8a = Node('N8a', False, value=4)
N8b = Node('N8b', False, value=7)
N9a = Node('N9a', False, value=-2)
N9b = Node('N9b', False, value=1)
N12a = Node('N12a', False, value=-4)
N12b = Node('N12b', False, value=4)
N13a = Node('N13a', False, value=4)
N13b = Node('N13b', False, value=0)
N15a = Node('N15a', False, value=3)
N15b = Node('N15b', False, value=-4)
N15c = Node('N15c', False, value=-2)

# Niveaux intermédiaires
N3 = Node('N3', False, children=[N3a, N3b])  # MIN
N4 = Node('N4', False, children=[N4a, N4b])  # MIN
N2 = Node('N2', True, children=[N3, N4])    # MAX
N6 = Node('N6', False, children=[N6a, N6b, N6c])  # MIN
N5 = Node('N5', True, children=[N6])         # MAX
N8 = Node('N8', False, children=[N8a, N8b])  # MIN
N9 = Node('N9', False, children=[N9a, N9b])  # MIN
N7 = Node('N7', True, children=[N8, N9])     # MAX
N1 = Node('N1', False, children=[N2, N5, N7])# MIN

N12 = Node('N12', False, children=[N12a, N12b])  # MIN
N13 = Node('N13', False, children=[N13a, N13b])  # MIN
N11 = Node('N11', True, children=[N12, N13])     # MAX
N15 = Node('N15', False, children=[N15a, N15b, N15c]) # MIN
N14 = Node('N14', True, children=[N15])           # MAX
N10 = Node('N10', False, children=[N11, N14])     # MIN

# Racine
N0 = Node('N0', True, children=[N1, N10])         # MAX

# Exécution alpha-beta
resultat = alphabeta(N0, float('-inf'), float('inf'))
print("\nRésultat alpha-beta :", resultat)
