package code {
	import flash.display.MovieClip;

	public class Buff extends MovieClip {

		public function Buff() {
			// constructor code
		}


		/** 
		 *Function overrided by child classes which returns the type of buff it is
		 *@return A string which describes the buff
		 */
		public function getType():String {
			return "none"
		}

	}
	
}