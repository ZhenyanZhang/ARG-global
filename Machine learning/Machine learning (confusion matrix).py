
import numpy as np
import pandas as pd
import sklearn
from sklearn import metrics
import joblib
import matplotlib.pyplot as plt
import matplotlib as mpl
from sklearn.metrics import confusion_matrix
import seaborn as sns
path="D:/onedrive/NCrevised/Ocean(k-mean).xlsx"
data=pd.read_excel(path)  #reading data
classmap={1:'Rank1',2:'Rank2',3:'Rank3',4:'Rank4',5:'Rank5',6:'Rank6',7:'Rank7',
          8:'Rank8',9:'Rank9',10:'Rank10'}
name=list(data.columns.values)
Data=np.array(data)
np.random.shuffle(Data)
k=10
num_val_sample=len(Data)//k
feature_num=18
#x_test=Data[9*num_val_sample:(9+1)*num_val_sample,0:feature_num]
#y_test=Data[9*num_val_sample:(9+1)*num_val_sample,feature_num:]
x_test=Data[:,:-1]
y_test=Data[:,-1]
forest=joblib.load("D:/onedrive/NCrevised/best_forest.pkl")
y_pred=forest.predict(x_test)
print(y_pred)

f,ax=plt.subplots()
plt.rc('font',family='Arial',weight='bold',size=10)
conf_mx=confusion_matrix(y_test.astype('int'),y_pred.astype('int'))
print(conf_mx)
conf_normalized=conf_mx.astype('float')/conf_mx.sum(axis=1)[:,np.newaxis]
print(conf_normalized)
conf_mx=pd.DataFrame(conf_normalized,index=classmap.values(),columns=classmap.values())
ax.set_xticklabels(ax.get_xticklabels(),rotation=90)
sns.heatmap(conf_mx,annot=True,annot_kws={'size':10,'weight':'bold'},cmap="YlGnBu",alpha=0.8)
plt.show()