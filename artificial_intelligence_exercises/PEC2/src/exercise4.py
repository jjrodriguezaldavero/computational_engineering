def importData(data):
    import numpy as np
    array = np.genfromtxt(data, delimiter=',', dtype='unicode') #We do this to keep the tags column
    dataset = array[:,:-1].astype(float)
    tags = array[:, -1]
    return dataset, tags

def classifySVM(data, ker, cVal):
    """
    Finds the score, training time and prediction time for the SVM classificator for different hyperparameter values
    """
    from sklearn.svm import SVC
    from sklearn.model_selection import cross_validate
    X, y = importData(data) #Falta separar la última columna
    model = SVC(C = cVal, kernel=ker)
    #Cross-validation calculations
    cv_results = cross_validate(model, X, y, cv=5)
    test_score = cv_results['test_score']
    fit_time = cv_results['fit_time']
    score_time = cv_results['score_time']
    #Return outputs
    return test_score.mean(), test_score.std(), fit_time.mean(), fit_time.std(), score_time.mean(), score_time.std()