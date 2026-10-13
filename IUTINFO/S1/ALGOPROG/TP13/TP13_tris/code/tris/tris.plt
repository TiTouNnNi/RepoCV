set terminal svg background rgb "white"
set output "./tris.svg"
set grid
set key below
set xlabel "taille du tableau"
set ylabel "temps (ms)"
set pointsize 2
set style line 1 linetype 1 lw 1 linecolor rgb "red" pointtype 1
set style line 2 linetype 1 lw 1 linecolor rgb "blue" pointtype 1
set style line 3 linetype 1 lw 1 linecolor rgb "web-green" pointtype 1
set style line 4 linetype 1 lw 1 linecolor rgb "magenta" pointtype 1
set style line 5 linetype 1 lw 1 linecolor rgb "brown" pointtype 1
set style line 6 linetype 1 lw 1 linecolor rgb "black" pointtype 1
set style line 7 linetype 1 lw 1 linecolor rgb "orange" pointtype 1
plot \
"./benchmark.txt" using 2:($1==0?$3:NaN) \
  title "tri par selection" with linespoints linestyle 1, \
"./benchmark.txt" using 2:($1==1?$3:NaN) \
  title "tri a bulle" with linespoints linestyle 2, \
"./benchmark.txt" using 2:($1==2?$3:NaN) \
  title "tri par comptage" with linespoints linestyle 3, \
"./benchmark.txt" using 2:($1==3?$3:NaN) \
  title "tri rapide" with linespoints linestyle 4, \
"./benchmark.txt" using 2:($1==4?$3:NaN) \
  title "tri par insertion" with linespoints linestyle 5, \
"./benchmark.txt" using 2:($1==5?$3:NaN) \
  title "tri fusion" with linespoints linestyle 6, \
"./benchmark.txt" using 2:($1==6?$3:NaN) \
  title "tri Java" with linespoints linestyle 7
