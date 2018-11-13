package code {
	import flash.ui.Keyboard;

	public class PlayScene extends GameScene {

		private var player:Player;

		/** Keeps track of if it should switch to a title scene. */
		private var shouldSwitchToTitle: Boolean = false;
		/** Keeps track of if it should switch to a lose scene. */
		private var shouldSwitchToLose: Boolean = false;

		public function PlayScene (){
			player = new Player();
			addChild(player);
			player.x = 275;
			player.y = 200;
		}
		
		/**
		 * This should override the public update function with its own update function.
		 * This updates every thing in the play scene when the scene is running.
		 * @param keyboard:KeyboardInput reacts to the players keyboard inputs.
		 * @return defalt returns null but can return a new GameScene
		 */
		override public function update(keyboard: KeyboardInput): GameScene {
			player.update();
			if (shouldSwitchToLose) return new LoseScene();
			if (shouldSwitchToTitle) return new TitleScene();
			handleNextScene();

			return null;
		}

		/**
		 * Do this function when entering the scene.
		 */
		override public function onBegin(): void {
			//bttnPlay.addEventListener(MouseEvent.MOUSE_DOWN, handleClickPlay);
			trace("Enter PlayScene. Press 1 to goto title scene. Press 3 to goto lose scene.");
		}

		/**
		 * Do this function when entering the scene.
		 */
		override public function onEnd(): void {
			//bttnPlay.removeEventListener(MouseEvent.MOUSE_DOWN, handleClickPlay);
			trace("Exit PlayScene");
		}

		/**
		 * Decides if it should switch scenes and to what one if it should.
		 */
		private function handleNextScene(): void {
			if (KeyboardInput.IsKeyDown(Keyboard.NUMBER_3)) {
				shouldSwitchToLose = true;
			}
			if (KeyboardInput.IsKeyDown(Keyboard.NUMBER_1)) {
				shouldSwitchToTitle = true;
			}
		}

	}

}