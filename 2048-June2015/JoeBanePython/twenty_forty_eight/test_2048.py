#!/usr/bin/env python

from .twenty_forty_eight import Grid


class Test2048(object):
    def setup(self):
        dimension = 4
        config = '4 0 2 0|0 0 0 8|4 0 2 4|2 4 2 2'
        return Grid(dimension, config)

    def test_up(self):
        g = self.setup()
        expected = """8    4    4    8
2    0    2    4
0    0    0    2
0    0    0    0
"""
        g.update('UP')
        result = repr(g)
        assert expected == result

    def test_down(self):
        g = self.setup()
        expected = """0    0    0    0
0    0    0    8
8    0    2    4
2    4    4    2
"""
        g.update('DOWN')
        result = repr(g)
        assert expected == result

    def test_left(self):
        g = self.setup()
        expected = """4    2    0    0
8    0    0    0
4    2    4    0
2    4    4    0
"""
        g.update('LEFT')
        result = repr(g)
        assert expected == result

    def test_right(self):
        g = self.setup()
        expected = """0    0    4    2
0    0    0    8
0    4    2    4
0    2    4    4
"""
        g.update('RIGHT')
        result = repr(g)
        assert expected == result
