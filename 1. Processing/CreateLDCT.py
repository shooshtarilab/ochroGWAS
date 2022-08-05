import pandas as pd
import os
path = 'C:/Users/akash/Desktop/Western University/Outputs/FetalBedFiles'
files = os.listdir(path)
names = []
for i in files:
    names.append(i.split(".")[0])
for i in names:
    print("{}\t~/MITACS/FetalLDSCores/{}.".format(i,i))