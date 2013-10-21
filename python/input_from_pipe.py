## Do something with stdin
## error & exit when stdin is not present
import sys

if sys.stdin.isatty():
    sys.stderr.write("error: please pipe input\n")
    sys.exit()

for line in sys.stdin:
    line = line.rstrip()
    print "do something with: %s" % line
