import numpy as np
from time import time

class SudokuSolver(object):
	"""
	This is a DFS implementation to solve Sudoku Problem:
	Though this idea is easy, if we traverse the whole tree, there
	are O(9^m) possible paths where m is the number of blanks. This
	might be a little bit difficult for us to handle, however most
	paths in this set are not legal: they violate the game rule.
	Based on this fact, we could find a way to reduce the node we 
	expand, that is to fill as much blank as possible. When no blank 
	could be determined, we could select a blank and make a guess, 
	leading to a new state(node), which makes recursive call possible.

	USAGE:
	>>> solver = SudokuSolver()
	>>> solver.solve(filePath='2.txt')
	
	OR 

	>>> solver.openFile('4.txt')
	>>> solver.solve()
	
	File should looks like this:
		400000805
		030000000
		000700000
		020000060
		000080400
		000010000
		000603070
		500200000
		104000000
	where 0 stands for blank.
	"""
	def solve(self, puzzle=None,filePath=None):
		if puzzle is not None:
			self.matrix = self.parser(puzzle)
		elif filePath is not None:
			self.openFile(filePath)
		if self.matrix is None: 
			print 'WARNING: Empty puzzle, please enter/read one'
			return
		print 'Sudoku Solver by Clyde Wang\n>>> input:'
		self.prettify(self.matrix)
		start = time()
		solution, n_iteration = self.DFS_Sudoku(self.matrix)
		end = time()

		print '>>> solution:'
		self.prettify(solution)
		print 'Sudoku solved in %.3f seconds in %d iterations.'%((end - start),n_iteration)

	def openFile(self, filePath):
		'''This Function is to read data from file.'''
		s = open(filePath).read()
		self.matrix = self.parser(s)
		print s

	def parser(self, string):
		'''This Function is used to process the raw input'''
		temp = np.zeros((9,9),dtype=int)
		i=0; j=0
		while i!=81:
			if len(string[j].strip())>0:
				temp[i/9,i%9]=int(string[j])
				i+=1
			j+=1
		return temp	

	def prettify(self, matrix):
		'''This Function is to print matrix in a pretty way'''
		result = str(matrix)
		for i in range(len(result)):
			if result[i] == '0': result = result[:i]+"."+result[i+1:]
		print result

	def findAllPossible(self,matrix):
		'''This Function is to find all the possible assignments of each blank'''
		updated = False
		possible = matrix.copy().tolist()
		for i in range(9):
			for j in range(9):
				if matrix[i,j]==0:
					row = matrix[i,:].reshape(9).tolist()
					col = matrix[:,j].reshape(9).tolist()
					squres = matrix[i/3*3:i/3*3+3,j/3*3:j/3*3+3].reshape(9).tolist()
					possible[i][j] = set(range(1,10)) - set(row) - set(col) - set(squres)
					updated = True
		return updated, possible

	def findUnique(self, matrix, possible):
		'''This function is used to find those blanks with only possible assignment in row, column and square.'''
		updated = False
		# Row check
		for row in xrange(9):
			for num in (set(range(1,10))-set(matrix[row,:].reshape(9).tolist())):
				n = 0; c = -1
				for col in xrange(9):
					if type(possible[row][col]) is set:
						if num in possible[row][col]:
							n+=1; c=col
						if n==2: break
				if n==1: matrix[row,c]=num; updated=True
		# Column Check
		for col in xrange(9):
			for num in (set(range(1,10))-set(matrix[:,col].reshape(9).tolist())):
				n = 0; r = -1
				for row in xrange(9):
					if type(possible[row][col]) is set:
						if num in possible[row][col]:
							n+=1; r=row
						if n==2: break
				if n==1: matrix[r,col]=num; updated=True
		# Square Check
		for n in range(9):
			i=n/3; j=n%3
			for num in (set(range(1,10))-set(matrix[:,col].reshape(9).tolist())):
				n = 0; r = -1; c = -1
				for m in xrange(9):
					row=m/3; col=m%3
					if type(possible[row][col]) is set:
						if num in possible[row][col]:
							n+=1; r=row; c=col
						if n==2: break
				if n==1: matrix[r,c]=num; updated=True
		return updated, matrix

	def fillMargin(self, matrix):
		'''This is a function to fill as much blank as possible.'''
		updated = True
		while updated:
			updated, possible = self.findAllPossible(matrix)
			# if all the blanks have been assigned
			if not updated: return True, matrix, None
			updated, matrix = self.findUnique(matrix, possible)	
		return False, matrix, self.findAllPossible(matrix)[1]

	def findMinimumSet(self, possible):
		'''
		This function is used to find the blank with minimum possible choices:
		the less choices you have, the more probably right you guess is.
		Besides, it helps reduce the expanded node.
		'''
		minimum=9; r=-1; c=-1
		for i in range(9):
			for j in range(9):
				if type(possible[i][j]) is set:
					if len(possible[i][j])<minimum:
						minimum=len(possible[i][j]);r=i; c=j
		return r,c

	def DFS_Sudoku(self, matrix):
		'''
		This function is the main entry to solve the Sudoku problem
		The DFS is implemented using Stack/FILO Data Structure
		'''
		# if it could be solved by set subtraction
		solved, matrix, possible = self.fillMargin(matrix)
		if solved: return matrix, 1

		# solve the problem using DFS:
		stack=[matrix]       # using a stack to store the margin
		niter = 1            # in case of dead loop
		while niter < 10000:
			matrix = stack.pop()
			solved, matrix, possible = self.fillMargin(matrix)
			if solved: return matrix, niter
			# find a blank with fewest possible choices
			r,c = self.findMinimumSet(possible)
			for a in possible[r][c]:
				m = matrix.copy()
				m[r,c] = a
				stack.append(m)
			niter += 1
		return 'Stuck in loop'


# you can copy the content between triple quotation marks to a txt file
solver = SudokuSolver()
solver.solve(filePath='0.txt')
#solver.openFile('4.txt')
#solver.solve(puzzle=puzzle)