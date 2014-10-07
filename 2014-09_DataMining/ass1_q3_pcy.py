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
    if v >= support_threshold:
        frequent_items[k] = v

bitmap = {}
for k,v in hash_table.iteritems():
    if v >= support_threshold:
        bitmap[k] = 1
    else:
        bitmap[k] = 0

# print_hash(support)  ##for question (a.1)
del support
del hash_table

##Pass2 -> frequent_pairs
support = {}
# question2 = {}  ##for question (a.2 -> c)
for basket in baskets:
    for pair in itertools.combinations(basket, 2):
        i = pair[0]
        j = pair[1]

        if i in frequent_items.keys():
            if j in frequent_items.keys():
                if bitmap[hash_function(i, j)] == 1:
                    try:
                        support[pair] += 1
                    except KeyError:
                        support[pair] = 1

##for question (a.2 -> c)
#         try:
#             question2[pair][0] += 1
#         except KeyError:
#             question2[pair] = [1]
# for k,v in question2.iteritems():
#     ##which bucket
#     question2[k].append(hash_function(k[0], k[1]))
#     ##frequent bucket
#     if question2[k][0] >= support_threshold:
#         question2[k].append(1)
#     else:
#         question2[k].append(0)
# print_hash(question2)


frequent_pairs = {}
for k,v in support.iteritems():
    if v >= support_threshold:
        frequent_pairs[k] = v

# print_hash(support)  ##for question (d)
del support

##Output
frequent_itemsets = dict(frequent_items, **frequent_pairs)
print "Frequent_itemsets:"
print_hash(frequent_itemsets)
