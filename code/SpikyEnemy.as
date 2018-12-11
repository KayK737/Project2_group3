package code {

	import flash.display.Stage;
	import flash.display.MovieClip;

	/** 
	 * The SpikyEnemy is the enemy which charges at the player attempting to collide with them
	 * Child of Enemy
	 */
	public class SpikyEnemy extends Enemy {
		/** stores which platform the enemy is on so it will know how far it can walk */
		private var spikyPlatform: Platform;

		private var previousDirection: int = -1;


		/**
		 * The Constructor sets the enemies position based on game elements
		 * @param gameStage the stage to which the SpikyEnemy will be added
		 * @param platform the most recent platform (for determining y)
		 */
		public function SpikyEnemy(gameStage:Stage = null, platform: Platform = null) {
			if (platform) {
				spikyPlatform = platform
				collider = new AABB(width / 2, height / 2);



				this.x = spikyPlatform.x;
				this.y = spikyPlatform.y - spikyPlatform.height / 2 - this.height / 2;

				this.velocity.x = 300; // 300px sec

				collider.calcEdges(x, y);
			}
			// constructor code
		}

		/**
		 * Overrides base class update function
		 * Updates the state of the enemy
		 */
		public override function update(player: Player): void {
			var velocityDirection: int = (player.x < this.x) ? -1 : 1;

			if (previousDirection != velocityDirection) {
				this.scaleX = -1;
				this.previousDirection *= -1;
			}

			this.x += this.velocity.x * velocityDirection * Time.dt;

			if (this.x <= spikyPlatform.x - spikyPlatform.width / 2) this.x = spikyPlatform.x - spikyPlatform.width / 2;
			if (this.x >= spikyPlatform.x + spikyPlatform.width / 2) {
				this.x = spikyPlatform.x + spikyPlatform.width / 2;
			}

			this.collider.calcEdges(x, y);



		}

		/**
		 * Overrides Parent Enemy Class getType funtion
		 * @returns string a string saying which type the enemy is
		 */
		public override function getType(): String {
			return "Spiky";
		}



	}

}