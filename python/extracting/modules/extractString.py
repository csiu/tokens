import re

class extractString:
    def __init__(self, start, middle, end, string):
        self.start = start
        self.end = end

        self.string = string

        self.startIndex = string.index(self.start)
        self.endIndex = string.index(self.end) + len(self.end)

        self.middle = middle

    def within(self):
        return self.string[self.startIndex : self.endIndex]

    def startHalf(self):
        return self.string[self.startIndex:]

    def endHalf(self):
        return self.string[:self.endIndex]


print extractString("5'", "[ATGC]", "3'", "this is a primer in the middle of a sentense 5'-ACGTTA-3' there").within()
