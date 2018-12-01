package code {
	import flash.display.Stage;
	import flash.display.MovieClip;

	/** 
	 * The Flying is the enemy which flies at the top of the level
	 * Child of Enemy
	 */
	public class FlyingEnemy extends Enemy {

		/** time until the enemy will shoot */
		private var msTimeToShoot: int = 80;
		/** tracks state of wheterh the enemy should shoot */
		public var shouldShoot: Boolean = false;

		/**
		 * The Constructor sets the enemies position based on game elements
		 * @param gameStage the stage to which the SpikyEnemy will be added
		 */
		public function FlyingEnemy(gameStage: Stage) {
			collider = new AABB(width / 2, height / 2);


			this.velocity.x = -200;
			this.x = gameStage.stageWidth + 100;
			this.y = 100;

			collider.calcEdges(x, y);
		}

		/**
		 * Overrides base class update function
		 * Updates the state of the enemy
		 */
		public override function update(player: Player): void {

			msTimeToShoot -= Time.dt;
			if (msTimeToShoot <= 0) {
				this.shouldShoot = true;
			}

			this.collider.calcEdges(x, y);

			this.x += velocity.x * Time.dt;



		}

		/**
		 * Overrides Parent Enemy Class getType funtion
		 * @returns string a string saying which type the enemy is
		 */
		public override function getType(): String {
			return "Flying";
		}
		/** resets state related to shooting, including the timer and the state */
		public function reloadWeapon(): void {
			this.msTimeToShoot = 80;
			this.shouldShoot = false;
		}
	}

}