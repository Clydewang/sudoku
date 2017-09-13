import urllib
import BeautifulSoup as bs
import numpy as np
from scipy import io as sio
import re
import time
import json


level = 2

with open('config.json') as file:
    file_index = json.load(file)['index']

batch_records = 100
records = np.zeros((batch_records,81), int)
for i in range(batch_records):
	handle = urllib.urlopen('http://view.websudoku.com/?level=%d'%level)
	html = handle.read()
	soup = bs.BeautifulSoup(html)
	puzzle = soup.find("table", { "id" : "puzzle_grid"})
	cells = puzzle.findAll("td")

	for j in range(81):
		res = re.findall('value="(\d)"',str(cells[j]))
		if len(res):
			records[i,j] = int(res[0])
	
	print '(%i/%i) records processed.'%(i+1,batch_records)
	time.sleep(1)

sio.savemat('data/%d.mat'%file_index, {'data': records, 'level': level})
file_index += 1
with open('config.json', 'w') as file:
    json.dump({'index':file_index}, file)