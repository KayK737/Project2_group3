package code {
	import flash.ui.Keyboard;
	import flash.geom.Point;
	import flash.events.MouseEvent;

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
		/** Keeps track of the camera offset */
		private var cameraOffSet: Point = new Point(0, 0);
		/** The height that Low Platforms will spawn with. */
		private var lowPlatformHeight: Number = 120;
		/** The Y height that Middle Platforms will spawn with. */
		private var midPlatformHeight: Number = 360;
		/** The Y height that High Platforms will spawn with. */
		private var highPlatformHeight: Number = 600;
		/** Buff that gives the player extra points when gathered. */
		private var buffSpike: Boolean = false;
		/** Buff that gives the player the ability to shoot. */
		private var buffFlame: Boolean = false;
		/** Buff that gives the player the ability to double jump*/
		private var buffLeg: Boolean = false;
		/** The player's score */
		public var score: Number = 0;

		/** An Array for all the platform objects */
		private var platforms = new Array();
		/** An Array for all the Enemy Objects */
		private var enemies = new Array();
		/** An Array for all the bad bullet objects */
		private var bulletsBad = new Array();
		/** An Array for all the bullets from the palyer */
		private var bullets = new Array();
		/** An Arra for all buffs. Note, this is only so they move with the camera */
		private var buffs = new Array();
		
		/** An Array for jump particle objects */
		private var particleJump = new Array();
		/** An Array for jump particle objects */
		private var particleFlame = new Array();
		/** An Array for jump particle objects */
		private var particleSpike = new Array();

		/** The amount of time in ms until an enemy should spawn */
		private var msTimeUntilEnemySpawn = 1; //1 seconds

		/** the play scene Constructor */
		public function PlayScene() {
			player = new Player();
			addChild(player);
			player.x = 640;
			player.y = 360;

		}

		/**
		 * This should override the public update function with its own update function.
		 * This updates every thing in the play scene when the scene is running.
		 * @param keyboard:KeyboardInput reacts to the players keyboard inputs.
		 * @return defalt returns null but can return a new GameScene
		 */
		override public function update(keyboard: KeyboardInput): GameScene {
			
			/** calculates the camera offset */
			calcCameraOffSet();
			/** moves the camera */
			moveCamera();
			/** updates player */
			player.update();
			/** goes to lose screen */
			if (shouldSwitchToLose) return new LoseScene();
			/** goest to title screen */
			if (shouldSwitchToTitle) return new TitleScene();
			/** how to handle next screen */
			handleNextScene();
			/** spawns particles */
			spawnParticles();
			/** updates the platforms */
			updatePlatforms();
			/** updates the enemies*/
			updateEnemies();
			/** updates score */
			updateScore();
			/** updates bullets */
			updateBullets();
			/** updates enemies bullets */
			updateBulletsBad();
			/** updates buffs*/
			updateBuffs();
			/** updates particles*/
			updateParticles();

			
			/** detects collision */
			doCollisionDetection();
			

	


			return null;
		}

		/**
		 * Do this function when entering the scene.
		 */
		override public function onBegin(): void {
			stage.addEventListener(MouseEvent.MOUSE_DOWN, handleClick);
			trace("Enter PlayScene. Press 1 to goto title scene. Press 3 to goto lose scene.");
			var startingPlatform = new Platform();
			startingPlatform.x = 800;
			startingPlatform.y = 560;
			startingPlatform.width = 1280;
			this.addChild(startingPlatform);
			platforms.push(startingPlatform);

		}

		/**
		 * Do this function when entering the scene.
		 */
		override public function onEnd(): void {
			trace("Exit PlayScene");
			player.powerup = "none";
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
					if (platforms[i].x < this.stage.stageWidth - platforms[i].width + 500) {
						shouldSpawnNewPlatform = true;
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
			var newLength = (Math.random() * 6 + 3) * 40;
			newPlatform.width = newLength;

			if (mostCurrentPlatform.height == highPlatformHeight || mostCurrentPlatform.height == lowPlatformHeight) {
				newPlatform.y = mostCurrentPlatform.y;
				newPlatform.height = midPlatformHeight;
			} else if (mostCurrentPlatform.height == midPlatformHeight) {
				var rand = Math.random();
				if (rand > .5) {
					newPlatform.y = mostCurrentPlatform.y /* -cameraOffSetY/30 */ ;
					newPlatform.height = highPlatformHeight;
				} else {
					newPlatform.y = mostCurrentPlatform.y /* -cameraOffSetY/30 */ ;
				}
			}
			/** Where the new platforms are spawning in */
			newPlatform.x = mostCurrentPlatform.x + mostCurrentPlatform.width;
			this.addChild(newPlatform);
			platforms.push(newPlatform);


		}
		/**
		*function to update the score system and ensure the final score is correct
		*/
		private function updateScore(): void {
			score = score + 1;
			textScore.text = "Score: " + score;
			LoseScene.finalScore = score;
		}
		/** function to set the particle system to correctly start setting up particles */
		private function spawnParticles(): void{
						
			if(player.powerup == "Jump"){
				var p:ParticleJump = new ParticleJump(player.x, player.y);
				addChild(p);
				particleJump.push(p);
			}
			
			if(player.powerup == "Flames"){
				var f:ParticleFlame = new ParticleFlame(player.x, player.y);
				addChild(f);
				particleFlame.push(f);
			}
			
			if(player.powerup == "Spikes"){
				var a:ParticleSpike = new ParticleSpike(player.x, player.y);
				addChild(a);
				particleSpike.push(a);
			}
		}

		/**
		 * Checks for collisions between game objects.
		 */
		private function doCollisionDetection(): void {
			detectPlayerPlatformCollision();
			detectPlayerOOB();
			detectPlayerEnemyCollisions();
			detectEnemyPlatformCollisions();
			detectPlayerBulletBadCollisions();
			detectEnemyBulletCollisions();
			detectPlayerBuffCollisions();
			
			player.x += cameraOffSet.x;


			// ends for loop


		} // ends doCollisionDetection 
		/** Checks for collisions between the player and platforms */
		private function detectPlayerPlatformCollision(): void {

			for (var i: int = 0; i < platforms.length; i++) {
				if (player.collider.checkOverlap(platforms[i].collider)) { // if overlapping
					// find the fix:
					var fix: Point = player.collider.findOverlapFix(platforms[i].collider);
					// apply the fix:
					player.applyFix(fix);
					//trace(fix);
					//return
				}
				//trace("no hit");
				//player.x = 640;
			}
		}
		/** Checks for collisions between the player and the outer boundaries */
		private function detectPlayerOOB(): void {
			if (player.y > 750 && player.y > platforms[1].y) {
				shouldSwitchToLose = true;
			}
		}

		/** Checks for collisions between the player and enemies */
		private function detectPlayerEnemyCollisions(): void {
			for (var i: int = 0; i < enemies.length; i++) {
				var enemy = enemies[i]
				if (player.collider.checkOverlap(enemy.collider)) {
					if (player.velocity.y > 0 && player.x < enemy.x + enemy.width / 2 && player.x > enemy.x - enemy.width / 2) // player is falling on top of the enemy
					{
						enemy.isDead = true;

					} else //collision where the player is not falling ontop of the enemy
					{
						if (player.powerup == "Spikes") {
							enemy.isDead = true;
						}
						else this.shouldSwitchToLose = true;
						
					}

				}
			}
		}

		/** Checks for collisions between the player and bad bullets */
		private function detectPlayerBulletBadCollisions(): void {
			for (var i: int = 0; i < bulletsBad.length; i++) {
				var bulletBad = bulletsBad[i]
				if (player.collider.checkOverlap(bulletBad.collider)) {
					this.shouldSwitchToLose = true;
				}
			}
		}

		/** Checks for collisions between the player and buffs */
		private function detectPlayerBuffCollisions(): void {
			for (var i: int = 0; i < buffs.length; i++) {
				var buff = buffs[i]
				if (player.collider.checkOverlap(buff.collider)) {
					buff.isDead = true;
					player.powerup = "none";
					player.powerup = buff.getType();

				}
			}
		}


		/** Checks for collisions between the enemies and the bullets */
		private function detectEnemyBulletCollisions(): void {
			for (var i: int = 0; i < bullets.length; i++) {
				for (var j: int = 0; j < enemies.length; j++) {
					if (enemies[j].collider.checkOverlap(bullets[i].collider)) {
						enemies[j].isDead = true;
						
					}
				}
			}
		}

		/** Checks for collisions between the enemies and the platforms */
		private function detectEnemyPlatformCollisions(): void {
			for (var i: int = 0; i < platforms.length; i++) {
				for (var j: int = 0; j < enemies.length; j++) {
					if (enemies[j].collider.checkOverlap(platforms[i].collider)) {
						var fix: Point = enemies[j].collider.findOverlapFix(platforms[i].collider);
						enemies[j].applyFix(fix);
					}
				}
			}
		}

		/**
		 * This moves everything in the scene to make create a camera moving effect.
		 * Everything in the game world that is not the player goes in here.
		 */
		private function moveCamera(): void {

			for (var i: int = 0; i < platforms.length; i++) {
				platforms[i].y += cameraOffSet.y * Time.dt;
				platforms[i].x += cameraOffSet.x * Time.dt - (player.velocity.x * Time.dt);
			}
			for (var e: int = 0; e < enemies.length; e++) {
				enemies[e].y += cameraOffSet.y * Time.dt;
				enemies[e].x += cameraOffSet.x * Time.dt - (player.velocity.x * Time.dt);
			}
			for (var b: int = 0; b < bullets.length; b++) {
				bullets[b].y += cameraOffSet.y * Time.dt;
				bullets[b].x += cameraOffSet.x * Time.dt - (player.velocity.x * Time.dt);
			}
			for (var bb: int = 0; bb < bulletsBad.length; bb++) {
				bulletsBad[bb].y += cameraOffSet.y * Time.dt;
				bulletsBad[bb].x += cameraOffSet.x * Time.dt - (player.velocity.x * Time.dt);
			}
			for (var bf: int = 0; bf < buffs.length; bf++) {
				buffs[bf].y += cameraOffSet.y * Time.dt;
				buffs[bf].x += cameraOffSet.x * Time.dt - (player.velocity.x * Time.dt);
			}
			
		}

		/**
		 * This calculates how far the player is from the middle of the screen.
		 * The distance from the middle of the screen is the cameraOffSet.
		 */
		private function calcCameraOffSet(): void {
			cameraOffSet.y = this.stage.stageHeight / 2 - player.y;
			//trace(cameraOffSetY);
			if (player.x >= this.stage.stageWidth / 2) {
				cameraOffSet.x = this.stage.stageWidth / 2 - player.x;
			} else cameraOffSet.x = 0;
			//trace(cameraOffSet.x);

		}

		/** 
		 * updates all the enemies in the enemies collection
		 */
		private function updateEnemies(): void {
			msTimeUntilEnemySpawn -= Time.dt;

			if (msTimeUntilEnemySpawn <= 0 && platforms.length > 1) {
				var newEnemy = Enemy.spawnEnemy(stage, platforms[platforms.length - 1]);
				enemies.push(newEnemy);
				this.addChild(newEnemy);
				msTimeUntilEnemySpawn = 3;
			}

			for (var i = enemies.length - 1; i >= 0; i--) {
				var enemy = enemies[i];
				enemy.update(this.player);

				if (enemy.getType() == "Flying") {
					if (enemy.shouldShoot) {
						spawnBullet(enemy);
						enemy.reloadWeapon();
					}
				}

				if (enemy.isDead || enemy.x <= -1000)  {
					spawnBuffs(enemies[i]);
					enemies.splice(i, 1);
					removeChild(enemy);
				}
			}

		}

		/** Is run when the mouse is clicked, spawns bullets from the player */
		private function handleClick(e: MouseEvent): void {
			if (player.powerup == "Flames") spawnBullet(null, new Point(e.stageX, e.stageY));

		}

		/** Spawns a bullet object from a player or from the enemy */
		public function spawnBullet(e: Enemy = null, mousePosition: Point = null): void {
			var b: Bullet = new Bullet(player, e, mousePosition);
			addChild(b);
			if (e) bulletsBad.push(b);
			else bullets.push(b);
			var shoot: FlameHit = new FlameHit;
			shoot.play();
		}


		/** Iterates through the bullet collection and calls the bullet's update function */
		private function updateBullets(): void {
			for (var i = bullets.length - 1; i >= 0; i--) {
				var bullet = bullets[i];
				bullet.update();
				if (bullet.isDead) {
					this.removeChild(bullet);
					bullets.splice(i, 1);
				}
			}
		}

		/** Iterates through the bulletBad collection and calls the bullet's update function */
		private function updateBulletsBad(): void {
			for (var i = bulletsBad.length - 1; i >= 0; i--) {
				var bullet = bulletsBad[i];
				bullet.update();
				if (bullet.isDead) {
					this.removeChild(bullet);
					bulletsBad.splice(i, 1);
				}
			}
		}

		/**
		 * Spawns a new buff depending on the enemy destroyed
		 * @param e the enemy destroyed that is dropping the buff
		 */
		private function spawnBuffs(e: Enemy): void {
			var buff;
			if (e.getType() == "Flying") buff = new BFlames();
			if (e.getType() == "Jumping") buff = new BLegs();
			if (e.getType() == "Spiky") buff = new BSpikes();

			this.addChild(buff);

			buff.x = e.x;
			buff.y = e.y;

			buffs.push(buff);
		}
		/** 'updates' the buffs. The only thing to update is to remove it if it is dead */
		private function updateBuffs(): void {
			for (var i = buffs.length - 1; i >= 0; i--) {
				var buff = buffs[i];
				buff.update();
				if (buff.isDead) {
					removeChild(buff);
					buffs.splice(i, 1);
				}
			}
		}
		/** updates all particles in effect at the current moment. Removes 
		* removes particles when they are dead and moves them around when they come into play. 
		*/
		private function updateParticles(): void{
				
			/**updates the jump particles */
			for(var i:int = 0; i < particleJump.length; i++){
				particleJump[i].update();
				if(particleJump[i].isDead){
					removeChild(particleJump[i]);
					particleJump.splice(i,1);
				}
			}
			/**updates the flame particles */
			for(var f:int = 0; f < particleFlame.length; f++){
				particleFlame[f].update();
				if(particleFlame[f].isDead){
					removeChild(particleFlame[f]);
					particleFlame.splice(f,1);
				}
			}
			/**updates the spike particles */
			for(var l:int = 0; l < particleSpike.length; l++){
				particleSpike[l].update();
				if(particleSpike[l].isDead){
					removeChild(particleSpike[l]);
					particleSpike.splice(l,1);
				}
			}
			
		}


	}

}