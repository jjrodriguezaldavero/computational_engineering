def importData(data):
    """Imports the data using Surprise methods"""
    import surprise as sp
    #Load the data
    read = sp.dataset.Reader(line_format='user item rating', sep=',')
    dataset = sp.dataset.Dataset.load_from_file(data, reader=read)
    return dataset

def prediccion1(data, user, videogame):
    """
    Predicts the rating of U098 on V077 using SVD, KNNBasic, KNNWithMeans and NormalPredictor.
    """
    import surprise as sp
    dataset = importData(data)
    trainset = dataset.build_full_trainset()
    #Creation of the different objects for each algorithm
    SVD = sp.SVD().fit(trainset)
    KNNBasic = sp.KNNBasic().fit(trainset)
    KNNWithMeans = sp.KNNWithMeans().fit(trainset)
    NormalPredictor = sp.NormalPredictor().fit(trainset)
    #Calculate predictions
    preds = [SVD.predict(user, videogame, r_ui=4, verbose=True),
             KNNBasic.predict(user, videogame, r_ui=4, verbose=True),
             KNNWithMeans.predict(user, videogame, r_ui=4, verbose=True),
             NormalPredictor.predict(user, videogame, r_ui=4, verbose=True)]
    return preds

