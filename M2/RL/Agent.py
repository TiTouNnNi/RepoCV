import numpy as np

class Agent:
        def __init__(self,nb_states,nb_actions,policy):
                self.nb_states = nb_states
                self.nb_actions = nb_actions
                if policy is None:
                        self.policy = {s:np.random.randint(self.nb_actions) for s in range(self.nb_states)}
                else:
                        self.policy = policy

        def chose_action(self, state):
                return self.policy[state]