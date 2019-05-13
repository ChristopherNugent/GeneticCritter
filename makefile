SRC = src/Main.vala src/Action.vala src/Critter.vala
FLAGS = --pkg=gee-0.8 -X -O
OUT = GeneticCritter

all: $(OUT)

$(OUT): ${SRC}
	valac $(SRC) $(FLAGS) -o $(OUT)

clean:
	rm $(OUT)

run: $(OUT)
	./$(OUT)