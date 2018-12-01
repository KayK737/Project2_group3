package code {

	import flash.display.MovieClip;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;

	public class LoseScene extends GameScene {

		/** Keeps track of if it should switch to a play scene. */
		private var shouldSwitchToPlay: Boolean = false;
		/** Keeps track of if it should switch to a title scene. */
		private var shouldSwitchToTitle: Boolean = false;
		
		private var endSound:Boolean = true;
		public static var finalScore: Number;

		/**
		 * This should override the public update function with its own update function.
		 * This updates every thing in the lose scene when the scene is running.
		 * @param keyboard:KeyboardInput reacts to the players keyboard inputs.
		 * @return defalt returns null but can return a new GameScene
		 */
		override public function update(keyboard: KeyboardInput): GameScene {

			if (shouldSwitchToTitle) return new TitleScene();
			if (shouldSwitchToPlay) return new PlayScene();
			
			
			scoreFinal.text = "Final Score: " + finalScore;
			return null;
		}

		/**
		 * Do this function when entering the scene.
		 */
		override public function onBegin(): void {
			bttnReset.x = 640
			bttnReset.y = 360
			bttnReset.addEventListener(MouseEvent.MOUSE_DOWN, handleClickReset);
			//bttnReset.addEventListener(MouseEvent.MOUSE_DOWN, handleClickTitle);
			
		}

		/**
		 * Do this function when entering the scene.
		 */
		override public function onEnd(): void {
			bttnReset.removeEventListener(MouseEvent.MOUSE_DOWN, handleClickReset);
			
		}

		/**
		 * Decides if it should switch scenes and to what one depending on the button
		 * the user clicked 
		 */

		private function handleClickReset(e:MouseEvent):void{
			shouldSwitchToPlay = true;
		}
		private function handleClickTitle(e:MouseEvent):void{
			shouldSwitchToTitle = true;
		}
	}
}