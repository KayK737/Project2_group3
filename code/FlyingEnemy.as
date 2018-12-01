package code {
	import flash.display.Stage;
	import flash.display.MovieClip;

	/** 
	 * The Flying is the enemy which flies at the top of the level
	 * Child of Enemy
	 */
	public class FlyingEnemy extends Enemy {

		///** pixels per second the enemy moves */
		//public var velocityX: Number = -200

		/**
		 * The Constructor sets the enemies position based on game elements
		 * @param gameStage the stage to which the SpikyEnemy will be added
		 */
		public function FlyingEnemy(gameStage: Stage) {
			collider = new AABB(width/2, height/2);
			
			
			this.velocity.x = -200;
			this.x = gameStage.stageWidth + 100;			
			this.y = 100;
			
			collider.calcEdges(x, y);
		}
		
		/**
		 * Overrides base class update function
		 * Updates the state of the enemy
		 */
		public override function update(): void {
			
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
	}

}