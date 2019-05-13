using Gee;

namespace GeneticCritter { 
    
    public void main() {
        var simulation = new CritterSimulation();
        for (int i = 0; i < 10000000; i++) {
            simulation.next();
        }
        var counts = simulation.get_team_counts();
        int max_count = max(counts.values);
        stdout.printf("The best team now has %d members.\n", max_count);
    }

    private int max(Collection<int> items) {
        int max = 0;
        foreach (int item in items) {
            if (item > max) {
                max = item;
            }
        }
        return max;
    }
}