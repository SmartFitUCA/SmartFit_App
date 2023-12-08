import pandas as pd 
import numpy as np
from sklearn.linear_model import LinearRegression
from sklearn.preprocessing import LabelEncoder
import pickle
import sklearn_json as skljson




def generateJson(model:LinearRegression):
    listCoef = []
    listIntercept = []
    for i in range(0,len(model.coef_)):
        listCoef.append(model.coef_[i][0])
        listIntercept.append(model.intercept_[i])
    json = {"coef":listCoef,"intercept":listIntercept}
    return json




# Load data from CSV
df = pd.read_csv("data\\data_emple.csv")

startTime = df.iloc[0:len(df),6].values.reshape(-1,1)

category = df.iloc[0:len(df),0].values
#print("Category : ",category)

data = pd.DataFrame({
    "Distance": df.iloc[:, 1].values,
    "Time": df.iloc[:, 2].values,
    "Denivele": df.iloc[:, 3].values,
    "Speed": df.iloc[:, 4].values,
    "Bpm": df.iloc[:, 5].values
})

model = LinearRegression()

model.fit(startTime,data)

datePredict = np.array([[1271]])
prediction = model.predict(datePredict)

print("Prédiction -> ")
#print(prediction)
print("Distance : ",float(prediction[0][0]))
print("Time : ",float(prediction[0][1]))
print("Denivele : ",float(prediction[0][2]))
print("Speed : ",float(prediction[0][3]))
print("BPM : ",float(prediction[0][4]))


generateJson(model=model)


