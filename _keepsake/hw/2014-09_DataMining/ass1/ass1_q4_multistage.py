import itertools

##Helper ==============================
def print_hash(x):
    print '%s\t%s' % ('item', 'count')
    for k,v in x.iteritems():
        print '%s\t%s' % (k, v)
##=====================================

baskets = [[1,2,3], [2,3,4], [3,4,5], [4,5,6],
           [1,3,5], [2,4,6], [1,3,4], [2,4,5],
           [3,5,6], [1,2,4], [2,3,5], [3,4,6]]

support_threshold = 4

##Hash function
def hash_function(i, j):
    return (i * j) % 11

def hash_function2(i, j):
    return (i + j) % 9

##Pass1 -> frequent_items, bitmap
support = {}
hash_table = {}
for basket in baskets:
    ##add 1 to count/support for each item in basket
    for item in basket:
        try:
            support[item] +=1
        except KeyError:
            support[item] = 1

    ##for each pair, add 1 to corresponding bucket
    ##note: each basket adds at most 1 to each bucket
    bucket_already_filled = []
    for pair in itertools.combinations(basket, 2):
        bucket = hash_function(pair[0], pair[1])

        if bucket not in bucket_already_filled:
            try:
                hash_table[bucket] += 1
            except KeyError:
                hash_table[bucket] = 1

        bucket_already_filled.append(bucket)

frequent_items = {}
for k,v in support.iteritems():
    if v >= 4:
        frequent_items[k] = v

bitmap = {}
for k,v in hash_table.iteritems():
    if v >= 4:
        bitmap[k] = 1
    else:
        bitmap[k] = 0

del support
del hash_table
del bucket_already_filled

##Pass2 -> bitmap2
hash_table2 = {}
for basket in baskets:
    bucket_already_filled = []

    for pair in itertools.combinations(basket, 2):
        i = pair[0]
        j = pair[1]

        ##add 1 to bucket in hash_table2 if:
        ##- i, j are both frequent items
        ##- {i,j} are hashed to frequent bucket in pass1
        ##note: each basket adds at most 1 to each bucket
        if i in frequent_items.keys():
            if j in frequent_items.keys():
                if bitmap[hash_function(i, j)] == 1:
                    bucket = hash_function2(i, j)

                    if bucket not in bucket_already_filled:
                        try:
                            hash_table2[bucket] += 1
                        except KeyError:
                            hash_table2[bucket] = 1

                    bucket_already_filled.append(bucket)

# print_hash(hash_table2) ##for question (4.1)
bitmap2 = {}
for k,v in hash_table2.iteritems():
    if v >= 4:
        bitmap2[k] = 1
    else:
        bitmap2[k] = 0

del hash_table2
del bucket_already_filled

##Pass3 -> frequent pairs
support = {}
for basket in baskets:
    for pair in itertools.combinations(basket, 2):
        i = pair[0]
        j = pair[1]

        if i in frequent_items.keys():
            if j in frequent_items.keys():
                if bitmap[hash_function(i, j)] == 1:
                    if bitmap2[hash_function2(i, j)] == 1:
                        try:
                            support[pair] += 1
                        except KeyError:
                            support[pair] = 1

frequent_pairs = {}
for k,v in support.iteritems():
    if v >= 4:
        frequent_pairs[k] = v

# print_hash(support)  ##for question (4.2)
del support

##Output
frequent_itemsets = dict(frequent_items, **frequent_pairs)
print_hash(frequent_itemsets)
