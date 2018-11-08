package code {
	import flash.events.MouseEvent;
	
	public class TitleScene extends GameScene {
		
		
		private var shouldSwitchToPlay:Boolean = false;
		
		override public function update(keyboard:KeyboardInput):GameScene {
			
			if(shouldSwitchToPlay) return new PlayScene();
			
			return null;
		}
		override public function onBegin():void {
			bttnPlay.addEventListener(MouseEvent.MOUSE_DOWN, handleClickPlay);
		}
		override public function onEnd():void {
			bttnPlay.removeEventListener(MouseEvent.MOUSE_DOWN, handleClickPlay);
		}
		
		private function handleClickPlay(e:MouseEvent):void {
			shouldSwitchToPlay = true;
		}
		
	}
	
}