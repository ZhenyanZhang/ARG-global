import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib as mpl
import sklearn
from sklearn.ensemble import RandomForestRegressor
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import confusion_matrix
import seaborn as sns
import time
from sklearn.preprocessing import OneHotEncoder
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
import joblib
#Set properties to prevent Chinese garbled characters
mpl.rcParams['font.sans-serif'] = [u'SimHei']
mpl.rcParams['axes.unicode_minus'] = False


#path="demo.xlsx"
path="D:/onedrive/NCrevised/ocean(k-mean).xlsx"

data=pd.read_excel(path)  #reading data
k=10
best_score=0
Data=np.array(data)
num_val_sample=len(Data)//k
feature_num=18
np.random.shuffle(Data)
sample=Data
x=sample[:,:-1]
#scaler=StandardScaler()
#x_st=scaler.fit_transform(x)
y=sample[:,-1]
best_score_list=[]
'''
encoder = OneHotEncoder()
encoder.fit(np.arange(1,9).reshape(-1, 1))
def one_hot_encode(x):
    return encoder.transform(np.array(x).reshape(-1, 1)).toarray()
y_data = one_hot_encode(y)
'''

forest=RandomForestClassifier(n_estimators=20)
forest.fit(x,y)
forest_score=forest.score(x,y.astype('int'))
print(forest_score)

joblib.dump(forest,"D:/onedrive/NCrevised/best_forest.pkl")
for i in range(k):
    x_test=Data[i*num_val_sample:(i+1)*num_val_sample,0:feature_num]
    y_test=Data[i*num_val_sample:(i+1)*num_val_sample,feature_num:]
    x_train=np.concatenate([Data[:i*num_val_sample,0:feature_num],Data[(i+1)*num_val_sample:,0:feature_num]],axis=0)
    y_train = np.concatenate([Data[:i * num_val_sample, feature_num:], Data[(i + 1) * num_val_sample:, feature_num:]], axis=0)
    score = forest.score(x_test,y_test.astype('int'))
    best_score_list.append(score)
    if best_score<score:
        best_score=score
        y_test_best=y_test
print(best_score_list)
print(sum(best_score_list)/len(best_score_list))
print(best_score)