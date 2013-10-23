def namestr(obj, namespace):
    ## 'namestr' function from: J.F. Sebastian (stackoverflow: 592746)
    return [name for name in namespace if namespace[name] is obj]


def get_value(chosen_cols):
    #example
    a, aa, c, d = ['A', 'A', 'C', 'D']
    
    #do something...
    value_of_chosen_cols = []
    for col in chosen_cols:
        print "==> col: %s" % col
        for var in namestr(eval(col), locals()):
            print "var: %s" % var
            if col == var:
                value_of_chosen_cols.append(eval(var))

    return value_of_chosen_cols

print get_value(["a", "c", "d"])

### OUTPUT
# ==> col: a
# var: aa
# var: a
# ==> col: c
# var: c
# ==> col: d
# var: d
# ['A', 'C', 'D']

