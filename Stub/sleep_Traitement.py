import csv

# Spécifiez le chemin du fichier CSV que vous souhaitez lire
fichier_csv = 'data\\sleepDay_merged.csv'
final = 'User\\User_4020332650\\sleep.csv'

data = []
data.append(["Time","Value"])

# Ouvrir le fichier CSV en mode lecture
with open(fichier_csv, 'r', newline='') as fichier:
    lecteur_csv = csv.reader(fichier)
   
    for ligne in lecteur_csv:
        if ( ligne[0] == '4020332650'):
            data.append([ligne[1],ligne[2]])


with open(final,'w', newline='') as fichierFinal:
    ecrivain_csv = csv.writer(fichierFinal)
    
    ecrivain_csv.writerows(data)