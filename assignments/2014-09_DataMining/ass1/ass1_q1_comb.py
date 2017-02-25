import itertools
import operator

items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
s = 0.01

def prod(iterable):
    return reduce(operator.mul, iterable, 1)

def find_frequent_itemsets(k_itemsets):
    return [sets for sets in k_itemsets if prod([1/float(i) for i in sets]) >= s]


frequent_itemsets = []
for k in range(1,11):
    k_itemsets = list(itertools.combinations(items, k))

    #print k, len(find_frequent_itemsets(k_itemsets))
    frequent_itemsets += find_frequent_itemsets(k_itemsets)


print frequent_itemsets
