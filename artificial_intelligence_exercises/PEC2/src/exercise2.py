def importData(data):
    from numpy import genfromtxt
    array = genfromtxt(data, delimiter=',')
    dataset = array[:,:-1]
    return dataset

def multidimensionalScaling(data):
    dataset = importData(data)
    from sklearn.manifold import MDS
    import matplotlib.pyplot as plt
    mds = MDS(n_components=2)
    mds_1 = mds.fit_transform(dataset)
    mds_2 = mds.fit_transform(dataset)
    mds_3 = mds.fit_transform(dataset)
    plt.scatter(x=mds_1[:, 0], y=mds_1[:, 1], color='Red')
    plt.scatter(x=mds_2[:, 0], y=mds_2[:, 1], color = 'Blue')
    plt.scatter(x=mds_3[:, 0], y=mds_3[:, 1], color = 'Green')
    plt.title('Scatter plot MDS')
    plt.xlabel('First component of each embedding')
    plt.ylabel('Second component of each embedding')
    plt.show()
    