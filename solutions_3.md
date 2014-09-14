####Question 3####

>An ant is walking on the squares of a 5x5 grid - it starts in the center square.

>Each second, it will choose (with equal probability)
to do one of the following:

>- Move north one square
- Move south one square
- Move east one square
- Move west one square
- Do not move

>If it cannot perform the action it has decided on (move west while on the 
west edge, for example), it sits in place.

>After one second, it has a 20% chance of being in the center, and a 20% chance
of being in each adjacent square. (and a 0% chance of being in any
other square on the board).

>You may ignore floating point error accumulation.

The situation can be described as a discrete first order Markov chain: the state of the system at step t depends only on the state at step t-1.

In order to solve the following questions two different ruby implementations of an exact algorithm and a computational simulation have been tested. I will describe them briefly:

* **Exact Calculus**:

    This approach calculates the probability of a given state using the definition of markov first order function, this is that the probability of being in a given state in a given moment is the probability to change from the previous state to the current one times the probability of being in the previous step in the previous moment (both events should occur and they are independent), summed for all possible previous states. It is an analytical calculation and the associated error the one related with the floating point accumulations, which is small.

    Two different implementations of the same algorithm have been tried. 

    - The first one relies on a recursive function. Since it is written in ruby it is not performing Tail Call Optimization and therefore call stack grows too much for big time steps making the process extremely slow.

    - The seconds one uses a simple iteration to achieve the same purpose. That method is way faster than the previous one for big time steps.

* **Computational simulations**:

    Consists of a program that simulates an ant moving during a given amount of steps and also keeps track of the tile where it stoped. If that program is run enough times the probabilities for a given tile in a given time step can be estimated by counting how many ants ended up there and dividing that number by the total of ants that has been released. This method has an associated error that decreases with the number of repetitions.  

**1. What is the probability that the ant is on the center square after 15 seconds?**

In both cases, exact calculus and computational simulations, the result turns out to be the same: the **_probability is 0.04125_**. 

_Output from launcher.rb:_

```text
=== Results ===
First question:
     Analitical: 0.0412493
     Brute force (repetitions: 1000000): 0.041363
```

**2. What is the probability that the ant is on one of the outermost squares after 1 hour?**

The described system tends to an equilibrium since there are no privileged positions. One hour after it has been started the equilibrium is completely fulfilled and therefore the probabilities are the same for every tile, 1/total\_number\_of\_tiles. Taking into account that the board is 5x5 the **_result is 0.04_**. This hipothesis has been proved to be true by the simulations and computational calculus defined in the files inside the lib folder for this question.

_Output from launcher.rb:_

```text
=== Results ===
Second question:
     Analitical: 0.04
     Brute force (repetitions: 25000): 0.04244
```