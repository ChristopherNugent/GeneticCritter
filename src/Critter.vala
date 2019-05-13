/**
 * The Critter class represents the genome of a single critter, and provides methods for getting
 * the moves of and mutating each Critter
 */

namespace GeneticCritter {

	class Critter : GLib.Object {

        /*
         * There are 4 adjacent tiles with 4 possible values each. This results in
         * 256 possible input states. With 4 possible responses, we need 2 bits to
         * encode each response in the genome. Thus we need a genome of 512 bits or
         * 64 bytes.
         */
		public const int GENOME_SIZE = 64;

		// uchar is used in place of byte
		private uchar[] genome;

		private Critter.empty() {
			genome = new uchar[GENOME_SIZE];
		}

        /**
         * Create a Critter based on the infecting parent
         */
		public Critter.from_parent(Critter parent) {
			genome = parent.genome.copy();
		}

        /**
         * Create a new, random Critter
         */
		public Critter.random() {
			this.empty();
			for (int i = 0; i < genome.length; i++) {
				genome[i] = (uchar) Random.next_int();
			}
		}

		/**
		 * Mutate the critter by randomizing one of its genes
		 */
		public void mutate() {
			int target_bucket = Random.int_range(0, genome.length);
			uchar replacement_gene = (uchar) Random.next_int();
			genome[target_bucket] = replacement_gene;
		}

        /**
         * Get the response of this critter based on an enumerated board state
         */
		public Action get_move(uchar input) {
			uchar bucket = input / 4;
			uchar shift = 2 * (input % 4);
			uchar mask = 3; // 5 => 0b11

			uchar result = (genome[bucket] >> shift) & mask;
			return (Action) result;
		}
	}
}
