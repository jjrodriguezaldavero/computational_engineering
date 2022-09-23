from keras.applications import vgg16
import keras
import time

def load_cifar10():
    import tensorflow as tf
    cifar10 = tf.keras.datasets.cifar10.load_data()
    x_train = cifar10[0][0]
    y_train = cifar10[0][1]
    x_test = cifar10[1][0]
    y_test = cifar10[1][1]
    return x_train, y_train, x_test, y_test

x_train, y_train, x_test, y_test = load_cifar10()

batch_size = 32
num_classes = 10
epochs = 2

y_train = keras.utils.to_categorical(y_train, num_classes)
y_test = keras.utils.to_categorical(y_test, num_classes)

vgg16_model = vgg16.VGG16(include_top=True, weights=None, input_tensor=None, input_shape=(32,32,3), classes=num_classes)
vgg16_model.compile(loss='categorical_crossentropy', optimizer='sgd', metrics=['acc', 'mse'])  
vgg16_model.summary()

start_time = time.time()
vgg16 = vgg16_model.fit(x=x_train, y=y_train, batch_size=batch_size, epochs=epochs, verbose=1, validation_data=(x_test, y_test), shuffle=True)  
end_time = time.time()
elapsed_time = end_time - start_time
print('Elapsed time: ' + str(elapsed_time))