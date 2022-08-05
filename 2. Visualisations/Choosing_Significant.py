import pandas as pd
data = pd.read_csv("OCHROdv_results.csv", index_col=0)        
print(data.shape)
selected = []
for i in data.columns:
    if data.loc[:,i].min() <= 0.05:                             #selecting only phenotypes that have atleast one cell types with p-value lesser than equal to 0.05
        selected.append(i)
print(len(selected))                                            #number of selected phenotypes
data = data.loc[:,selected]
data.loc[:,selected].to_csv("OCHROdb_selected.csv")             #saving the csv for visualisation
