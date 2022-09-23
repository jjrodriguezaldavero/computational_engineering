def importData(data):
    import numpy as np
    array = np.genfromtxt(data, delimiter=',', dtype='unicode') #We do this to keep the tags column
    dataset = array[:,:-1].astype(float)
    tags = array[:, -1]
    return dataset, tags

def classifyKNN(data, n_neighbors):
    """
    Finds the score, training time and prediction time for the kNN classificator
    """
    from sklearn.neighbors import KNeighborsClassifier
    from sklearn.model_selection import cross_validate
    X, y = importData(data)
    #Defining the model
    model = KNeighborsClassifier(n_neighbors)
    #Cross-validation calculations
    cv_results = cross_validate(model, X, y, cv=5)
    test_score = cv_results['test_score']
    fit_time = cv_results['fit_time']
    score_time = cv_results['score_time']
    #Return outputs
    return test_score.mean(), test_score.std(), fit_time.mean(), fit_time.std(), score_time.mean(), score_time.std()

def classifySVM(data):
    """
    Finds the score, training time and prediction time for the SVM classificator with linear kernel
    """
    from sklearn.svm import LinearSVC
    from sklearn.model_selection import cross_validate
    X, y = importData(data) #Falta separar la última columna
    model = LinearSVC(C = 0.025)
    #Cross-validation calculations
    cv_results = cross_validate(model, X, y, cv=5)
    test_score = cv_results['test_score']
    fit_time = cv_results['fit_time']
    score_time = cv_results['score_time']
    #Return outputs
    return test_score.mean(), test_score.std(), fit_time.mean(), fit_time.std(), score_time.mean(), score_time.std()
    
def classifyDecisionTree(data):
    """
    Finds the score, training time and prediction time for the Decission Tree classificator
    """
    from sklearn.tree import DecisionTreeClassifier
    from sklearn.model_selection import cross_validate
    X, y = importData(data) #Falta separar la última columna
    model = DecisionTreeClassifier(max_depth = 5)
    #Cross-validation calculations
    cv_results = cross_validate(model, X, y, cv=5)
    test_score = cv_results['test_score']
    fit_time = cv_results['fit_time']
    score_time = cv_results['score_time']
    #Return outputs
    return test_score.mean(), test_score.std(), fit_time.mean(), fit_time.std(), score_time.mean(), score_time.std()
    
def classifyAdaBoost(data):
    """
    Finds the score, training time and prediction time for the AdaBoost classificator
    """
    from sklearn.ensemble import AdaBoostClassifier
    from sklearn.model_selection import cross_validate
    X, y = importData(data) #Falta separar la última columna
    model = AdaBoostClassifier()
    #Cross-validation calculations
    cv_results = cross_validate(model, X, y, cv=5)
    test_score = cv_results['test_score']
    fit_time = cv_results['fit_time']
    score_time = cv_results['score_time']
    #Return outputs
    return test_score.mean(), test_score.std(), fit_time.mean(), fit_time.std(), score_time.mean(), score_time.std()
    
def classifyGNB(data):
    """
    Finds the score, training time and prediction time for the Gaussian Naive Bayes classificator
    """
    from sklearn.naive_bayes import GaussianNB
    from sklearn.model_selection import cross_validate
    X, y = importData(data) #Falta separar la última columna
    model = GaussianNB()
    #Cross-validation calculations
    cv_results = cross_validate(model, X, y, cv=5)
    test_score = cv_results['test_score']
    fit_time = cv_results['fit_time']
    score_time = cv_results['score_time']
    #Return outputs
    return test_score.mean(), test_score.std(), fit_time.mean(), fit_time.std(), score_time.mean(), score_time.std()





    