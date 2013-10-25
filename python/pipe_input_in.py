## Error/exit when there is no input being piped in
if sys.stdin.isatty():
    sys.stderr.write("error: please pipe in bam files to use as standard input\n\n")
    parser.print_help()
    sys.exit()

for stdin_line in sys.stdin:
    print "input: %s\n" % stdin_line
