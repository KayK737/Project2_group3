package code {
	
	import flash.display.MovieClip;
	
	/** The buff which gives the player the ability to shoot */
	public class BFlames extends Buff {
		/** 
		 *Function overridden from the parent class which returns the type of buff it is
		 *@return A string which describes the buff
		 */
		public override function getType():String {
			return "Flames"
		}
	}
	
}
