package code {
	import flash.events.KeyboardEvent;
	import flash.display.Stage;
	import flash.events.MouseEvent;

	/** 
	 * This class keeps track of what keys are being pressed down.
	 */
	public class KeyboardInput {

		/** Keeps track of if the Left arrow key is being pressed. */
		public static var keyLeft: Boolean = false;
		/** Keeps track of if the Up arrow key is being pressed. */
		public static var keyUp: Boolean = false;
		/** Keeps track of if the Right arrow key is being pressed. */
		public static var keyRight: Boolean = false;
		/** Keeps track of if the Down arrow key is being pressed. */
		public static var keyDown: Boolean = false;
		/** Keeps track of if the Enter key is being pressed. */
		public static var keyEnter: Boolean = false;
		/** Keeps track of if the Escape key is being pressed. */
		public static var keyEscape: Boolean = false;
		/** Keeps track of if the W key is being pressed. */
		public static var keyW: Boolean = false;
		/** Keeps track of if the A key is being pressed. */
		public static var keyA: Boolean = false;
		/** Keeps track of if the S key is being pressed. */
		public static var keyS: Boolean = false;
		/** Keeps track of if the D key is being pressed. */
		public static var keyD: Boolean = false;

		/**
		 * This function adds event listeners to handle KeyboardEvents.
		 * @param stage:Stage keeps track of things on the stage.
		 */
		public function KeyboardInput(stage: Stage) {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
		}

		/**
		 * This updates to keep track of the state of the keys.
		 * @param keyCode: int keeps track of what key.
		 * @param isDown: Boolean keeps track of if the key is pressed or not.
		 */
		private function updateKey(keyCode: int, isDown: Boolean): void {

			if (keyCode == 13) keyEnter = isDown;
			if (keyCode == 37) keyLeft = isDown;
			if (keyCode == 38) keyUp = isDown;
			if (keyCode == 39) keyRight = isDown;
			if (keyCode == 40) keyDown = isDown;
			if (keyCode == 27) keyEscape = isDown;
			if (keyCode == 87) keyW = isDown;
			if (keyCode == 65) keyA = isDown;
			if (keyCode == 83) keyS = isDown;
			if (keyCode == 68) keyD = isDown;
		}

		/**
		 * Marks keys as down when they are pressed.
		 * @param e: KeyboardEvent keeps track of key board event.
		 */
		private function handleKeyDown(e: KeyboardEvent): void {
			//trace(e.keyCode);
			updateKey(e.keyCode, true);
		}

		/**
		 * Marks keys as up when they are not pressed.
		 * @param e: KeyboardEvent keeps track of key board event.
		 */
		private function handleKeyUp(e: KeyboardEvent): void {

			updateKey(e.keyCode, false);
		}

	}

}