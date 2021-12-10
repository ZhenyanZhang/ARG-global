import joblib
import numpy as np
import pandas as pd
import sklearn
from sklearn import metrics
import joblib
import matplotlib.pyplot as plt
import matplotlib as mpl
path = "D:/onedrive/NCrevised/Global ocean data.xlsx"
data = pd.read_excel(path)  #reading data
name=list(data.columns.values)
Data=np.array(data)

forest=joblib.load("D:/onedrive/NCrevised/best_forest.pkl")
predict=forest.predict(Data)
print(Data.shape)
print(predict.shape)
Data_new=np.c_[Data,predict]
print(Data_new)
new_Data=pd.DataFrame(Data_new)
new_Data.to_excel(r'D:/onedrive/NCrevised/prediction results.xlsx',index=False,header=False)
#data=np.concatenate([Data,predict],axis=1)
#print(data.shape)