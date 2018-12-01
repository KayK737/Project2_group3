package code {
	import flash.display.MovieClip;
    /** abstract class which is inherited by the other buffs */
	public class Buff extends MovieClip {
		
		public function Buff() {
			this.collider = new AABB(width/2, height/2);
		}
		
		
		/** variable needed to detect aabb collison */
		public var collider: AABB;
		
		public var isDead:Boolean = false;

		/** 
		 *Function overrided by child classes which returns the type of buff it is
		 *@return A string which describes the buff
		 */
		public function getType():String {
			return "none"
		}
		
		public function update():void {
			this.collider.calcEdges(this.x, this.y);
			if (this.x <= -1000) isDead = true;
		}

	}
	
}