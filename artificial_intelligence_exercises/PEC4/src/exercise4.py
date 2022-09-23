#NOTE: This function has to be used in conjunction with the other exercises, 
#by running the models and then running this function afterwards.

def load_cifar10():
    import tensorflow as tf
    cifar10 = tf.keras.datasets.cifar10.load_data()
    x_train = cifar10[0][0]
    y_train = cifar10[0][1]
    x_test = cifar10[1][0]
    y_test = cifar10[1][1]
    return x_train, y_train, x_test, y_test

def characteristic_map(model, layer_name, image_n=0):
    import numpy as np
    from keras.models import Model
    model_2 = Model(inputs=model.input, outputs=model.get_layer(layer_name).output)
    x_train = load_cifar10()
    img = x_train[image_n]
    img = np.expand_dims(img, axis=0)
    conv2d_features = model_2.predict(img)
    print(conv2d_features.shape)
    
    import matplotlib.pyplot as plt
    square = 8
    ix = 1
    for _ in range(square):
        for _ in range(square):
            ax = plt.subplot(square, square, ix)
            ax.set_xticks([])
            ax.set_yticks([])
            plt.imshow(conv2d_features[0, :, :, ix-1], cmap='gray')
            ix += 1
    plt.show()