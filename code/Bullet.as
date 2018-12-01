package code {
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	
	public class Bullet extends MovieClip {
		
		/** variable needed to detect aabb collison */
		public var collider: AABB;
		
		
		private const SPEED:Number = 240;
		
		private var velocityX:Number = 0;
		/** The y-velocity in px/s. */
		private var velocityY:Number = 0;
		
		public var isDead:Boolean = false;
		public var radius:Number = 3;
		public var isBig = false;
		
		//var velocity:Point = new Point();
		
		public function Bullet(p:Player, e:Enemy = null, mousePosition:Point = null) {
			
			collider = new AABB(width / 2, height / 2);
			if(e){ // enemy bullet:
				x = e.x;
				y = e.y;
				
					
				var tx:Number = p.x - e.x;
				var ty:Number = p.y - e.y;
				
				var angle:Number = Math.atan2(ty, tx);
				angle += (Math.random() * 20 + Math.random() * -20) * Math.PI / 180;
				
				velocityX = SPEED * Math.cos(angle);
				velocityY = SPEED * Math.sin(angle);
				
				
				
				
			} else { // player bullet:
				
				x = p.x;
				y = p.y;
				
				var mx:Number = -p.x + mousePosition.x;
				var my:Number = -p.y + mousePosition.y;
				
				
				
				var newAngle:Number = Math.atan2(my, mx);
				
				velocityX = SPEED * Math.cos(newAngle);
				velocityY = SPEED * Math.sin(newAngle);
				
			}
			
			
			this.rotation = angle * 180 / Math.PI + 90;
		}
		
		public function update():void {
			
			x += velocityX * Time.dt;
			y += velocityY * Time.dt;
			
			collider.calcEdges(x, y);
			
			if(!stage || y < -5 || x < -5 || x > stage.stageWidth + 5 || y > stage.stageHeight + 5) isDead = true;
		}
		
	} // ends class
} // ends package
