## timestamp
## [reference: squiguy; stackoverflow: 13890935]

verbosity=True

if (verbosity):
    import time
    import datetime
    def get_timestamp():
        ts = time.time()
        st = datetime.datetime.fromtimestamp(ts).strftime('%Y-%m-%d %H:%M:%S')
        return st

if (verbosity):
    print("[%s]... %s\n" % (get_timestamp(), "timestamping")),
