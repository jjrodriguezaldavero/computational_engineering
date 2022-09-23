def importData(data):
    """Imports the data using Surprise methods"""
    import surprise as sp
    #Load the data
    read = sp.dataset.Reader(line_format='user item rating', sep=',')
    dataset = sp.dataset.Dataset.load_from_file(data, reader=read)
    return dataset

def prediccion2(data):
    """Calculates the RMSE for each algorithm over the cross-validation partitions"""
    import surprise as sp
    dataset = importData(data)
    #Creation of the different objects for each algorithm
    SVD = sp.SVD()
    KNNBasic = sp.KNNBasic()
    KNNWithMeans = sp.KNNWithMeans()
    NormalPredictor = sp.NormalPredictor()
    #Calculation of RMSE values for each partition
    cv_RMSE = [sp.model_selection.cross_validate(SVD, dataset, measures=['RMSE'], cv=5, verbose=False)['test_rmse'],
               sp.model_selection.cross_validate(KNNBasic, dataset, measures=['RMSE'], cv=5, verbose=False)['test_rmse'],
               sp.model_selection.cross_validate(KNNWithMeans, dataset, measures=['RMSE'], cv=5, verbose=False)['test_rmse'],
               sp.model_selection.cross_validate(NormalPredictor, dataset, measures=['RMSE'], cv=5, verbose=False)['test_rmse']]
    return cv_RMSE