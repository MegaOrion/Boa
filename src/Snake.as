package 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author MegaOrion
	 */
	public class Snake extends Sprite
	{		
		public var snakeSection: Sprite;
		public var snakeArray: Array = [];
		public var currentX: int;
		public var currentY: int;
		
		public function Snake() 
		{
			
		}
		
		public function removeSnake(): void {
			for (var i: uint = snakeArray.length - 1; i > 0; i--){
				removeChild(snakeArray[i]);
				snakeArray.splice(i,1);
			};
		}
		
		public function generateSnake(): void {
			currentX = 19;
			currentY = 18;			
			drawSection();
			placeSection();
		}
		
		public function placeSection(): void {	
			for (var i: uint = 0; i < snakeArray.length; i++) {
				snakeArray[i].x = currentX * 15 + 1092 / 2;
				snakeArray[i].y = currentY * 15 + 10;
			}
		}
		
		public function drawSection(): void {
			for (var i: uint = 0; i < 3; i++) {
				snakeSection = new Sprite();
				snakeSection.graphics.lineStyle(0, 0x00FF00, 1);
				snakeSection.graphics.beginFill(0x00FF00);
				snakeSection.graphics.drawRect(0, 0, 15, 15);
				snakeSection.graphics.endFill();
				snakeSection.x = i + currentX * 15 + 1092 / 2;
				snakeSection.y = currentY * 15 + 10;
				snakeArray.push(snakeSection);
				addChild(snakeSection);
			}
		}
	}

}