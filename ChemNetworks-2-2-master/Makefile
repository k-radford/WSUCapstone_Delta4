CC=gcc
CFLAGS=-Wall -I.
LIBS=-lm

chemnetworks: main.o graphs.o dipoles.o structures.o geodesics.o util.o polyhedra.o
	$(CC) -o ChemNetworks-2.2.exe main.o graphs.o dipoles.o structures.o geodesics.o util.o polyhedra.o $(CFLAGS) $(LIBS)

