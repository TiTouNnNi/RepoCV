 class ExpertSystem:
    def __init__(self):
        # La base de règles : Liste de dictionnaires
        # Chaque règle a des 'conditions' et un 'result'
        self.rules = [
            {
                "conditions": {"data_type": "image", "dataset_size": "small"},
                "result": "Utilisez le **Transfer Learning** (ex: ResNet, VGG pré-entraîné). Ne ré-entraînez que les dernières couches pour éviter l'overfitting."
            },
            {
                "conditions": {"data_type": "image", "dataset_size": "large"},
                "result": "Utilisez un **CNN profond (Convolutional Neural Network)** standard. Vous avez assez de données pour entraîner l'architecture complète."
            },
            {
                "conditions": {"data_type": "text", "context_length": "short"},
                "result": "Un **RNN simple** ou un **LSTM** (Long Short-Term Memory) devrait suffire pour des séquences courtes."
            },
            {
                "conditions": {"data_type": "text", "context_length": "long"},
                "result": "Utilisez une architecture **Transformer** (type BERT ou GPT). Les mécanismes d'attention sont nécessaires pour gérer les dépendances à long terme."
            },
            {
                "conditions": {"data_type": "tabular", "complexity": "simple"},
                "result": "Un **MLP (Multi-Layer Perceptron)** avec 1 ou 2 couches cachées est suffisant. Attention : pour le tabulaire, XGBoost bat souvent les réseaux de neurones."
            },
            {
                "conditions": {"data_type": "tabular", "complexity": "complex"},
                "result": "Essayez un **TabNet** ou un **MLP profond** avec des techniques de régularisation (Dropout, Batch Norm)."
            },
            {
                "conditions": {"data_type": "time_series"},
                "result": "Utilisez un **LSTM** ou un **GRU**. Si vous avez plusieurs variables corrélées, considérez aussi les CNN 1D."
            }
        ]

    def get_inference(self, user_facts):
        """
        Le Moteur d'Inférence : Compare les faits de l'utilisateur aux règles.
        """
        possible_solutions = []

        for rule in self.rules:
            conditions_met = True
            
            # On vérifie si toutes les conditions de la règle correspondent aux faits
            for key, value in rule["conditions"].items():
                if key not in user_facts or user_facts[key] != value:
                    conditions_met = False
                    break
            
            if conditions_met:
                possible_solutions.append(rule["result"])

        return possible_solutions

# --- Interface Utilisateur (Simulation) ---

def run_advisor():
    print("--- 🧠 AI Architect Advisor ---")
    print("Répondez aux questions pour obtenir une recommandation.\n")

    # Collecte des faits (Input Utilisateur)
    facts = {}
    
    # Question 1: Type de données
    print("Quel type de données utilisez-vous ? (image/text/tabular/time_series)")
    facts["data_type"] = input("> ").strip().lower()

    # Logique dynamique pour poser les questions suivantes selon la réponse précédente
    if facts["data_type"] == "image":
        print("Quelle est la taille de votre dataset ? (small/large)")
        facts["dataset_size"] = input("> ").strip().lower()
        
    elif facts["data_type"] == "text":
        print("Quelle est la longueur du contexte/texte ? (short/long)")
        facts["context_length"] = input("> ").strip().lower()

    elif facts["data_type"] == "tabular":
        print("Quelle est la complexité des relations ? (simple/complex)")
        facts["complexity"] = input("> ").strip().lower()

    # Lancement de l'inférence
    engine = ExpertSystem()
    recommendations = engine.get_inference(facts)

    print("\n--- 💡 Recommandation ---")
    if recommendations:
        for rec in recommendations:
            print(f"- {rec}")
    else:
        print("Aucune règle spécifique trouvée pour cette combinaison. Essayez une architecture standard.")

# Pour lancer le programme
if __name__ == "__main__":
    run_advisor()