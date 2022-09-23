import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

def importData(data):
    from numpy import genfromtxt
    array = genfromtxt(data, delimiter=' ')
    return array

def chunks(lst, n):
    """Yield successive n-sized chunks from lst."""
    for i in range(0, len(lst), n):
        yield lst[i:i + n]
   

labels = ["moving_average_botpt_1.txt","moving_average_botpt_10.txt","moving_average_botpt_15.txt","moving_average_botpt_20.txt","moving_average_botpt_50.txt","moving_average_botpt_100.txt"]
#labels = ["moving_average_1542p_1.txt", "moving_average_1542p_100.txt"]
for i in range(len(labels)):
    datos = importData(labels[i])
    df = pd.Series(datos)
    df = df[df.between(df.quantile(0.1), df.quantile(.99))]
    plt.plot(df)
plt.legend(labels)
plt.show()
#lists = list(chunks(importData(data), 1000))
#for i in range(len(lists)):
#    plt.plot(lists[i])
#plt.show()
