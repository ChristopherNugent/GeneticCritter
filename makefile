SRC = src/Main.vala src/Action.vala src/Critter.vala src/CritterPiece.vala \
      src/Neighbor.vala src/CritterSimulation.vala
FLAGS = --pkg=gee-0.8 -X -O
OUT = GeneticCritter

all: $(OUT)

$(OUT): ${SRC}
	valac $(SRC) $(FLAGS) -o $(OUT)

clean:
	rm $(OUT)
	rm src/*.c

run: $(OUT)
	./$(OUT)