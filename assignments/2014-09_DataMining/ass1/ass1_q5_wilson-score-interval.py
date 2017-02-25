import math

class Obj:
    pass

def wilson_score_error_margin(z, n, p_hat):
    numerator = z * math.sqrt((1/n * p_hat * (1 - p_hat)) + 1/(4 * n**2) * z**2 )
    denominator = 1 / (1 + (1/n * z**2))
    return numerator / denominator


def calculate_error(democrat, republican):
    D = float(democrat)
    R = float(republican)

    # set z-score at 75% confidence level
    z = 1.15035

    n = D + R

    if n != 0:
        p_hat = D / n
        return n * wilson_score_error_margin(z, n, p_hat)
    else:
        return float(0)

def prune_summary(nodes):
    error_at_node = []
    D = 0
    R = 0
    for node in nodes:
        d = node[0]
        r = node[1]
        error_at_node.append(calculate_error(d, r))

        D += d
        R += r

    sum_error_at_nodes = sum(error_at_node)
    total_error_after_pruning = calculate_error(D,R)

    if total_error_after_pruning <= sum_error_at_nodes:
        prune_decision = True
    else:
        prune_decision = False

    summary = '''
Node_children:\t%s
Node_parent:\t%s
Error_children:\t%0.4f (%s)
Error_parent:\t%0.4f
Prune:\t%s
''' % (nodes,
       '(%s, %s)' % (D, R),
       sum_error_at_nodes, ['%0.4f' % t for t in error_at_node],
       total_error_after_pruning,
       prune_decision)

    obj = Obj()
    obj.summary = summary
    obj.node = (D, R)

    return obj


nodes = [#nodes 0-4
         (151,0),
         (1,0),
         (6,0),(9,0),(0,1),

         #nodes 5-11
         (3,94),
         (0,4),
             (2,0),
             (0,1),
             (3,2),(2,11),(1,0),

         #nodes 12-16
         (0,0),
         (4,0),
         (0,0),(2,1),(0,2)]

'''
for node in nodes:
    print '%s\t%0.4f' % (node, calculate_error(node[0], node[1]))
'''

node_nn = prune_summary(nodes[2:5])
node_n = prune_summary(nodes[0:2] + [node_nn.node])

node_yyn = prune_summary(nodes[9:12])
node_yy = prune_summary(nodes[7:9] + [node_yyn.node])
node_y = prune_summary(nodes[5:7] + [node_yy.node])

node_uu = prune_summary(nodes[14:17])
node_u = prune_summary(nodes[12:14] + [node_uu.node])

node_ = prune_summary([node_n.node, node_y.node, node_u.node])


print node_.summary ##note: to view "summary"
