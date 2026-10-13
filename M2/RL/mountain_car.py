"""Load policy.pkl and test the policy in Gymnasium MountainCar-v0."""

import pickle

import gymnasium as gym
import tqdm

from mdp_mountain_car import (
    DISCRETIZATION_POSITION,
    DISCRETIZATION_VELOCITY,
    RANDOM_SEED,
    discretize,
)

POLICY_FILE = "policy.pkl"
NUMBER_OF_EPISODES = 10


with open(POLICY_FILE, "rb") as file:
    policy_mountain_car = pickle.load(file)


class AlwaysPushRightAgent:
    """Baseline agent: always push the car to the right."""

    def act(self, observation):
        return 2


class ValueIterationAgent:
    """Agent using the policy computed in mdp_mountain_car.py."""

    def __init__(self, policy):
        self.policy = policy

    def act(self, observation):
        position, velocity = observation
        state = discretize(
            position,
            velocity,
            (DISCRETIZATION_POSITION, DISCRETIZATION_VELOCITY),
        )
        return self.policy[state]


def run_episode(env, agent, seed=None):
    observation, info = env.reset(seed=seed)
    total_reward = 0.0

    for step in tqdm.trange(1, env.spec.max_episode_steps + 1):
        action = agent.act(observation)
        observation, reward, terminated, truncated, info = env.step(action)
        total_reward += reward

        if terminated or truncated:
            return step, total_reward, terminated

    return step, total_reward, False


if __name__ == "__main__":
    # Change this line to compare against AlwaysPushRightAgent().
    agent = ValueIterationAgent(policy_mountain_car)

    env = gym.make("MountainCar-v0", render_mode="human")
    try:
        successes = 0
        for episode in range(NUMBER_OF_EPISODES):
            steps, total_reward, success = run_episode(
                env, agent, seed=RANDOM_SEED + episode
            )
            successes += int(success)
            print(
                f"Episode {episode + 1}: {steps} steps, "
                f"reward={total_reward:.0f}, success={success}"
            )

        print(f"Successes: {successes}/{NUMBER_OF_EPISODES}")
    finally:
        env.close()
