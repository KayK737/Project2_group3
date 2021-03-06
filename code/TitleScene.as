﻿package code {
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.display.MovieClip;

	public class TitleScene extends GameScene {

		/** Keeps track of if it should switch to a play scene. */
		private var shouldSwitchToPlay: Boolean = false;

		/**
		 * This should override the public update function with its own update function.
		 * This updates every thing in the title scene when the scene is running.
		 * @param keyboard:KeyboardInput reacts to the players keyboard inputs.
		 * @return defalt returns null but can return a new GameScene
		 */
		override public function update(keyboard: KeyboardInput): GameScene {
			handleNextScene();
			if (shouldSwitchToPlay) return new PlayScene();

			return null;
		}

		/**
		 * Do this function when entering the scene.
		 */
		override public function onBegin(): void {
			bttnPlay.x = 640
			bttnPlay.y = 360
			bttnPlay.addEventListener(MouseEvent.MOUSE_DOWN, handleClickPlay);
		}

		/**
		 * Do this function when entering the scene.
		 */
		override public function onEnd(): void {
			bttnPlay.removeEventListener(MouseEvent.MOUSE_DOWN, handleClickPlay);
		}

		/**
		 * Decides if it should switch scenes and to what one if it should.
		 */
		private function handleNextScene(): void {
			if (KeyboardInput.IsKeyDown(Keyboard.NUMBER_2)) {
				shouldSwitchToPlay = true;
			}
		}
		/** 
		*sets shouldswitch to play to true should user click the play button 
		*/
		private function handleClickPlay(e:MouseEvent): void {
			shouldSwitchToPlay = true;
		}

	}

}