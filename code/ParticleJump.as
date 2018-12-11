package code {
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	
	public class ParticleJump extends MovieClip {
		/**variable that gives a value for acceleration */
		protected var acceleration:Point = new Point(0, 10);
		/**variable that gives a value for velocity */
		protected var velocity:Point = new Point(0, 10);
		/**variable that gives a value for angular rotation*/
		protected var angularVelocity:Number = 0;
		/**variable that gives a value for livespan */
		protected var lifeSpan:Number;
		/**variable that gives a value for age */
		protected var age:Number = 0;
		/** Tells when a particle is dead and can be removed */
		public var isDead:Boolean = false;
		
		/**
		* @param spawnX, spawnY gives the location that particle will spawn 
		*/	
		public function ParticleJump(spawnX:Number, spawnY:Number) {
			/**gives location of where particle will spawn */
			x = spawnX;
			y = spawnY + 20;
			
			/**velocity of particle when it spawns in */
			velocity.x = Math.random() * 600 - 200;
			velocity.y = Math.random() * 400 - 350;
			
			/**how the particle will rotate */
			rotation = Math.random() * 360;
			/**the angular velocity of the particle */
			angularVelocity = Math.random() * 180 - 90;
			/** the scale of the particle in (x,y) */
			scaleX = Math.random() * .2 + .1;
			scaleY = scaleY + .3;
			/** How long the particle will live */
			lifeSpan = Math.random() * .4 + .1;
			/**how transparent the particle is */
			alpha = .5;
		}
		public function update():void{
			/**How the object will rotate */
			rotation += angularVelocity * Time.dt;
			/** how the velocity will update as per is acceleration */
			velocity.x -= acceleration.x * Time.dt;
			velocity.y += acceleration.y * Time.dt;
			/** How the x and y will update based on its velocity */
			x += velocity.x * Time.dt;
			y -= velocity.y * Time.dt;
			/** How the program determines when an object is dead */
			age += Time.dt;
			if(age > lifeSpan) isDead = true;
		}
	}
	
}
