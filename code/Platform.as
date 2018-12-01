package code {
	
	import flash.display.MovieClip;
	
	/** The platform class is the main object the player can stand on */
	public class Platform extends MovieClip {
		
		/** The amount that the platform moves per second in the horizontal direction */
		//private var horizontalVelocity = -200;
		/** The platform's AABB for collision detection. */
		public var collider: AABB;
		
		public function Platform() {
			collider = new AABB(width/2, height/2);
			//trace(width, height);

			collider.calcEdges(x, y);
			//PlayScene.platforms.push(this);
			// constructor code
		}
		
		/** Updates the platform
		 * Currently moves the platform based on its velocity, however when we change the mechanics this will change
		 * as it was just for presentation
		*/
		public function update():void {
			//this.x += horizontalVelocity * Time.dt;
			collider.calcEdges(x, y);
			//trace(width, height);
			collider.setSizes(width/2, height/2);
			
		}
	}
	
}
