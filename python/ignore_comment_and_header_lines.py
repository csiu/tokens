## Useful for files such as:

## # Comment                      <-- comment line: typically ignore
## # ...                          <-- comment line: typically ignore
## Header describing column names <--  header line: typically ignore
## col1    col2    col3    col4   <----- data line: do something
## col1    col2    col3    col4   <----- data line: do something
## ...

import re
def read_nth_line(infile, num_header_line = 2):
    comment_line = re.compile("^#")

    with open(infile, 'r') as f:
        head_comment = True
        counter      = 0

        ##do something to comment lines
        while head_comment:
            line = f.readline()
            if comment_line.match(line):
                print "comment - do something:", line,
                counter += len(line)
            else:
                head_comment = False
                f.seek(counter)

        ##do something to following header lines; default = 1 line
        for index in range(0, num_header_line):
            line = f.readline()
            print "header  - do something:", line,

        ##do something to rest of data lines
        for line in f:
            print "data    - do something:", line,
