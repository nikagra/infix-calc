CC=g++
CFLAGS=-Wall
LDFLAGS=-lfl
SRCS=main.cpp tokens.cpp translator.cpp
OBJS=$(SRCS:.cpp=.o)
LEX=flex
SYN=bison
PROGRAM=foobar

all: $(PROGRAM) 

$(PROGRAM): $(OBJS)
	$(CC) $^ -o $@ $(LDFLAGS)

.cpp.o:
	$(CC) $(CFLAGS) -c -o $@ $<
	
tokens.cpp: tokens.l translator.cpp
	$(LEX) -o $@ $<

translator.cpp: translator.y
	$(SYN) -d -o $@ $<

clean:
	-rm *.o $(PROGRAM) translator.cpp tokens.cpp translator.hpp
