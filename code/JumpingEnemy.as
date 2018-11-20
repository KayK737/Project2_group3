package code {
	import flash.display.Stage;
	/** 
	 * The JumpingEnemy is the enemy which jumps up
	 * Child of Enemy
	 */
	public class JumpingEnemy extends Enemy {



		/**
		 * The Constructor sets the enemies position based on game elements
		 * @param gameStage the stage to which the SpikyEnemy will be added
		 * @param platform the most recent platform (for determining y)
		 */
		public function JumpingEnemy(gameStage: Stage, platform: Platform) {
			// constructor code

			this.x = gameStage.stageWidth - 100;
			this.y = platform.y - this.height / 2;
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