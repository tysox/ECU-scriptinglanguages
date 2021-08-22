#Input file contains comma-separated values fields
set datafile separator comma

#Sets output dimensions for better readability
set term dumb size 150,30

#Sets style of graph
set style data boxes
set boxwidth 1 relative

#Formats graph with title, labels and scale
set title "Number of scams per category - ACCC Scamwatch (scamwatch.gov.au)"
#set xlabel "Scam category"     #Removed for readability.
set xrange [-0.5:9.5]
set yrange [0:]
set key off

#Plots the graph from the original parsed file (created from "getData" function in parent script)
plot "./files/categories.txt" using 0:1:xtic(2)