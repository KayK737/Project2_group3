package code {

	import flash.display.MovieClip;
	import flash.display.Stage;

	/**
	 * The base enemy class
	 */
	public class Enemy extends MovieClip {

		/**
		 * Overriden by child classes
		 * @returns string a string saying which type the enemy is
		 */
		public function getType(): String {
			return "base";
		}
		
		/**
		 * Overridden by child classes
		 * updates the enemy
		 */
		public function update(): void {
			
		}

		/**
		 * STATIC function to determine which type of enemy to spawn.
		 * all 3 enemies have an equal chance of spawning
		 * @param gameStage Stage to which the enemy will be made a child
		 * @param platform most recent platform generated (for enemy y value)
		 * @returns Enemy a new enemy object
		 */
		static function spawnEnemy(gameStage: Stage, platform: Platform): Enemy {
			var rand = Math.random();

			if (rand < 0.33) {
				return new FlyingEnemy(gameStage);
			} else if (rand < .66) {
				return new JumpingEnemy(gameStage, platform);
			} else {
				return new SpikyEnemy(gameStage, platform);
			}
		}
	}

}