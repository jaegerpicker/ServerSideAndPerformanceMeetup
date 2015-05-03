import sys
from itertools import product, starmap, islice
test_cases = open(sys.argv[1], 'r')

def find_neighbors(m, i, j, dist=1):
    return [row[max(0, j-dist):j+dist+1] for row in m[max(0, i-1):i+dist+1]]

for test in test_cases:
	if test != '':
		arr = list(test)
		width = int(arr[2])
		height = int(arr[0])
		matrix = [[0 for x in xrange(width)] for x in xrange(height)]
		for i in range(height):
			matrix[i] = arr[4 + (i * width):4 + ((i * width) + width)]
		bomb_count = 0	
		answer = ''
		for h in range(height):
			for w in range(width):
				if matrix[h][w] == '*':
					answer += matrix[h][w]
				else:
					cells = find_neighbors(matrix, h, w)
					for c in cells:
						for s in c:
							if s == '*':
								bomb_count += 1
					answer += str(bomb_count)
					bomb_count = 0
		print answer