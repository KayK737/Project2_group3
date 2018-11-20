package code {

	import flash.display.MovieClip;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;

	public class LoseScene extends GameScene {

		/** Keeps track of if it should switch to a play scene. */
		private var shouldSwitchToPlay: Boolean = false;
		/** Keeps track of if it should switch to a title scene. */
		private var shouldSwitchToTitle: Boolean = false;

		/**
		 * This should override the public update function with its own update function.
		 * This updates every thing in the lose scene when the scene is running.
		 * @param keyboard:KeyboardInput reacts to the players keyboard inputs.
		 * @return defalt returns null but can return a new GameScene
		 */
		override public function update(keyboard: KeyboardInput): GameScene {

			handleNextScene();
			if (shouldSwitchToTitle) return new TitleScene();
			if (shouldSwitchToPlay) return new PlayScene();

			return null;
		}

		/**
		 * Do this function when entering the scene.
		 */
		override public function onBegin(): void {
			bttnPlay.addEventListener(MouseEvent.MOUSE_DOWN, handleClickPlay);
			trace("Enter LoseScene. Press 2 to goto play scene. Press 1 to goto title scene.");
		}

		/**
		 * Do this function when entering the scene.
		 */
		override public function onEnd(): void {
			bttnPlay.removeEventListener(MouseEvent.MOUSE_DOWN, handleClickPlay);
			trace("Exit LoseScene");
		}

		/**
		 * Decides if it should switch scenes and to what one if it should.
		 */
		private function handleNextScene(): void {
			if (KeyboardInput.IsKeyDown(Keyboard.NUMBER_2)) {
				shouldSwitchToPlay = true;
			}
			if (KeyboardInput.IsKeyDown(Keyboard.NUMBER_1)) {
				shouldSwitchToTitle = true;
			}
		}
	}
}