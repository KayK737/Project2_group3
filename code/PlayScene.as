package code {
	import flash.ui.Keyboard;
	import flash.geom.Point;

	/** The main scene of the game
	 * All the gameplay logic comes in here
	*/
	public class PlayScene extends GameScene {

		private var player: Player;

		/** Keeps track of if it should switch to a title scene. */
		private var shouldSwitchToTitle: Boolean = false;
		/** Keeps track of if it should switch to a lose scene. */
		private var shouldSwitchToLose: Boolean = false;

		/** An Array for all the platform objects */
		static public var platforms = new Array();

		/** the play scene Constructor */
		public function PlayScene() {
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

			updatePlatforms();
			
			doCollisionDetection();

			return null;
		}

		/**
		 * Do this function when entering the scene.
		 */
		override public function onBegin(): void {
			//bttnPlay.addEventListener(MouseEvent.MOUSE_DOWN, handleClickPlay);
			trace("Enter PlayScene. Press 1 to goto title scene. Press 3 to goto lose scene.");
			var startingPlatform = new Platform();
			startingPlatform.x = 0;
			startingPlatform.y = 600;
			startingPlatform.width = 1280;
			this.addChild(startingPlatform);
			platforms.push(startingPlatform);

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
		
		/**
		*	Updates all the platforms in the platforms collection;
		*/
		private function updatePlatforms(): void {
			var shouldSpawnNewPlatform = false;
			
			for (var i = platforms.length - 1; i >= 0; i--) {
				platforms[i].update();
				if (i == platforms.length - 1) { //if the most recent platform
					//trace("most recent");
					if (platforms[i].x < this.stage.stageWidth - platforms[i].width + 20) {
						shouldSpawnNewPlatform = true;
						//trace("should spawn new platform");
					}
				}

			}
			if (shouldSpawnNewPlatform) spawnNewPlatform();
		}
		
		/**
		 * Determines spawns a new platform who's position depends on the previous platforms's position
		 */
		private function spawnNewPlatform(): void {
			var mostCurrentPlatform = platforms[platforms.length - 1];
			var newPlatform = new Platform();
			var newLength = (Math.random() * 18 + 2) * 50;
			newPlatform.width = newLength;

			if (mostCurrentPlatform.y == 360 || mostCurrentPlatform.y == 600) {
				newPlatform.y = 480;
				newPlatform.height = 240;
			} else if (mostCurrentPlatform.y == 480) {
				var rand = Math.random();
				if (rand > .5) {
					newPlatform.y = 360;
					newPlatform.height = 360;
				}
				else {
					newPlatform.y = 600;
				}
			}
			newPlatform.x = mostCurrentPlatform.x + mostCurrentPlatform.width;
			this.addChild(newPlatform);
			platforms.push(newPlatform);


		}
		
		/**
		 * Checks for collisions and readjusts the plays position when needed.
		 */
		private function doCollisionDetection(): void {

			for (var i: int = 0; i < platforms.length; i++) {
				if (player.collider.checkOverlap(platforms[i].collider)) { // if overlapping
					// find the fix:
					var fix: Point = player.collider.findOverlapFix(platforms[i].collider);
					// apply the fix:
					player.applyFix(fix);
				}
			} // ends for loop

		} // ends doCollisionDetection 

	}

}