def pivotData(data):
    """Transforms the dataset into a pivot table"""
    import pandas as pd
    df = pd.read_csv(data, sep=',', header=None)
    df.columns = ['id_usuario','id_videojuego','puntos']
    df = df.pivot(index='id_usuario', columns='id_videojuego', values='puntos')
    return df

def simPearson2(data):
    """Calculates closest users using Pearson correlation on all values except those missing in both users"""
    import numpy as np
    from scipy.spatial import distance
    pivot = pivotData(data).reset_index(drop=True).transpose()
    pMax = 0
    iMax = 0
    jMax = 0
    for i in range(pivot.shape[1]):
        print(i)
        for j in range(i):
            a = pivot[i].reset_index(drop=True)
            b = pivot[j].reset_index(drop=True)
            for k in range(a.shape[0]):
                if np.isnan(a[k]) and np.isnan(b[k]):
                    a=a.drop([k])
                    b=b.drop([k])
            a = a.fillna(2.5)
            b = b.fillna(2.5)
            d = 1 - distance.correlation(a,b)
            if d > pMax and i != j:
                pMax = d
                iMax = i
                jMax = j
                print([pMax, iMax, jMax])
    return [pMax, iMax, jMax]
            