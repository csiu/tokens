import json

## some data
data = {
    "A" : 101,
    "B" : 202,
    "C" : 303
    }
filename = 'data_jsonfile.txt'


## writing to file
with open(filename, 'w') as outfile:
      json.dump(data, outfile)


## reading from file
with open(filename, 'r') as f:
    dat = json.load(f)

print dat["B"]


##===================================
## OUTPUT of 'data_jsonfile.txt' is:
#
# {"A": 101, "C": 303, "B": 202}
