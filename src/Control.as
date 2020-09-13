package 
{
	import Game;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	public class Control extends Game
	{
		private var btnStart: Sprite;
		public function Control() 
		{
			addBtnStart();
			btnStart.addEventListener(MouseEvent.CLICK, onStart);
		}
		
		public function onStart(e: MouseEvent): void {
			removeChild(btnStart);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			generateField();								
			snake.generateSnake();			
			addChild(snake);
			generateApple();
		}
		
		public function addBtnStart(): void {
			btnStart = new Sprite();
			btnStart.graphics.lineStyle(1, 0x000000);
			btnStart.graphics.beginFill(0x555555);
			btnStart.graphics.drawCircle(750, 200, 50);
			btnStart.graphics.endFill();
			btnStart.buttonMode = true;
			addChild(btnStart);
		}
		
		public function onKeyDown(e: KeyboardEvent): void {
			if (!moving) {
				timeCount.start();				
				moveSnake();
				moving = true;
			}
			switch (e.keyCode) {
				case 37:
					if (direction != "right") {						
						direction = "left";
					}
					break;
				case 38:
					if (direction != "down") {						
						direction = "up";
					}
					break;
				case 39:
					if (direction != "left") {					
						direction = "right";
					}
					break;
				case 40:
					if (direction != "up") {
						direction = "down";
					}
					break;
			}
		}
	}
}