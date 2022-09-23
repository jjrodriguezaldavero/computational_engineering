def pivotData(data):
    """Transforms the dataset into a pivot table"""
    import pandas as pd
    df = pd.read_csv(data, sep=',', header=None)
    df.columns = ['id_usuario','id_videojuego','puntos']
    df = df.pivot(index='id_usuario', columns='id_videojuego', values='puntos')
    return df

def analysisVG(data):
    """Analyses the dataset with respect to the users"""
    pivot = pivotData(data)
    minVJ = pivot.count(axis='rows').idxmin()
    minVal = pivot.count(axis='rows').min()
    maxVJ = pivot.count(axis='rows').idxmax()
    maxVal = pivot.count(axis='rows').max()
    meanVal = pivot.count(axis=0).sum()/pivot.shape[1]
    return f"""Min: {minVJ} with {minVal} ratings. Max: {maxVJ} with {maxVal} ratings. Average: {meanVal}."""