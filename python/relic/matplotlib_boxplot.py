# Author:  Celia
# Created: 20/11/13
import argparse
import sys
import os
import re
import pylab 
import numpy

usage = """ %s [options] -i INFILE

Use matplotlib to create boxplot

""" % (__file__)

def append_element_to_list(element, list):
    try:
        list.append(eval(element))
    except:
        pass

parser = argparse.ArgumentParser(description=usage, formatter_class=argparse.RawTextHelpFormatter)
parser.add_argument('-i', '--infile', dest='infile',
                    required=True,
                    help='path to input file')

##get at the arguments
args = parser.parse_args()

##do something...
with open(args.infile, 'r') as infile:

    comment_line = re.compile("^#")
    find_tuple = re.compile(r'^[0-9xXyY]{1,2} \d+ .*? (.*)')
    add_comma1 = re.compile('e \(')
    add_comma2 = re.compile('\) \(')
    add_comma3 = re.compile('\) N')
    add_comma4 = re.compile('e N')

    ##init list
    T_5_0 = []
    T_5_1 = []
    T_5_2 = []
    T_5_3 = []
    T_5_4 = []
    T_8 = []
    T_9 = []
    T_10 = []
    T_11 = []
    N_5_0 = []
    N_5_1 = []
    N_5_2 = []
    N_5_3 = []
    N_5_4 = []
    N_8 = []
    N_9 = []
    N_10 = []
    N_11 = []
    R_1 = []
    R_2 = []
    R_3 = []
    R_4 = []

    data_line_counter = 0
    for line in infile:
        if (not comment_line.match(line)):
            data_line_counter += 1
            
            t = find_tuple.findall(line)[0]
            t = add_comma1.sub('e, (', t)
            t = add_comma2.sub('), (', t)
            t = add_comma3.sub('), N', t)
            t = add_comma4.sub('e, N', t)
            tuples = eval(t)

            T = tuples[0]
            N = tuples[1]
            R = tuples[2]

            ##plot 1
            append_element_to_list('T[5][0]', T_5_0)
            append_element_to_list('T[5][1]', T_5_1)
            append_element_to_list('T[5][2]', T_5_2)
            append_element_to_list('T[5][3]', T_5_3)
            append_element_to_list('T[5][4]', T_5_4)
            append_element_to_list('T[8]', T_8)
            append_element_to_list('T[9]', T_9)
            append_element_to_list('T[10]', T_10)
            append_element_to_list('T[11]', T_11)
            ##plot 2
            append_element_to_list('N[5][0]', N_5_0)
            append_element_to_list('N[5][1]', N_5_1)
            append_element_to_list('N[5][2]', N_5_2)
            append_element_to_list('N[5][3]', N_5_3)
            append_element_to_list('N[5][4]', N_5_4)
            append_element_to_list('N[8]', N_8)
            append_element_to_list('N[9]', N_9)
            append_element_to_list('N[10]', N_10)
            append_element_to_list('N[11]', N_11)
            ##plot 3
            append_element_to_list('R[1]', R_1)
            append_element_to_list('R[2]', R_2)
            append_element_to_list('R[3]', R_3)
            append_element_to_list('R[4]', R_4)

## data == [[data], [level], [label], [filename-prefix]] ==================================
data_plot1 = [[T_5_0, T_5_1, T_5_2, T_5_3, T_5_4, T_8, T_9, T_10, T_11], [0, 1, 1, 1, 0, 0, 0, 0, 0],
              ['T_5_0', 'T_5_1', 'T_5_2', 'T_5_3', 'T_5_4', 'T_8', 'T_9', 'T_10', 'T_11'], "T"]
data_plot2 = [[N_5_0, N_5_1, N_5_2, N_5_3, N_5_4, N_8, N_9, N_10, N_11], [0, 1, 1, 1, 0, 0, 0, 0, 0],
              ['N_5_0', 'N_5_1', 'N_5_2', 'N_5_3', 'N_5_4', 'N_8', 'N_9', 'N_10', 'N_11'], "N"]
data_plot3 = [[R_1, R_2, R_3, R_4], [0, 0, 0, 0], ['R_1', 'R_2', 'R_3', 'R_4'], "R"]

## Example data
# b  = [[[8, 17, 23, 31, 55, 54, 13, 4], 
#        [153, 529, 1152, 1110, 2010, 1983, 433, 78], 
#        [380, 772, 1776, 1829, 3114, 3054, 718, 240], 
#        [243, 643, 1618, 1422, 1945, 1867, 458, 128], 
#        [7, 23, 16, 20, 28, 28, 10, 4], 
#        [0, 0, 0, 0, 0, 0, 0, 0], 
#        [0, 1, 0, 0, 0, 0, 0, 0], 
#        [0.6411148186324177, 0.2912814467821452, 0.335456212549906, 0.6524452376496032, 0.3664983435521037, 0.366581046925974, 0.3224848765251726, 0.2703107720721096], 
#        [0, 2, 0, 0, 0, 0, 0, 0]], 
#       [0, 1, 1, 1, 0, 0, 0, 0, 0], 
#       ['label1', 'label2', 'label3', 'label4', 'label5', 'label6', 'label7', 'label8', 'label9'], 
#       'Filename']

for b in [data_plot1, data_plot2, data_plot3]:
    data   = b[0]
    levels = b[1]
    labels = b[2]

    data_mean = []
    data_var = []

    for level in list(set(levels)):
        index = [i for i,v in enumerate(levels) if v == level]

        sys.stderr.write("working on %s_%s\n" % (b[3], level))

        d = [data[x] for x in index]
        l = [labels[x] for x in index]

        d_mean = [numpy.mean(x) for x in d]
        d_var  = [numpy.var(x) for x in d]

        l = ["%s\n%.2f\n%.2f" % (l[i], d_mean[i], d_var[i]) for i, v in enumerate(l)]
        
        filename = "%s_%s.png" % (b[3], level)
        pylab.figure()
        pylab.title("Number of points: %s / %s" % (len(d[0]), data_line_counter))
        pylab.boxplot(d)
        pylab.xticks(rotation=45)
        pylab.xticks(range(1, len(index) + 1), l)
        pylab.xlabel("(Feature/Mean/Variance)")

#         ymax = max([max(d[i]) for i, v in enumerate(d)])
#         top = ymax+(ymax*0.05)   ## not a very good formula for describing info
#         for i,v in enumerate(d):
#             pylab.text(i+1, top, len(d[i]), horizontalalignment='center')

        pylab.tight_layout()
        
#        pylab.show()
        pylab.savefig(filename)
        
