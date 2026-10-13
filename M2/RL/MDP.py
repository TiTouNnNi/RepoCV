import numpy as np

class MDP:
        def __init__(self, nb_states, nb_actions, transition_prob, reward, gamma=.9):
                self.nb_states = nb_states
                self.nb_actions = nb_actions
                self.gamma = gamma
                if transition_prob is None:
                        self.transition_prob = {(s,a,sp): 0 
                                                for s in range(nb_states) 
                                                for a in range(nb_actions) 
                                                for sp in range(nb_states)}
                else:
                        self.transition_prob = transition_prob

                if reward is None:
                        self.reward = {(s,a):0
                                       for s in range(nb_states)
                                       for a in range(nb_actions)}
                else:
                        self.reward = reward

        #Receives an action and returns the next state and the reward of the action done
        def play(self,state,action):
                probas = np.array([self.transition_prob.get((state, action, sp), 0.0)
                           for sp in range(self.nb_states)], dtype=float)
                next_state = np.random.choice(range(self.nb_states), p=probas)
                r = self.reward[state,action]
                return next_state, r
        
        #Receives a state and returns the list of possible actions.
        def get_possible_actions(self,state):
                return [a for a in range(self.nb_actions) 
                        if np.any(self.transition_prob[state, a, sp] for sp in range(self.nb_states))>0]

        def simulate(self,agent, start_state, nb_steps, verbose=False):
                if verbose:
                    trajectory=[]
                    current_state = start_state
                    for _ in range(nb_steps):
                        action = agent.chose_action(current_state)
                        next_state, r = self.play(current_state,action)
                        trajectory.append((current_state, action,r, next_state))
                        current_state = next_state
                    return trajectory

                total_reward = 0
                current_state = start_state
                for i in range(nb_steps):
                       current_state, r=self.play(current_state,agent.chose_action(current_state))
                       total_reward += r * self.gamma**i
                return total_reward


        
                