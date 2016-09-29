import csv

with open('/Users/simeonkakpovi/Documents/SAD_mini/sales.csv', mode='r') as f:
    spamreader = csv.DictReader(f)
    for row in spamreader:
        print "(%s, %s, %s, %s, %s)," \
              % (row['id'], row['prod'], row['cust'], row['invoice'], row['quant'])

