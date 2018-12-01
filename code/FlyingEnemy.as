package code {
	import flash.display.Stage;
	import flash.display.MovieClip;

	/** 
	 * The Flying is the enemy which flies at the top of the level
	 * Child of Enemy
	 */
	public class FlyingEnemy extends Enemy {
		/** variable needed to detect aabb collison */
		public var collider: AABB;

		/**
		 * The Constructor sets the enemies position based on game elements
		 * @param gameStage the stage to which the SpikyEnemy will be added
		 */
		public function FlyingEnemy(gameStage: Stage) {
			collider = new AABB(width/2, height/2);
			
			
			
			this.x = gameStage.stageWidth - 100;			
			this.y = 100;
			
			collider.calcEdges(x, y);
		}

		/**
		 * Overrides Parent Enemy Class getType funtion
		 * @returns string a string saying which type the enemy is
		 */
		public override function getType(): String {
			return "Flying";
		}
	}

}