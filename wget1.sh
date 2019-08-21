#!/bin/bash
for i in {25 39 42 45 47 59 63 65 75 76 77 78 79 80 81 82 83 84 90 91 93 94 96 98 99 104 202 203 205 207 208 211}
do
wget -P ten/ https://www.${caijiurl}.net/book/ten/$i.htm
sleep 0.1 
done
