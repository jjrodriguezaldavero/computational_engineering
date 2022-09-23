def importData(data):
    from numpy import genfromtxt
    array = genfromtxt(data, delimiter=',')
    dataset = array[:,:-1]
    return dataset

def findComponents(data, var_cutoff): 
    """
    Finds the number of components needed to reach var_cutoff variance
    """
    from sklearn.decomposition import PCA
    dataset = importData(data)
    pca = PCA().fit(dataset)
    var_vector = pca.explained_variance_ratio_.cumsum()
    n_components = 0
    variance = 0
    for i in range(len(var_vector)):
        if var_vector[i] > var_cutoff:
            n_components = i
            variance = var_vector[i]
            break
    return n_components, variance

def inverseTransform(data, n_components):
    """
    Finds the inverse transformation of the dataset for n principal components and the loss of information
    """
    from sklearn.decomposition import PCA
    import numpy as np
    dataset = importData(data)
    pca = PCA(n_components)
    reconstructed_dataset = pca.inverse_transform(pca.fit_transform(dataset))
    loss = np.mean(dataset ** 2 - reconstructed_dataset ** 2)
    return dataset, reconstructed_dataset, loss

def fitTransform(data, n_components):
    """
    Finds the PCA transform for n_components and plots the original and the transformed dataset
    """
    from sklearn.decomposition import PCA
    import matplotlib.pyplot as plt
    dataset = importData(data)
    pca = PCA(n_components)
    transformed_dataset = pca.fit_transform(dataset)
    plt.scatter(x=transformed_dataset[:, 0], y=transformed_dataset[:, 1], color='Red')
    plt.scatter(x=dataset[:, 0], y=dataset[:, 1], color = 'Blue')
    plt.title('Scatter plot PCA')
    plt.xlabel('First component of each dataset')
    plt.ylabel('Second component of each dataset')
    plt.show()
