
CC := g++

solution1: clean1
	${CC} solution1.cpp -std=c++11 -Wall -Werror -O3 -lm -o solution1
	./solution1 f3.txt

solution2: clean2
	${CC} solution2.cpp -std=c++11 -Wall -Werror -O3 -lm -o solution2
	./solution2 tree4.txt

clean1:
	rm -f solution1

clean2:
	rm -f solution2
