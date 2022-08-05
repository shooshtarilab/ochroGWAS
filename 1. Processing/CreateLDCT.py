import pandas as pd
import os
path = 'C:/Users/bedfiles'
files = os.listdir(path)
names = []
for i in files:
    names.append(i.split(".")[0])
for i in names:
    print("{}\t~/Users/bedfiles/{}.".format(i,i))
