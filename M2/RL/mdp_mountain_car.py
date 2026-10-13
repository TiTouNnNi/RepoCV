"""Discretize MountainCar, solve the resulting MDP, and save its policy.
   complete the four TODO blocks.
"""

import logging
import pickle
from collections import defaultdict

import numpy as np
import tqdm

logging.basicConfig(level=logging.INFO)

DISCRETIZATION_POSITION = 15
DISCRETIZATION_VELOCITY = 10
NUM_ITERATIONS = 1000
NUMBER_OF_SAMPLES = 100
GAMMA = 0.99
TOLERANCE = 1e-6
RANDOM_SEED = 42

MIN_POSITION = -1.2
GOAL_POSITION = 0.5
MAX_PHYSICAL_POSITION = 0.6
MIN_VELOCITY = -0.07
MAX_VELOCITY = 0.07

# Positions greater than or equal to GOAL_POSITION are represented by one
# separate absorbing state. All other discrete states are (position, velocity).
TERMINAL_STATE = "terminal"


def discretize_position(position, n):
    """Map a non-terminal position to one of n bins numbered 0, ..., n-1."""
    edges = np.linspace(MIN_POSITION, GOAL_POSITION, n + 1)
    position = np.clip(position, MIN_POSITION, np.nextafter(GOAL_POSITION, -np.inf))
    return min(np.searchsorted(edges, position, side="right") - 1, n - 1)


def discretize_velocity(velocity, n):
    """Map a velocity to one of n bins numbered 0, ..., n-1."""
    edges = np.linspace(MIN_VELOCITY, MAX_VELOCITY, n + 1)
    velocity = np.clip(velocity, MIN_VELOCITY, MAX_VELOCITY)
    return min(np.searchsorted(edges, velocity, side="right") - 1, n - 1)


def discretize(position, velocity, discretization):
    """Map a continuous non-terminal observation to a discrete state."""
    return (
        discretize_position(position, discretization[0]),
        discretize_velocity(velocity, discretization[1]),
    )


def sample_position_from_discretized(position_index, n, rng):
    """Sample uniformly inside a discrete non-terminal position bin."""
    edges = np.linspace(MIN_POSITION, GOAL_POSITION, n + 1)
    return rng.uniform(edges[position_index], edges[position_index + 1])


def sample_velocity_from_discretized(velocity_index, n, rng):
    """Sample uniformly inside a discrete velocity bin."""
    edges = np.linspace(MIN_VELOCITY, MAX_VELOCITY, n + 1)
    return rng.uniform(edges[velocity_index], edges[velocity_index + 1])


def map_state_to_continuous(state, discretization, rng):
    """Sample one continuous state represented by a non-terminal cell."""
    return (
        sample_position_from_discretized(state[0], discretization[0], rng),
        sample_velocity_from_discretized(state[1], discretization[1], rng),
    )


def compute_next_state(position, velocity, action):
    """Apply the deterministic MountainCar dynamics once."""
    new_velocity = velocity + 0.001 * (action - 1) - 0.0025 * np.cos(3 * position)
    new_velocity = np.clip(new_velocity, MIN_VELOCITY, MAX_VELOCITY)
    new_position = np.clip(
        position + new_velocity, MIN_POSITION, MAX_PHYSICAL_POSITION
    )

    # The left wall stops the car.
    if new_position <= MIN_POSITION and new_velocity < 0:
        new_velocity = 0.0

    return float(new_position), float(new_velocity)


