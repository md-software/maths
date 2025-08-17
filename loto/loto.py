import pandas as pd
import mdmath.primes as prime

def calc_list(bouleslist):
    return int(bouleslist[4])+100*int(bouleslist[3])+10000*int(bouleslist[2])+1000000*int(bouleslist[1])+100000000*int(bouleslist[0])

# Get loto historical data
df = pd.read_csv("historique_loto.csv", sep=";") #, skiprows = 1)

# Remove null values
df = df.dropna(axis=1, how='all')
print(df.head(5))

# print(data['boule_1'].value_counts())
# for col in data.columns:  
#     print(col)

df['index']=range(len(df))

# create column with integer representation of boules
df['N'] = df['boule_5']+100*df['boule_4']+10000*df['boule_3']+1000000*df['boule_2']+100000000*df['boule_1']
df['Prime'] = df['N'].map(prime.isPrime)
print(df[['index','combinaison_triee','N','Prime']])
print(df['Prime'].value_counts())
print(df.loc[df['Prime'] == True])

df['combinaison_triee_int'] = df['combinaison_triee'].str.split('-').apply(calc_list)
df['Prime_int'] = df['combinaison_triee_int'].map(prime.isPrime)

df['somme'] = pd.to_numeric(df['combinaison_triee_int']) + pd.to_numeric(df['N'])
df['Prime_somme'] = df['somme'].map(prime.isPrime)
print(df[['index','combinaison_triee_int','N','somme','Prime_somme']])

df.loc[(df['Prime'] == True) | (df['Prime_int'] == True) | (df['Prime_somme'] == True)][['date_de_tirage','combinaison_triee','Prime','Prime_int','Prime_somme']]
df.loc[(df['Prime'] == True) & (df['Prime_int'] == True) & (df['Prime_somme'] == True)][['date_de_tirage','combinaison_triee','Prime','Prime_int','Prime_somme']]