package code {
	import flash.ui.Keyboard;
	import flash.geom.Point;

	/** 
	 * The main scene of the game
	 * All the gameplay logic comes in here
	 */
	public class PlayScene extends GameScene {
		/** Keeps track of the player object. */
		private var player: Player;
		/** Keeps track of if it should switch to a title scene. */
		private var shouldSwitchToTitle: Boolean = false;
		/** Keeps track of if it should switch to a lose scene. */
		private var shouldSwitchToLose: Boolean = false;
		
		private var cameraOffSetY: Number;
		
		private var lowPlatformY: Number = 600;
		private var midPlatformY: Number = 480;
		private var highPlatformY: Number = 380;

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
			
			calcCameraOffSet();
			
			moveCamera();

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
					if (platforms[i].x < this.stage.stageWidth - platforms[i].width + 500) {
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
			var newLength = (Math.random() * 13 + 2) * 50;
			newPlatform.width = newLength;

			if (mostCurrentPlatform.y == highPlatformY || mostCurrentPlatform.y == lowPlatformY) {
				newPlatform.y = midPlatformY;
				newPlatform.height = 240;
			} else if (mostCurrentPlatform.y == midPlatformY) {
				var rand = Math.random();
				if (rand > .5) {
					newPlatform.y = highPlatformY;
					newPlatform.height = 360;
				}
				else {
					newPlatform.y = lowPlatformY;
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
			if(player.y > 750 || player.x < -30){
				shouldSwitchToLose = true;
			}

		} // ends doCollisionDetection 
		
		private function moveCamera(): void{
			for(var i: int = 0; i < platforms.length; i++){
				platforms[i].y += cameraOffSetY/100;
			}
		}
		
		private function calcCameraOffSet():void{
			cameraOffSetY = this.stage.stageHeight/2 - player.y;
			trace(cameraOffSetY);
		}

	}

}