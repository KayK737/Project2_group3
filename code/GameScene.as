package code {
	import flash.display.MovieClip;

	/**
	 * This class is an ABSTRACT class for our
	 * GameScene FSM. All game scenes are child classes
	 * of this class.
	 */
	public class GameScene extends MovieClip {

		/**
		 * Each game scene should OVERRIDE this method
		 * and add specific implementation.
		 */
		public function update(keyboard: KeyboardInput): GameScene {

			return null;
		}
		/**
		 * Each game scene should OVERRIDE this method
		 * and add specific implementation.
		 */
		public function onBegin(): void {

		}
		/**
		 * Each game scene should OVERRIDE this method
		 * and add specific implementation.
		 */
		public function onEnd(): void {

		}

	}
}