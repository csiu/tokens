import operator

points = {'A1':(2,10),
          'A2':(2, 5),
          'A3':(8, 4),
          'A4':(5, 8),
          'A5':(7, 5),
          'A6':(6, 4),
          'A7':(1, 2),
          'A8':(4, 9)}

centroid_1 = points['A1']
centroid_2 = points['A4']
centroid_3 = points['A7']


def distance(p1, p2):
    return abs(p2[0] - p1[0]) + abs(p2[1] - p1[1])

def divide(a, b):
    if a % b != 0:
        return round(a/float(b), 4)
    else:
        return a/b

def calculate_centroid_point(list_of_points):
    n = len(list_of_points)
    list_of_x = [p[0] for p in list_of_points]
    list_of_y = [p[1] for p in list_of_points]

    x = divide(sum(list_of_x), n)
    y = divide(sum(list_of_y), n)

    return (x,y)

## arbitrarily set number iteration to 9
## note: there is stopping condition
for iteration in range(1, 10):
    print
    print 'Iteration: %s' % iteration
    print 'Centroid_1: %s\nCentroid_2: %s\nCentroid_3: %s' % (
        centroid_1, centroid_2, centroid_3)

    summary_table = []
    for k,v in points.iteritems():
        d1 = distance(v, centroid_1)
        d2 = distance(v, centroid_2)
        d3 = distance(v, centroid_3)
        min_index, min_val = min(enumerate([d1, d2, d3]),
                                 key=operator.itemgetter(1))

        summary_table.append([k,v, d1, d2, d3, min_index + 1])

    for l in summary_table:
        print '\t'.join(map(str, l))

    ## get points for new centroid
    c1_pts = [p[1] for p in summary_table if p[-1] == 1]
    c2_pts = [p[1] for p in summary_table if p[-1] == 2]
    c3_pts = [p[1] for p in summary_table if p[-1] == 3]

    old_c1, old_c2, old_c3 = centroid_1, centroid_2, centroid_3

    ## update centroid
    centroid_1 = calculate_centroid_point(c1_pts)
    centroid_2 = calculate_centroid_point(c2_pts)
    centroid_3 = calculate_centroid_point(c3_pts)

    if old_c1 == centroid_1 and old_c2 == centroid_2 and old_c3 == centroid_3:
        break
