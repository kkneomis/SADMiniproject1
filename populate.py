import csv

with open('/Users/simeonkakpovi/Documents/ads.csv', mode='r') as f:
    spamreader = csv.DictReader(f)
    for row in spamreader:
        print "(%s,%s, %s, %s, %s)," \
              % (row['id'], row['id2'], row['id3'], row['quant'], row['balance'])

