import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib as mpl
import sklearn
from sklearn.ensemble import RandomForestRegressor

#中文显示
mpl.rcParams['font.sans-serif'] = [u'SimHei']
mpl.rcParams['axes.unicode_minus'] = False

#path="demo.xlsx"
path="rundata.xlsx"
#k折验证
k=10
data=pd.read_excel(path)  #数据读入
name=list(data.columns.values)
Data=np.array(data)
np.random.shuffle(Data)
num_val_sample=len(Data)//k
feature_num=21
print(Data.shape)
score_list=[]
best_forest=RandomForestRegressor()
best_score=0
best_score_list=[]
#空值处理
for i in range(k):
    x_test=Data[i*num_val_sample:(i+1)*num_val_sample,0:feature_num]
    y_test=Data[i*num_val_sample:(i+1)*num_val_sample,feature_num:]
    x_train=np.concatenate([Data[:i*num_val_sample,0:feature_num],Data[(i+1)*num_val_sample:,0:feature_num]],axis=0)
    y_train = np.concatenate([Data[:i * num_val_sample, feature_num:], Data[(i + 1) * num_val_sample:, feature_num:]], axis=0)
    #随机森林预测
    forest=RandomForestRegressor(n_estimators=13)
    forest.fit(x_train,y_train)
    y_pred=forest.predict(x_test)
    score=sklearn.metrics.r2_score(y_test, y_pred)
    if best_score<score:
        best_score=score
        best_forest=forest
    score_list.append(score)
print(score_list)
print(sum(score_list)/len(score_list))
#得到最优解
print(best_score)
for i in range(k):
    x_test=Data[i*num_val_sample:(i+1)*num_val_sample,0:feature_num]
    y_test=Data[i*num_val_sample:(i+1)*num_val_sample,feature_num:]
    x_train=np.concatenate([Data[:i*num_val_sample,0:feature_num],Data[(i+1)*num_val_sample:,0:feature_num]],axis=0)
    y_train = np.concatenate([Data[:i * num_val_sample, feature_num:], Data[(i + 1) * num_val_sample:, feature_num:]], axis=0)
    y_pred = best_forest.predict(x_test)
    score = sklearn.metrics.r2_score(y_test, y_pred)
    best_score_list.append(score)
print(best_score_list)
print(sum(best_score_list)/len(best_score_list))
score_all=[]
for i in range(Data.shape[1]):
    score_all.append(best_score_list)
plt.figure()
plt.boxplot(score_all,labels=name)
plt.show()


