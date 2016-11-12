#!/usr/bin/python

#Durga Thakral YHack
# getStates.py
# Version 1
# 2016 11 12


import sys

if len(sys.argv) < 3:
	print "Type:$ python getStates.py <inputTable.txt> <outputFileName.txt> > <logFile.txt>"
	print "For example:$ python getStates.py participants.tsv us-ag-productivity-2004.csv"
	print """After you run this script, you may need to re-scale the data before 
running choroplethByState.html"""
	sys.exit(-1)


stateindex = "NA"

freq = {}
#freq[mystate] = frequency


#read inputTable and grab states and frequency
table = open(sys.argv[1], 'r')
count = -1
for line in table:
	count += 1
	if count == 0:
		header = line.strip().split("\t")
		for item in header:
			if item == "state":
				stateindex = header.index("state")
		if stateindex == "NA":
			print "Error - could not find column named 'state' in input file %s" % sys.argv[1]
			sys.exit(-1)
		else:
			print "Found column number %d matching 'state' in %s" % (stateindex, sys.argv[1])
		continue
	
	if count % 10000 == 0:
		print "Finished reading %d lines of %s" % (count, sys.argv[1])
	
	mystate = line.strip().split("\t")[stateindex]

	if mystate in freq:
		freq[mystate] += 1
	else:
		freq[mystate] = 1
table.close()

print "Found %d different states from %d lines of %s" % (len(freq), count, sys.argv[1])


#state abbrev to name conversion dictionary
states = {
        'AK': 'Alaska',
        'AL': 'Alabama',
        'AR': 'Arkansas',
        'AS': 'American Samoa',
        'AZ': 'Arizona',
        'CA': 'California',
        'CO': 'Colorado',
        'CT': 'Connecticut',
        'DC': 'District of Columbia',
        'DE': 'Delaware',
        'FL': 'Florida',
        'GA': 'Georgia',
        'GU': 'Guam',
        'HI': 'Hawaii',
        'IA': 'Iowa',
        'ID': 'Idaho',
        'IL': 'Illinois',
        'IN': 'Indiana',
        'KS': 'Kansas',
        'KY': 'Kentucky',
        'LA': 'Louisiana',
        'MA': 'Massachusetts',
        'MD': 'Maryland',
        'ME': 'Maine',
        'MI': 'Michigan',
        'MN': 'Minnesota',
        'MO': 'Missouri',
        'MP': 'Northern Mariana Islands',
        'MS': 'Mississippi',
        'MT': 'Montana',
        'NA': 'National',
        'NC': 'North Carolina',
        'ND': 'North Dakota',
        'NE': 'Nebraska',
        'NH': 'New Hampshire',
        'NJ': 'New Jersey',
        'NM': 'New Mexico',
        'NV': 'Nevada',
        'NY': 'New York',
        'OH': 'Ohio',
        'OK': 'Oklahoma',
        'OR': 'Oregon',
        'PA': 'Pennsylvania',
        'PR': 'Puerto Rico',
        'RI': 'Rhode Island',
        'SC': 'South Carolina',
        'SD': 'South Dakota',
        'TN': 'Tennessee',
        'TX': 'Texas',
        'UT': 'Utah',
        'VA': 'Virginia',
        'VI': 'Virgin Islands',
        'VT': 'Vermont',
        'WA': 'Washington',
        'WI': 'Wisconsin',
        'WV': 'West Virginia',
        'WY': 'Wyoming'
}



output = open(sys.argv[2], 'w')
newheader = "state,value"
print >> output, newheader

#print out all values of freq dictionary
for item in freq:
	state = states[item]
	print >> output, state + "," + str(freq[item])

output.close()

print "Finished.  Check output:\n%s" % sys.argv[2]