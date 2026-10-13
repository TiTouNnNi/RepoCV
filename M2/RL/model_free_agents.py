import numpy as np
import random
from grid_world_MF import GridWorldMDP

class MyGridWorld(GridWorldMDP):
    def __init__(self, height, width, number_of_holes, gamma=0.9):
        super().__init__(height, width, number_of_holes) 
        self.gamma = gamma
        self.n_states = width * height
        self.n_actions = 4

    def reset(self):
        return self.initial_state
    
    def play(self, state, action):
        #if state == self.terminal_state or state in self.bad_states:
        #    return state, 0
        new_state = (state[0] + action[0], state[1] + action[1])
        if new_state not in self.states:
            new_state = state
        reward = self.rewards[(state, action, new_state)]
        return new_state, reward
        
class MonteCarloAgent():
   def __init__(self, env, gamma, epsilon=.1):
        self.env = env
        self.gamma = gamma
        self.epsilon = epsilon
        self.policy = {s: random.choice(env.actions) for s in env.states}       
        self.V = {s: 0 for s in env.states}        
        self.N = {s: 0 for s in env.states} 
        self.Q = {(s, a): 0 for s in env.states for a in env.actions}
        self.Nsa = {(s, a): 0 for s in env.states for a in env.actions}
        
   def generate_trajectory(self):
        trajectory = []
        state = self.env.reset()
        while state != self.env.terminal_state:
            if np.random.rand()<self.epsilon:
                action = random.choice(self.env.actions)
            else:
                action = self.policy[state]
            new_state, reward = self.env.play(state,action)
            trajectory.append((state, action, reward))
            state = new_state
        return trajectory
   
   def update(self, trajectory):
        G = 0
        for(s, a ,r) in reversed(trajectory):
                G = r + self.gamma * G
                self.N[s] += 1
                self.V[s] += (G - self.V[s]) / self.N[s]
                self.Nsa[(s,a)] += 1
                self.Q[(s,a)] += (G - self.Q[(s,a)]) / self.Nsa[(s,a)]
                self.policy[s] = max(self.env.actions, key=lambda a: self.Q[(s,a)])
        pass
   
   def train(self, n_episodes):
        # To complete
        for _ in range(n_episodes):
            self.update(self.generate_trajectory())
        pass
      
class SARSAAgent():
    def __init__(self, env, gamma, epsilon=.1, alpha=.1):
        self.env = env
        self.gamma = gamma
        self.epsilon = epsilon
        self.alpha = alpha
        self.Q = {(s, a): 0.0 for s in env.states for a in env.actions}

    def choose_action(self,state):
        if np.random.rand() < self.epsilon:
            return random.choice(self.env.actions)
        return max(self.env.actions, key=lambda a: self.Q[state,a])

    def train(self, n_episodes):
        # To complete
        for _ in range(n_episodes):
            state = self.env.reset()
            action = self.choose_action(state)
            while state != self.env.terminal_state:
                new_state, reward = self.env.play(state,action)
                if new_state == self.env.terminal_state:
                    target = reward
                    self.Q[(state, action)] += self.alpha * (target - self.Q[(state, action)])
                    break
                next_action = self.choose_action(new_state)
                if action is None:
                    target = reward
                else:
                    target = reward + self.gamma * self.Q[new_state,next_action]
                self.Q[state,action] += self.alpha*(target - self.Q[state,action])
                state = new_state
                action = next_action

    def policy(self):
        # To complete
        return {s: max(self.env.actions, key=lambda a: self.Q[s,a]) for s in self.env.states}
        
class QAgent():
    def __init__(self, env, gamma, epsilon=.1, alpha=.1):
        self.env = env
        self.gamma = gamma
        self.epsilon = epsilon
        self.alpha = alpha
        self.Q = {(s,a): 0 for s in env.states for a in env.actions}
        #np.zeros((env.n_states, env.n_actions))
        
    def choose_action(self,state):
        if np.random.rand() < self.epsilon:
            return random.choice(self.env.actions)
        best_value = max(self.Q[state,a] for a in self.env.actions)
        best_action = [a for a in self.env.actions if self.Q[state,a] == best_value]
        return random.choice(best_action) 
        #max(self.env.actions, key=lambda a: self.Q[state,a])


    def update(self, trajectory):
        for s,a,r,sp,ap in trajectory:
            self.Q[s,a] += self.alpha*(r+self.gamma*np.argmax(sp,ap)-self.Q[s,a])

    def train(self, n_episodes):
        S =self.env.states
        A = self.env.actions
        gamma = self.gamma
        alpha = self.alpha
        s = self.env.reset()
        a = self.choose_action(s)
        for _ in range(n_episodes):
            sp, r = self.env.play(s,a)
            if sp == self.env.terminal_state:
                target = r
                self.Q[s,a] += alpha*(target-self.Q[s,a])
                s = self.env.reset()
                a = self.choose_action(s)
                continue
            ap = self.choose_action(sp)
            best_next_action = max(A, key=lambda a: self.Q[sp,a])
            target = r + gamma*self.Q[sp,best_next_action]
            self.Q[s,a] += alpha*(target-self.Q[s,a])
            s, a = sp, ap
            

    def policy(self):
        return {s: max(self.env.actions, key=lambda a: self.Q[s,a]) for s in self.env.states}
   

if __name__=="__main__":
    env = MyGridWorld(4, 4, 4)
    print('___________________________')
    env.print_board()
    print('Monte Carlo: ')
    agent = MonteCarloAgent(env, gamma=env.gamma)
    t = agent.generate_trajectory()
    #print(t)
    #env.print_policy(env.policy_id_to_state(agent.policy))
    agent.train(1000)
    env.print_policy(agent.policy)
    #print(agent.policy)
    # print('___________________________')
    print('SARSA: ')
    agent = SARSAAgent(env, gamma=env.gamma)
    agent.train(100)
    print(agent.policy())
    env.print_policy(agent.policy())
    print('___________________________')
    print('Q Learning: ')
    agent = QAgent(env, gamma=env.gamma)
    agent.train(100000)
    print(agent.policy())
    env.print_policy(agent.policy())

