package code {
	
	import flash.display.MovieClip;
	
	
	public class LoseScene extends GameScene {
		
		
		public function SceneLose() {
			// constructor code
		}
		override public function update(keyboard:KeyboardInput):GameScene {
			
			if(KeyboardInput.keyEnter) return new TitleScene(); 
			
			return null;
		}
		
		override public function onBegin():void {
			//bttnPlay.addEventListener(MouseEvent.MOUSE_DOWN, handleClickPlay);
			trace("Enter LoseScene");
		}
		override public function onEnd():void {
			//bttnPlay.removeEventListener(MouseEvent.MOUSE_DOWN, handleClickPlay);
			trace("Exit LoseScene");
		}
	}
	
}
