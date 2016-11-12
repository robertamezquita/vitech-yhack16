#!/usr/bin/python

#Durga Thakral YHack
# getZipCodes.py
# Version 1
# 2016 11 12


import sys

if len(sys.argv) < 4:
	print "Type:$ python getZipCodes.py <inputTable.txt> <sampleZipCodes.txt> <outputFileName.txt> > <logFile.txt>"
	print "For example:$ python getZipCodes.py participants.tsv sampleZips.txt unemployment.tsv"
	sys.exit(-1)


zipindex = "NA"

freq = {}
#freq[myzip] = frequency


#read inputTable and grab zipcodes and frequency
table = open(sys.argv[1], 'r')
count = -1
for line in table:
	count += 1
	if count == 0:
		header = line.strip().split("\t")
		for item in header:
			if item == "zip":
				zipindex = header.index("zip")
		if zipindex == "NA":
			print "Error - could not find column named 'zip' in input file %s" % sys.argv[1]
			sys.exit(-1)
		else:
			print "Found column number %d matching 'zip' in %s" % (zipindex, sys.argv[1])
		continue
	
	if count % 10000 == 0:
		print "Finished reading %d lines of %s" % (count, sys.argv[1])
	
	tablezip = line.strip().split("\t")[zipindex]
	length = len(tablezip)
	myzip = "0"*(5-length) + tablezip
	
	if myzip in freq:
		freq[myzip] += 1
	else:
		freq[myzip] = 1
table.close()

print "Found %d different zip codes from %d lines of %s" % (len(freq), count, sys.argv[1])


#read sample zips list
newheader = "id\trate"
zipslist = []
sample = open(sys.argv[2], 'r')
count = -1
for line in sample:
	count += 1
	if count ==0:
		newheader = line.strip()
		continue
	zipslist.append(line.strip().split("\t")[0])
sample.close()



output = open(sys.argv[3], 'w')

print >> output, newheader

#print out 0 frequencies for sample zip codes missed in freq dictionary
for item in zipslist:
	if item not in freq:
		print >> output, item +"\t0"

#print out all values of freq dictionary
for item in freq:
	print >> output, item + "\t" + str(freq[item])

output.close()