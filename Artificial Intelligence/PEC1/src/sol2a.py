def pivotData(data):
    """Transforms the dataset into a pivot table"""
    import pandas as pd
    df = pd.read_csv(data, sep=',', header=None)
    df.columns = ['id_usuario','id_videojuego','puntos']
    df = df.pivot(index='id_usuario', columns='id_videojuego', values='puntos')
    return df

def simEuclidean1(data):
    """Calculates closest users using Euclidean similarity only on shared values"""
    import numpy as np
    from scipy.spatial import distance
    pivot = pivotData(data).reset_index(drop=True).transpose()
    dMax = 100
    iMax = 0
    jMax = 0
    for i in range(pivot.shape[1]):
        print(i)
        for j in range(i):
            a = pivot[i].reset_index(drop=True)
            b = pivot[j].reset_index(drop=True)
            for k in range(a.shape[0]):
                if np.isnan(a[k]) or np.isnan(b[k]):
                    a=a.drop([k])
                    b=b.drop([k])
            d = distance.euclidean(a,b)
            if d < dMax and i != j:
                dMax = d
                sMax = 1 / (1 + dMax)
                iMax = i
                jMax = j
                print([dMax, sMax, iMax, jMax])
    return [dMax, sMax, iMax, jMax]
            