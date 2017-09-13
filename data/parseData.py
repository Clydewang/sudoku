import numpy as np
import pandas as pd
from scipy import io as sio

levels = ['simple','medium','hard','expert']

X = np.zeros((800,81),int)
Y = np.zeros(800,int)
features = np.zeros((800,9))
for l in range(4):
	Y[l*200:(l+1)*200] = l+1
	df = pd.read_csv('raw/%s.csv'%levels[l])
	for i in range(200):
		puzzle = df['Puzzle'].iloc[i]
		for j in range(81):
			code = puzzle[j]
			if 48 < ord(code) < 58:
				X[l*200+i,j] = ord(code)-48
	temp = np.array(df)
	features[l*200:(l+1)*200,:] = temp[:,1:10]

sio.savemat('sudoku', {'sudoku':X,'level':Y})
sio.savemat('raw_features', {'feature':features})
