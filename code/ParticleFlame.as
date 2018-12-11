package code {
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	
	public class ParticleFlame extends MovieClip {
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
		public function ParticleFlame(spawnX:Number, spawnY:Number) {
			/**gives location of where particle will spawn */
			x = spawnX;
			y = spawnY - 20;
			/**velocity of particle when it spawns in */
			velocity.x = Math.random() * 40 - 30;
			/**acceleration of the particle updating every frame */
			acceleration.y = 50 - 60;
			acceleration.x = 30 - 40;
			/**how the particle will rotate */
			rotation = Math.random() * 360;
			/**the angular velocity of the particle */
			angularVelocity = Math.random() * 180 - 90;
			/** the scale of the particle in (x,y) */
			scaleX = Math.random() * .3 + .5;

			/** How long the particle will live */
			lifeSpan = Math.random() * .5 + .5;
		}
		public function update():void{
			/**how transparent the particle is */
			alpha = .9 - age/lifeSpan;
			/**How the object will rotate */
			rotation += angularVelocity * Time.dt;
			/** how the velocity will update as per is acceleration */
			//velocity.x += acceleration.x * Time.dt;
			velocity.y += acceleration.y * Time.dt;
			/** How the x and y will update based on its velocity */
			x += velocity.x * Time.dt;
			y -= velocity.y * Time.dt;
			/** How the program determines when an object is dead */
			age += Time.dt;
			/**allowes the particle to be deleted once it is dead */
			if(age > lifeSpan) isDead = true;
		}
	}
	
}
