namespace GeneticCritter { 
    
    void main() {
        var critter = new Critter.random();
        while (true) {
            var input = (uchar) Random.int_range(0, 256);
            var action = critter.get_move(input);
            stdout.printf("%s\n", action.to_string());
        }
    }
}