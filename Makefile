
CC := g++
file1 := f3.txt
file2 := tree4.txt

solution1: clean1
	${CC} solution1.cpp -std=c++11 -Wall -Werror -O3 -lm -o solution1
	./solution1 ${file1}

solution2: clean2
	${CC} solution2.cpp -std=c++11 -Wall -Werror -O3 -lm -o solution2
	./solution2 ${file2}

clean1:
	rm -f solution1

clean2:
	rm -f solution2