class MDP:
    def __init__(
        self,
        discretization=(DISCRETIZATION_POSITION, DISCRETIZATION_VELOCITY),
        num_samples=NUMBER_OF_SAMPLES,
        gamma=GAMMA,
        seed=RANDOM_SEED,
    ):
        self.gamma = gamma
        self.discretization = discretization
        self.discretization_position = discretization[0]
        self.discretization_velocity = discretization[1]
        self.number_of_samples = num_samples
        self.rng = np.random.default_rng(seed)

        non_terminal_states = {
            (i, j)
            for i in range(self.discretization_position)
            for j in range(self.discretization_velocity)
        }
        self.states = non_terminal_states | {TERMINAL_STATE}
        self.actions = [0, 1, 2]

        logging.info("Computing transition probabilities")
        self.transition_probabilities = self.compute_transition_probabilities()
        logging.info("Transition probabilities computed")

        logging.info("Computing rewards")
        self.rewards = self.compute_rewards()
        logging.info("Rewards computed")

    def compute_transition_probabilities(self):
        """Estimate P[(state, action, next_state)] by Monte Carlo sampling."""
        transition_probabilities = defaultdict(float)

        # TODO 1
        # For every non-terminal (state, action):
        #   1. sample self.number_of_samples continuous states in the cell;
        #   2. apply compute_next_state;
        #   3. use TERMINAL_STATE if new_position >= GOAL_POSITION,
        #      otherwise discretize the new continuous state;
        #   4. count the resulting next states and normalize the counts.
        # Also make TERMINAL_STATE absorbing for every action:
        # P[(TERMINAL_STATE, action, TERMINAL_STATE)] = 1.
        for s in self.states:
            for a in self.actions:
                if s==TERMINAL_STATE:
                    transition_probabilities[s,a,TERMINAL_STATE] = 1.
                    continue
                #On estime les probabilités de transition
                for _ in range(self.number_of_samples):
                    p, v=map_state_to_continuous(s, self.discretization, self.rng)
                    np, nv = compute_next_state(p,v,a)
                    if np >= GOAL_POSITION:
                        new_state = TERMINAL_STATE
                    else:
                        new_state = discretize(np,nv,self.discretization)
                    transition_probabilities[s,a,new_state] += 1. / self.number_of_samples 

        return transition_probabilities

    def compute_rewards(self):
        """Construct R[(state, action, next_state)]."""
        rewards = defaultdict(lambda: -1.0)

        # TODO 2
        # Our teaching convention is:
        #   -1 for every non-terminal transition;
        #    0 for a transition reaching TERMINAL_STATE;
        #    0 for the absorbing self-loop of TERMINAL_STATE.
        # Store the required entries in rewards using keys (s, a, sp).
        for s in self.states:
            for a in self.actions:
                if s==TERMINAL_STATE:
                    rewards[s,a,TERMINAL_STATE] = 1.
                for sp in self.states:
                    if sp == TERMINAL_STATE: 
                        rewards[s,a,sp] = 1.
                    else:
                        rewards[s,a,sp] = 0.
        return rewards

    def check_transition_probabilities(self):
        """Raise an error unless every P(. | s, a) sums to one."""
        for state in self.states:
            for action in self.actions:
                total = sum(
                    self.transition_probabilities[state, action, next_state]
                    for next_state in self.states
                )
                if not np.isclose(total, 1.0):
                    raise ValueError(
                        f"P(. | {state}, {action}) sums to {total}, not 1."
                    )


def value_iteration(mdp, num_iterations=NUM_ITERATIONS, tolerance=TOLERANCE):
    """Return an approximation of the optimal value function."""
    V = {state: 0.0 for state in mdp.states}

    # TODO 3
    # Implement synchronous Value Iteration:
    #   - compute a new dictionary new_V using only values from V;
    #   - keep V[TERMINAL_STATE] equal to zero;
    #   - stop after num_iterations, or earlier when
    #         max_s |new_V[s] - V[s]| < tolerance.
    # tqdm.trange(num_iterations) may be used to display progress.
    S = mdp.states
    A = mdp.actions
    P = mdp.transition_probabilities
    R = mdp.rewards
    G = mdp.gamma

    V = {s:0 for s in S}

    for _ in tqdm.trange(num_iterations):
        new_V = {}
        #V = {s:max(sum(P[s, a, sp]*(R[s,a,sp]+GAMMA*V[sp])for sp in S) for a in A) for s in S}
        for s in S:
            if s == TERMINAL_STATE:
                new_V[s] = 0.
                continue
            new_V[s] = max(sum(P[s, a, sp]*(R[s,a,sp]+G*V[sp])for sp in S) for a in A)
        V = new_V
    return V

    #for s in S:
    #    for a in A:
    #        somme = 0
    #        for sp in S:
    #            somme = P[s,a,sp]*(R[s,a,sp]+GAMMA*V[sp]) # pas logique
    #return V

def get_policy(mdp, V):
    """Return a policy greedy with respect to V."""
    policy = {}
    S = mdp.states
    A = mdp.actions
    P = mdp.transition_probabilities
    R = mdp.rewards
    G = mdp.gamma

    # TODO 4
    # For each non-terminal state, compute the expected return of every
    # action and select an action maximizing it. np.argmax can be used.
    # The terminal state does not need an action in the saved policy.
    for s in S:
        if s == TERMINAL_STATE:
            continue
        policy[s] = max(A, key=lambda a:sum(P[s, a, sp]*(R[s,a,sp]+G*V[sp])for sp in S))
    return policy


if __name__ == "__main__":
    logging.info("Computing the discretized MDP")
    mdp = MDP()
    mdp.check_transition_probabilities()

    logging.info("Running Value Iteration")
    V = value_iteration(mdp)

    logging.info("Extracting the greedy policy")
    policy_mountain_car = get_policy(mdp, V)

    with open("policy.pkl", "wb") as file:
        pickle.dump(policy_mountain_car, file)
    logging.info("Policy saved to policy.pkl")
