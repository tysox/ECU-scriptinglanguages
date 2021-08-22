#Sets style of graph
set style data boxes
set boxwidth 0.9 relative
set style fill solid 1.0

#Formats graph with title, labels and scale
set title "Number of scams per year - ACCC Scamwatch (scamwatch.gov.au)"
set xlabel "Year"
set xrange [2005.5:]
set yrange [0:]
set key off

#Plots the graph from the original parsed file (created from "getData" function in parent script)
plot "./files/dates.txt"