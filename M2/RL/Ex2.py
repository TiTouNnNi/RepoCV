from MDP import MDP
from Visualize_MDP import mdp_display
from Agent import Agent

tp_1 = {(0, 0,1):1,
        (0,1,0):1,
        (1,0,1):1,
        (1,1,0):1}

rw_1 = {(0,0):1,
        (0,1):0,
        (1,0):2,
        (1,1):1}

mdp_1 = MDP(2,2, tp_1, rw_1)

#mdp_display(mdp_1)

agent = Agent(mdp_1.nb_states,mdp_1.nb_actions,None)

mdp_1.simulate(agent, 0, nb_steps=10, verbose=True)