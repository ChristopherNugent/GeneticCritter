namespace GeneticCritter {

	class CritterSimulation : GLib.Object {

        public const int[,] OFFSETS = {{1,0}, {0, 1}, {-1, 0}, {0, -1}};

		public const int X_SIZE = 100;
		public const int Y_SIZE = 100;
		public const double DENSITY = 0.2;

		private int[,] board;
		private Queue<CritterPiece> movement_queue;

		public CritterSimulation() {
			board = new int[Y_SIZE, X_SIZE];
            movement_queue = new Queue<CritterPiece>();
            populate_board();
		}

		private void populate_board() {
			for (int y = 0; y < Y_SIZE; y++) {
				for (int x = 0; x < X_SIZE; x++) {
					bool place_critter = Random.next_double() <= DENSITY;
					if (place_critter) {
						var critter = new CritterPiece(new Critter(), x, y);
						movement_queue.push_tail(critter);
						board[y, x] = critter.team;
					} else {
						board[y, x] = 0;
					}
				}
			}
        }

        public void next() {
            var piece = movement_queue.peek_head();
            uchar view = get_critter_view(piece);
            var action = piece.critter.get_move(view);
        }

        private uchar get_critter_view(CritterPiece piece) {
            uchar critter_view = 0;
            for (int i = 0; i < 4; i++) {
                int y_offset = OFFSETS[i, 0];
                int x_offset = OFFSETS[i, 1];
                int target_y = piece.y + y_offset;
                int target_x = piece.x + x_offset;

                uchar neighbor;
                if (target_y < 0 || target_y >= Y_SIZE || target_x < 0 || target_x >= X_SIZE) {
                    neighbor = Neighbor.WALL;
                } else if (board[y,x] == 0) {
                    neighbor = Neighbor.EMPTY;
                } else if (board[x,y] == piece.team) {
                    neighbor = Neighbor.SAME;
                } else {
                    neighbor = Neighbor.ENEMY;
                }
                critter_view = (critter_view << 2) + neighbor;
            }
        }
	}
}