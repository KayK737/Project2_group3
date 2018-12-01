package code {

	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.geom.Point;

	/**
	 * The base enemy class
	 */
	public class Enemy extends MovieClip {

		
		/** velocity of the enemy */
		public var velocity: Point = new Point(0, 0);

		/** variable needed to detect aabb collison */
		public var collider: AABB;
		
		/** variable for storing the death state of the enemy */
		public var isDead = false;

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
		 * @param gameStage Stage to which the enemy will be made  a child
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

		/** 
		 * This moves the enemy out of a collision zone when they are colliding with an object.
		 * @param fix The adjustment to the enemy's x and y position.
		 */
		public function applyFix(fix: Point): void {
			if (fix.x != 0) {
				x += fix.x;
				velocity.x = 0;
			}
			if (fix.y != 0) {
				y += fix.y;
				velocity.y = 0;
			}
			collider.calcEdges(x, y);
		}
	}

}