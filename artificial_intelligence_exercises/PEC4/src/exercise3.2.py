from sklearn.svm import LinearSVC
from sklearn.model_selection import cross_validate

def load_cifar10():
    import tensorflow as tf
    cifar10 = tf.keras.datasets.cifar10.load_data()
    x_train = cifar10[0][0]
    y_train = cifar10[0][1]
    x_test = cifar10[1][0]
    y_test = cifar10[1][1]
    return x_train, y_train, x_test, y_test

def process_features_vgg16(data):
    from keras.applications.vgg16 import VGG16
    import numpy as np
    from tensorflow.keras.applications.vgg16 import preprocess_input
    
    model = VGG16(include_top=False, weights='imagenet')
    preprocess_data = preprocess_input(data)
    features = np.reshape(model.predict(preprocess_data), (data.shape[0], 512))
    return features, model

def select_features(features, labels):
    from sklearn.feature_selection import SelectKBest, chi2
    selector = SelectKBest(chi2, k=100)
    selector.fit(features, labels)
    return selector

#####################################################################



x_train, y_train, x_test, y_test = load_cifar10()

features = process_features_vgg16(x_train)
selector = select_features(process_features_vgg16(x_train), y_train)
x_train = selector.transform(process_features_vgg16(x_train))
x_test = selector.transform(process_features_vgg16(x_test))

SVM = LinearSVC(C = 0.025)
SVM.fit(x_train, y_train)

cv_results = cross_validate(SVM, x_test, y_test, cv=5)
test_score = cv_results['test_score']
fit_time = cv_results['fit_time']
score_time = cv_results['score_time']