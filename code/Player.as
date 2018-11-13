﻿package code {
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	/**
	 * This class contains the behavior of the player object.
	 */
	public class Player extends MovieClip {
		
		/** Holds the base gravity that the player will always be reset to. */
		private const baseGravity: Point = new Point(0, 2500);
		/** Holds the curret gravity of the player. */
		private var gravity: Point = new Point(0, 2500);
		/** The X and Y velocity of the player. */
		private var velocity: Point = new Point(0, 0);
		/** The maximum horizontal Speed the player can reach. */
		private var maxSpeed: Number = 300;
		/** The amount of times the player has jumped since touching the ground (should max at 2). */
		private var jumpCount: Number = 0;
		/** Keeps track of if the player is in the air from a jump. */
		private var isGrounded: Boolean = false;
		/** Keeps track of if the player is moving upward, effects gravity. */
		private var isJumping: Boolean = false;
		/** The rate at which the player can accelerate on the horizontal axis. */
		private const HORIZONTAL_ACCELERATION: Number = 1000;
		/** The rate at which the player decelerate on the horizontal axis. */
		private const HORIZONTAL_DECELERATION: Number = 800;
		/** The rate at which the player can accelerate on the vertical axis. */
		private const VERTICAL_ACCELERATION: Number = 1500;
		/** The impulse velocity that is added when the player jumps. */
		private var jumpVelocity: Number = 600;
		
		
		public function Player() {
			// constructor code
		}
		
		public function update():void{
			handleWalking();
			
			doPhysics();
			
			detectGround();
			//trace("hello");
		}
		
		/**
		 * This function looks at the keyboard input in order to accelerate the player
		 * left or right. As a result , this function changes the player's velocity.
		 */
		private function handleWalking(): void {
			
			if (KeyboardInput.IsKeyDown(Keyboard.LEFT) || KeyboardInput.IsKeyDown(Keyboard.A)) velocity.x -= HORIZONTAL_ACCELERATION * Time.dt;
			if (KeyboardInput.IsKeyDown(Keyboard.RIGHT) || KeyboardInput.IsKeyDown(Keyboard.D)) velocity.x += HORIZONTAL_ACCELERATION * Time.dt;

			if (!KeyboardInput.IsKeyDown(Keyboard.LEFT) && !KeyboardInput.IsKeyDown(Keyboard.RIGHT) && !KeyboardInput.IsKeyDown(Keyboard.A) && !KeyboardInput.IsKeyDown(Keyboard.D)) {
				if (velocity.x < 0) { //moving left
					velocity.x += HORIZONTAL_DECELERATION * Time.dt;
					if (velocity.x > 0) velocity.x = 0; //clamp
				}
				if (velocity.x > 0) { //moving right
					velocity.x -= HORIZONTAL_DECELERATION * Time.dt;
					if (velocity.x < 0) velocity.x = 0; //clamp
				}
			}
		}//end handleWalking
		
		/**
		 * The physics that govern the player's position.
		 */
		private function doPhysics(): void {

			var gravityMultiplier: Number = .5;

			if (!isJumping) gravityMultiplier = 1;

			// apply gravity to velocity:
			velocity.y += gravity.y * Time.dt * gravityMultiplier;

			// constrain to max speed:
			if (velocity.x > maxSpeed) velocity.x = maxSpeed;
			if (velocity.x < -maxSpeed) velocity.x = -maxSpeed;

			// apply velocity to position:
			x += velocity.x * Time.dt;
			y += velocity.y * Time.dt;
		}//end doPhysics
		
		/**
		 * This function sets a maximum y value that the player can not cross.
		 */
		private function detectGround(): void {
			//look at y position
			var ground: Number = 350;
			if (y > ground) {
				y = ground; // clamp
				velocity.y = 0;
				jumpCount = 0;
				if (isGrounded == false) isGrounded = true;
				isJumping = false;
			}
		}

	}
	
}