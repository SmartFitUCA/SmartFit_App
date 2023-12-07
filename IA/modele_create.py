import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error
from sklearn.preprocessing import LabelEncoder

# Charger les données
data = pd.read_csv('data\\data_emple.csv')

# Encoder les catégories 'category' et 'noteUser'
label_encoder = LabelEncoder()
data['category'] = label_encoder.fit_transform(data['category'])
data['noteUser'] = label_encoder.fit_transform(data['noteUser'])

# Sélectionner les caractéristiques pour l'entraînement du modèle
features = ['category', 'noteUser', 'distance', 'timeOfActivity', 'denivelePositif', 'speedAvg', 'bpmAvg']

# Diviser les données en ensembles d'entraînement et de test
train_data, test_data = train_test_split(data[features], test_size=0.2, random_state=42)

# Séparer les caractéristiques (X) de la cible (y)
X_train, y_train = train_data.drop('noteUser', axis=1), train_data['noteUser']
X_test, y_test = test_data.drop('noteUser', axis=1), test_data['noteUser']

# Créer et entraîner le modèle de régression linéaire
model = LinearRegression()
model.fit(X_train, y_train)

# Faire des prédictions sur l'ensemble de test
predictions = model.predict(X_test)

print(predictions)

# Évaluer le modèle
mse = mean_squared_error(y_test, predictions)
print(f'Mean Squared Error on Test Data: {mse}')
