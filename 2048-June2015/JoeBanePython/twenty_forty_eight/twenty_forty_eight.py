#!/usr/bin/env python

import fileinput
import sys


class Grid(object):
    """The first program argument is a filename from which to read input.
    For each line in the input:
      * Split the line on ';' to get [0], [1], and [2], where [0] is the
      direction, [1] is the grid size, and [2] is the configuration.
      * Split [2] on '|', where each item in the split represents a row in the
      grid.
      * Calculate the operation performed depending on direction.
    """

    def __init__(self, length, config):
        self.length = length
        self.padding = 1
        self.grid = [[0 for _ in range(length)] for _ in range(length)]
        rows = config.split('|')
        for i, row in enumerate(rows):
            cols = row.split()
            for j, col in enumerate(cols):
                if self.padding < len(col):
                    self.padding = len(col)
                self.grid[i][j] = int(col)

    def __repr__(self):
        result = ''
        for i, outer in enumerate(self.grid):
            for j, inner in enumerate(outer):
                result += str(inner).rjust(self.padding + 4
                                           if j != 0 else self.padding, ' ')
            result += '\n'
        return result

    def serialize(self):
        result = ''
        for i, row in enumerate(self.grid):
            for j in range(len(row)):
                result += str(row[j])
                if j < len(row) - 1:
                    result += ' '
            if i < len(self.grid) - 1:
                result += '|'
        return result

    def rotate(self, count):
        for _ in range(count):
            self.grid = [list(inner) for inner in zip(*self.grid[::-1])]

    def push_right(self):
        for i, row in enumerate(self.grid):
            cpy = row[:]
            new_row = []
            doubled = False
            while cpy:
                cur = cpy.pop()
                prev = new_row[0] if new_row and not doubled else -1
                if cur == prev:
                    new_row.insert(0, new_row.pop(0) * 2)
                    doubled = True
                elif cur != 0:
                    new_row.insert(0, cur)
                    doubled = False
            self.grid[i] = [0 for _ in
                            range(len(self.grid[i]) - len(new_row))] + new_row

    def push_down(self):
        # Rotate grid 270 degrees, push right, then rotate back 90 degrees.
        self.rotate(3)
        self.push_right()
        self.rotate(1)

    def push_left(self):
        # Rotate grid 180 degrees, push right, then rotate back 180 degrees.
        self.rotate(2)
        self.push_right()
        self.rotate(2)

    def push_up(self):
        # Rotate grid 90 degrees, push right, then rotate back 270 degrees.
        self.rotate(1)
        self.push_right()
        self.rotate(3)

    def update(self, direction):
        if 'RIGHT' == direction:
            self.push_right()
        elif 'DOWN' == direction:
            self.push_down()
        elif 'LEFT' == direction:
            self.push_left()
        elif 'UP' == direction:
            self.push_up()

if __name__ == '__main__':
    filename = sys.argv[1]
    for line in fileinput.input((filename,)):
        direction, dimension, config = line.split(';')
        g = Grid(int(dimension), config)
        g.update(direction)
        print(g.serialize())
