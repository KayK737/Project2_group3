package code {
	import flash.display.Stage;
	import flash.geom.Point;

	/** 
	 * The JumpingEnemy is the enemy which jumps up
	 * Child of Enemy
	 */
	public class JumpingEnemy extends Enemy {

		/** Holds the curret gravity of the enemy. */
		private var gravity: Point = new Point(0, 200);
		///** The enemies vertical Velocity */
		//private var velocityY = 0;
		/** The impulse velocity that is added when the enemy jumps. */
		private var jumpVelocity: Number = 200;
		/** number of ms until the enemy should jump */
		private var msTimeUntilJump: int = 100 //3 seconds

		/**
		 * The Constructor sets the enemies position based on game elements
		 * @param gameStage the stage to which the SpikyEnemy will be added
		 * @param platform the most recent platform (for determining y)
		 */
		public function JumpingEnemy(gameStage: Stage, platform: Platform) {
			// constructor code
			collider = new AABB(width / 2, height / 2);



			this.x = platform.x;
			this.y = platform.y - platform.height / 2 - this.height / 2;
			collider.calcEdges(x, y);
		}


		/**
		 * Overrides base class update function
		 * Updates the state of the enemy
		 */
		public override function update(): void {
			trace(msTimeUntilJump);

			msTimeUntilJump -= Time.dt
			if (msTimeUntilJump <= 0) {
				this.velocity.y = -jumpVelocity;
				msTimeUntilJump = 100;
			}
			velocity.y+= gravity.y * Time.dt
			y += velocity.y * Time.dt;
			
			this.collider.calcEdges(x, y);
			
			



		}

		/**
		 * Overrides Parent Enemy Class getType funtion
		 * @returns string a string saying which type the enemy is
		 */
		public override function getType(): String {
			return "Jumping";
		}
	}

}