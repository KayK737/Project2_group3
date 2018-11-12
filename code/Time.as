package code {
	import flash.utils.getTimer;

	/** 
	 * This class keeps track of delta time.
	 */
	public class Time {

		/** The amount of time that has passed since the last frame. */
		public static var timeDelta: Number = 0;
		/** The amount of time that has passed since the start of the game. */
		public static var time: Number = 0;
		/** The amount of time that had passed since the start of the game last frame. */
		private static var timePrev: Number = 0;

		/** 
		 * Updates delta time.
		 */
		public static function update(): void {
			time = getTimer();
			timeDelta = (time - timePrev) / 1000;
			timePrev = time; //cache next frame.
		}
	}
}