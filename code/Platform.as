package code {
	
	import flash.display.MovieClip;
	
	/** The platform class is the main object the player can stand on */
	public class Platform extends MovieClip {
		
		/** The amount that the platform moves per second in the horizontal direction */
		private var horizontalVelocity = -200;
		
		/** Updates the platform
		 * Currently moves the platform based on its velocity, however when we change the mechanics this will change
		 * as it was just for presentation
		*/
		public function update():void {
			this.x += horizontalVelocity * Time.dt;
		}
	}
	
}
