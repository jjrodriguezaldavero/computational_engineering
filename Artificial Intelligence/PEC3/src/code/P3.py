import numpy as np
from random import sample
import random
import matplotlib.pyplot as plt
from deap import creator,base,tools,algorithms
import utils


def fulfill_constraints(a, b):
    def decorator(func):
        def wrapper(*args, **kargs):
            offspring = func(*args, **kargs)
            for child in offspring:
                
                #Here we create the new childs imposing the constraints
                new_child = np.array([c for c in child])
                for i in range(len(new_child)):
                    if new_child[i] > b:
                        new_child[i] = b
                    elif child[i] < a:
                        child[i] = a
                # offspring's child modification
                # TO DO: generate new_child[] according with the existing constraints

                #Here we would impose constraints on new_child
                
                # TO DO: replace each value child[i] with new_child[i]
                # Uncomment the following loop once you have new_child populated
                for i in range(0, len(child)):
                    child[i] = new_child[i]

                # Delete the following line once you have implemented your code
                pass

            return offspring
        return wrapper
    return decorator

seq = [i for i in range (0,999999)]
rand_urbanization_map = sample(seq,1000)

#print("Urbanization map: ", rand_urbanization_map)

# Implement GA. Prepare deap: initialization, definition of strategies


# Fitness creation and registration
creator.create('FitnessMin', base.Fitness, weights=(-1.0,))
#creator.create('FitnessMin', base.Fitness, weights=(-1.0,-0.8,-0.5,))
creator.create('Individual', list, fitness=creator.FitnessMin)


# GA initialization

toolbox = base.Toolbox()
IND_SIZE = 20
POP_SIZE = 4832
# EXERCISE 1a: fill in the third and fourth parameter, taking into account that we use tools.initRepeat subsequently.
toolbox.register('indices', random.sample, range(POP_SIZE), IND_SIZE)
toolbox.register('individual', tools.initIterate, creator.Individual,
                 toolbox.indices)

toolbox.register('population', tools.initRepeat, list, toolbox.individual)


# GA strategies definition

# Assign the objective function

objective_function = utils.fitness

# EXERCISE 1a: fill in the gaps. Check utils.fitness, as it is the objective_function.
# Check documentation on deap's tools.mutUniformInt
toolbox.register('evaluate', objective_function, urbanizations=rand_urbanization_map)
toolbox.register('mate', tools.cxTwoPoint)
toolbox.register('mutate', tools.mutUniformInt, low=0, up=4831 , indpb=0.2)
toolbox.register('select', tools.selTournament, tournsize=3)

# GA decoration
toolbox.decorate('mate', fulfill_constraints())
toolbox.decorate('mutate', fulfill_constraints())

#run the GA

##############
#Exercise 1b
#Try different values for the following variables
##############
N_POP = 10
N_GEN = 10
cx_prob = 0.2
mut_prob = 0.2
#######################
best_fits = []
for i in range(10):
    population = toolbox.population(N_POP)
    best_fitness_arr = []
    for gen in range(N_GEN):
    
        offspring = algorithms.varAnd(population, toolbox, cxpb=cx_prob, mutpb=mut_prob)
        fits = toolbox.map(toolbox.evaluate, offspring)
    
        for fit,ind in zip(fits, offspring):
            ind.fitness.values = fit
    
        population = toolbox.select(offspring, k=len(population))
        top = tools.selBest(population, k=1)
        fitness = objective_function(top[0], rand_urbanization_map)
        print(gen, fitness, list(map(utils.values_to_coords_stations, top[0])), top[0])
        best_fitness_arr.append(fitness[0])
    best_fits.append(best_fitness_arr[-1])

#x = list(range(N_GEN))
#plt.plot(x,best_fitness_arr)
#title = "Average multiobjective fitness\nN_POP: "+str(N_POP)+", N_GEN: "+str(N_GEN)+", cx_prob: "+str(cx_prob)+", mut_prob: "+str(mut_prob)
#plt.title(title)
#plt.show()
