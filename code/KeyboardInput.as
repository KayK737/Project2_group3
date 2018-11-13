package code {
	import flash.events.KeyboardEvent;
	import flash.display.Stage;
	import flash.events.MouseEvent;

	/** 
	 * This class keeps track of what keys are being pressed down.
	 */
	public class KeyboardInput {

		static public var keysState: Array = new Array();
		static public var keysPrevState: Array = new Array();

		/**
		 * This function adds event listeners to handle KeyboardEvents.
		 * @param stage:Stage keeps track of things on the stage.
		 */
		static public function setup(stage: Stage) {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
		}

		/**
		 * cache all the key values , for the next frmae.
		 */
		static public function update(): void {
			keysPrevState = keysState.slice(); // in this context , slice() gives us a copy of the array
		}

		/**
		 * This updates to keep track of the state of the keys.
		 * @param keyCode: int keeps track of what key.
		 * @param isDown: Boolean keeps track of if the key is pressed or not.
		 */
		static private function updateKey(keyCode: int, isDown: Boolean): void {
			keysState[keyCode] = isDown;
		}

		/**
		 * Marks keys as down when they are pressed.
		 * @param e: KeyboardEvent keeps track of key board event.
		 */
		static private function handleKeyDown(e: KeyboardEvent): void {
			updateKey(e.keyCode, true);
		}

		/**
		 * Marks keys as up when they are not pressed.
		 * @param e: KeyboardEvent keeps track of key board event.
		 */
		static private function handleKeyUp(e: KeyboardEvent): void {
			updateKey(e.keyCode, false);
		}

		/**
		 * Detects when a key is being pressed down and returns what key it is.
		 * @param keyCode: the ID number of a key.
		 * @return is [keyCode] being pressed down.
		 */
		static public function IsKeyDown(keyCode: int): Boolean {
			if (keyCode < 0) return false;
			if (keyCode >= keysState.length) return false;
			return keysState[keyCode];
		}

		/**
		 * Detects when a key is initailly pressed down and returns what key it is.
		 * @param keyCode: the ID number of a key.
		 * @return is [keyCode] being pressed and wasn't being pressed last frame.
		 */
		static public function OnKeyDown(keyCode: int): Boolean {
			if (keyCode < 0) return false;
			if (keyCode >= keysState.length) return false;

			return (keysState[keyCode] && !keysPrevState[keyCode]);
		}

	}

}