package code {

	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.utils.getTimer;
	import flash.ui.Keyboard;

	/**
	 * This is the overall class from which the rest of the game is built off of.
	 */
	public class Game extends MovieClip {

		/** This keeps track of the keyboard's state. */
		private var keyboard: KeyboardInput;


		//KeyboardInput.setup(stage);


		/**
		 * This stores the current scene using a FSM.
		 */
		private var gameScene: GameScene;

		/**
		 * This starts up the game.
		 */
		public function Game() {
			// constructor code
			KeyboardInput.setup(stage);

			switchScene(new TitleScene());

			addEventListener(Event.ENTER_FRAME, gameLoop);

		}

		/**
		 * The game loop that runs the scene it is currently on.
		 * @param e: Event the event listener that keeps things moving.
		 */
		private function gameLoop(e: Event): void {
			if (gameScene) switchScene(gameScene.update(keyboard));

			Time.update();
			KeyboardInput.update();

		} // ends gameLoop

		/**
		 * Switches to a new game scene.
		 * @param newScene: GameScene keeps track of what scene to switch to.
		 */
		private function switchScene(newScene: GameScene): void {
			if (newScene) {
				if (gameScene) gameScene.onEnd();
				if (gameScene) removeChild(gameScene);
				gameScene = newScene;
				addChild(gameScene);
				gameScene.onBegin();
			}
		} // ends switchScene()
	}

}