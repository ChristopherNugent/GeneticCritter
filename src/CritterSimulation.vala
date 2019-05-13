namespace GeneticCritter {

	class CritterSimulation : GLib.Object {

		public const int[,] OFFSETS = {{1,0}, {0, 1}, {-1, 0}, {0, -1}};

		public const int X_SIZE = 100;
		public const int Y_SIZE = 100;
		public const double DENSITY = 1;

		private CritterPiece[,] board;
		private Queue<CritterPiece> movement_queue;

		public CritterSimulation() {
			board = new CritterPiece[Y_SIZE, X_SIZE];
			movement_queue = new Queue<CritterPiece>();
			populate_board();
		}

        /*
         * Populate the board based on the DENSITY constant
         */
		private void populate_board() {
			for (int y = 0; y < Y_SIZE; y++) {
				for (int x = 0; x < X_SIZE; x++) {
					bool place_critter = Random.next_double() <= DENSITY;
					if (place_critter) {
						var critter = new CritterPiece(new Critter(), x, y);
						movement_queue.push_tail(critter);
						board[y, x] = critter;
					} else {
						board[y, x] = new CritterPiece.empty();
					}
				}
			}
		}

        /**
         * Iterate the simulation by having the next Critter make its move
         */
		public void next() {
			var piece = movement_queue.peek_head();
			uchar view = get_critter_view(piece);
			var action = piece.critter.get_move(view);
		}

        /**
         * Get the flat representation of the squares surroudning a critter
         */
		private uchar get_critter_view(CritterPiece piece) {
			uchar critter_view = 0;
			for (int i = 0; i < 4; i++) {
				int y_offset = OFFSETS[i, 0];
				int x_offset = OFFSETS[i, 1];
				int target_y = piece.y + y_offset;
				int target_x = piece.x + x_offset;

				uchar neighbor = get_neighbor_type(target_x, target_y, piece.team);
				critter_view = (critter_view << 2) + neighbor;
            }
            return critter_view;
		}

        /**
         * Get the Neighbor type at the passed coordinates, as seen by the passed team.
         */
        private Neighbor get_neighbor_type(int target_x, int target_y, int team) {
            if (target_y < 0 || target_y >= Y_SIZE || target_x < 0 || target_x >= X_SIZE) {
                return Neighbor.WALL;
            } else if (board[target_y, target_x].team == 0) {
                return Neighbor.EMPTY;
            } else if (board[target_y, target_x].team == team) {
                return Neighbor.SAME;
            } else {
                return Neighbor.ENEMY;
            }
        }

		private void execute_action(CritterPiece piece, Action action) {
			int target_y = piece.y + OFFSETS[piece.direction, 0];
			int target_x = piece.x + OFFSETS[piece.direction, 1];
            var target_type = get_neighbor_type(target_x, target_y, piece.team);
            if (action == Action.ATTACK && target_type == Neighbor.ENEMY) {
                var target_piece = board[target_y, target_x];
                target_piece.critter = new Critter.from_parent(piece.critter);
            } else if (action == Action.JUMP && target_type == Neighbor.EMPTY) {
                board[piece.y, piece.x] = new CritterPiece.empty();
                piece.x = target_x;
                piece.y = target_y;
                board[target_y, target_x] = piece;
            } else if (action == Action.LEFT) {
                piece.direction = (piece.direction + 3) % 4;
            } else {
                piece.direction = (piece.direction + 1) % 4;
            }
		}
	}
}