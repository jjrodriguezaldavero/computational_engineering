def pivotData(data):
    """Transforms the dataset into a pivot table"""
    import pandas as pd
    df = pd.read_csv(data, sep=',', header=None)
    df.columns = ['id_usuario','id_videojuego','puntos']
    df = df.pivot(index='id_usuario', columns='id_videojuego', values='puntos')
    return df

def analysisUsers(data):
    """Analyses the dataset with respect to the videogames"""
    pivot = pivotData(data)
    minUser= pivot.count(axis='columns').idxmin()
    minVal = pivot.count(axis='columns').min()
    maxUser = pivot.count(axis='columns').idxmax()
    maxVal = pivot.count(axis='columns').max()
    meanVal = pivot.count(axis=0).sum()/(pivot.shape[0]*pivot.shape[1])
    return f"""Min: {minUser} with {minVal} ratings. Max: {maxUser} with {maxVal} ratings. Average: {meanVal}."""
