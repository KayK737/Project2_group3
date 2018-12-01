package code {
	import flash.display.MovieClip;
    /** abstract class which is inherited by the other buffs */
	public class Buff extends MovieClip {

		/** 
		 *Function overrided by child classes which returns the type of buff it is
		 *@return A string which describes the buff
		 */
		public function getType():String {
			return "none"
		}

	}
	
}