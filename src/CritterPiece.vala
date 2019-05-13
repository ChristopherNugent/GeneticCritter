/**
 * CritterPiece is a wrapper around a critter and its state on the game board.
 *
 * This includes its position, the direction it is facing, and the team it is on.
 */
namespace GeneticCritter {

	public class CritterPiece {
		private static int team_counter = 1;

		public Critter critter;
		public int x;
		public int y;
		public int direction;
		public int team;

		public CritterPiece(Critter critter, int x, int y) {
			this.critter = critter;
			this.x = x;
			this.y = y;
			direction = Random.int_range(0, 4);
			team = team_counter++;			
		}

		public CritterPiece.from_infection(CritterPiece victim, CritterPiece attacker) {
			critter = new Critter.from_parent(attacker.critter);
			x = victim.x;
			y = victim.y;
			direction = victim.direction;
			team = attacker.team;
		}

		public CritterPiece.empty() {
			team = 0;
		}
	}
}
