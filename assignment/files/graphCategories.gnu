#Input file contains comma-separated values fields
set datafile separator comma

#Sets output dimensions for better readability
set terminal qt size 640,800

#Sets style of graph
set style data boxes
set boxwidth 0.9 relative
set style fill solid 1.0

#Formats graph with title, labels and scale
set title "Number of scams per category - ACCC Scamwatch (scamwatch.gov.au)"
set xlabel "Scam category"
set xrange [-0.5:9.5]
set xtics rotate
set yrange [0:]
set key off

#Plots the graph from the original parsed file (created from "getData" function in parent script)
plot "./files/categories.txt" using 0:1:xtic(2)