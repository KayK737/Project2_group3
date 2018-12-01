﻿package code {
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	
	public class EnemyBoom extends MovieClip {
		
		protected var acceleration:Point = new Point(0, 10);
		protected var velocity:Point = new Point(0, 10);
		
		protected var angularVelocity:Number = 0;
		
		protected var lifeSpan:Number;
		protected var age:Number = 0;
		
		public var isDead:Boolean = false;
		
		public function EnemyBoom(spawnX:Number, spawnY:Number) {
			// constructor code
			x = spawnX;
			y = spawnY;
			
			velocity.x = Math.random() * 600 - 200;
			velocity.y = Math.random() * 500 - 350;
			
			rotation = Math.random() * 360;
			angularVelocity = Math.random() * 180 - 90;
			
			scaleX = Math.random() * .2 + .1;
			scaleY = scaleX;
			
			lifeSpan = Math.random() *1.5 + .5;
			
		}
		public function update():void{
			
		
			
			rotation += angularVelocity * Time.dt;
			
			velocity.x += acceleration.x * Time.dt;
			velocity.y += acceleration.y * Time.dt;
			
			x += velocity.x * Time.dt;
			y += velocity.y * Time.dt;
			
			age += Time.dt;
			
			if(age > lifeSpan)isDead = true;
		}
	}
	
}

