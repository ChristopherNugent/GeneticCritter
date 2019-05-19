using Gee;

namespace GeneticCritter {

    const long MOVES_PER_CRITTER = 10000;

    public void main() {
        Intl.setlocale(); // Set local to enable thousands separators

        var simulation = new CritterSimulation();
        ulong total_moves = MOVES_PER_CRITTER * simulation.num_critters;
        ulong dot_rate = total_moves / 100;

        stdout.printf("Board size: %'d x %'d tiles\n", CritterSimulation.X_SIZE, CritterSimulation.Y_SIZE);
        stdout.printf("Board density: %.1f%\n", 100 * CritterSimulation.DENSITY);
        stdout.printf("Critters in this simulation: %'d\n", simulation.num_critters);
        stdout.printf("Simulating %'ld moves per critter (%'lu moves total)\n",
                      MOVES_PER_CRITTER, total_moves);

        for (ulong i = 0; i < total_moves; i++) {
            if (i % dot_rate == 0) {
                stdout.printf(".");
                stdout.flush();
            }
            simulation.next();
        }
        var counts = simulation.get_team_counts();
        int max_count = max(counts.values);
        stdout.printf("\nThe best strain now has %'d members.\n", max_count);
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