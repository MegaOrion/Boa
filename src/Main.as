package
{
	import Control;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	
	public class Main extends MovieClip
	{
		public var game: Control = new Control();
		
		
		public function Main()
		{			
			addChild(game);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.RESIZE, onResize);
		}	
		
		public function onResize(e: Event): void {
			game.width = stage.stageWidth;
			game.height = stage.stageHeight;
		}
	}
}