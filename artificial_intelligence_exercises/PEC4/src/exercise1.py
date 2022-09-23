
def load_cifar10():
    import tensorflow as tf
    cifar10 = tf.keras.datasets.cifar10.load_data()
    x_train = cifar10[0][0]
    y_train = cifar10[0][1]
    x_test = cifar10[1][0]
    y_test = cifar10[1][1]
    return x_train, y_train, x_test, y_test

def inspect_images(X, y, n_image=0, titles = None, columns=5):
    import numpy as np
    import matplotlib.pyplot as plt
    mapping = {}
    for i in np.unique(y):
        mapping[i] = np.where(y == i)[0]
    l = len(mapping) #Número de clases
    if titles == None:
        titles = ["Unknown"]*l
    images = []
    for j in range(l):
        images.append(X[mapping[j][n_image]])
    for k, image in enumerate(images):
        plt.subplot(len(images) / columns + 1, columns, k + 1)
        plt.axis('off')
        plt.title(str(k) + ' ' + titles[k])
        plt.imshow(image)
        

def inspect_image(X, y, n_class, n_images=10, title = None, columns=5):
    import numpy as np
    import matplotlib.pyplot as plt
    import random
    if title == None:
        title = "Unknown"
    indices = np.where(y==n_class)[0]
    images = []
    for j in range(n_images):
        images.append(X[random.choice(indices)])
    for k, image in enumerate(images):
        plt.subplot(len(images) / columns + 1, columns, k + 1)
        plt.axis('off')
        plt.title(str(k))
        plt.imshow(image)
    plt.suptitle(title)
        

    
        
        



