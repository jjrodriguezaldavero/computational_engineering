#utils.py
#support file

import numpy as np

N_STATIONS=20
N_LOCATIONS=4832

tl_locations_map = np.loadtxt("../transmissionLines_SonomaNapa_1000.txt")
#Analizar esta función
stations_locations = list( filter( lambda x: x[1] > 0, [ (index, x) for index, x in np.ndenumerate(tl_locations_map)] ) )
#Lo que hace es dar las ubicaciones de todas las posibles localizaciones en una lista de coordenadas (tuplas)

# Just for debugging purposes
# print("### UTILS - Stations locations: ", stations_locations)

# translate values in a 1D array to the corresponding coords in a [dimX,dimY] matrix
def values_to_coords(n, dimX=1000, dimY=1000):
    if n >= dimX*dimY or n < 0:
        raise Exception('n out of bounds')
    else:
        x = n // dimX
        y = n % dimY

        return (x,y)

# get the corresponding coords of stations_locations in a [dimX,dimY] matrix
def values_to_coords_stations(n):
    if n >= N_LOCATIONS or n < 0:
        raise Exception('n out of bounds: '+str(n))
    else:
        return stations_locations[n][0]

def avg_distance(individual, urbanizations):

    urbanizations_coords = list(map(values_to_coords, urbanizations))
    np_urbanizations_coords = np.asarray(urbanizations_coords)

    # Get np_stations_coords from individual
    stations_coords = list(map(values_to_coords_stations, individual))
    np_stations_coords = np.asarray(stations_coords)

    distances = [np.linalg.norm(d - s) for d in np_urbanizations_coords[0:1000] for s in np_stations_coords[0:50]]

    # Return average value of distances
    return np.mean(distances)

def stdev_distance(individual, urbanizations):

    ##############
    # Exercise 2
    # Define your function
    ##############

    #TO DO: Return stdev value of distances (check numpy documentation)
    urbanizations_coords = list(map(values_to_coords, urbanizations))
    np_urbanizations_coords = np.asarray(urbanizations_coords)

    # Get np_stations_coords from individual
    stations_coords = list(map(values_to_coords_stations, individual))
    np_stations_coords = np.asarray(stations_coords)

    distances = [np.linalg.norm(d - s) for d in np_urbanizations_coords[0:1000] for s in np_stations_coords[0:50]]

    # Return average value of distances
    return np.std(distances)

def avg_distance_to_main(individual, urbanizations):

    ##############
    # Exercise 2
    # Define your function
    ##############

    #TO DO: Return average value of distances
    urbanizations_coords = list(map(values_to_coords, urbanizations))
    np_urbanizations_coords = np.asarray(urbanizations_coords)

    # Get np_stations_coords from individual
    stations_coords = list(map(values_to_coords_stations, individual))
    np_stations_coords = np.asarray(stations_coords)

    distances = [np.linalg.norm(s) for d in np_urbanizations_coords[0:1000] for s in np_stations_coords[0:50]]

    # Return average value of distances
    return np.mean(distances)

def fitness(individual, urbanizations):

    return avg_distance(individual, urbanizations), #valor original
    #return avg_distance(individual, urbanizations), + stdev_distance(individual, urbanizations), + avg_distance_to_main(individual, urbanizations),