﻿package code {

	import flash.display.Stage;
	import flash.display.MovieClip;

	/** 
	 * The SpikyEnemy is the enemy which charges at the player attempting to collide with them
	 * Child of Enemy
	 */
	public class SpikyEnemy extends Enemy {
		/**
		 * The Constructor sets the enemies position based on game elements
		 * @param gameStage the stage to which the SpikyEnemy will be added
		 * @param platform the most recent platform (for determining y)
		 */
		public function SpikyEnemy(gameStage: Stage, platform: Platform) {

			collider = new AABB(width / 2, height / 2);



			this.x = platform.x;
			this.y = platform.y - platform.height / 2 - this.height / 2;

			collider.calcEdges(x, y);
			// constructor code
		}

		/**
		 * Overrides base class update function
		 * Updates the state of the enemy
		 */
		public override function update(): void {

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