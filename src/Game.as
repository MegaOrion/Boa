package 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.utils.Timer;
	import Snake;
	
	public class Game extends Sprite
	{
		public var snake: Snake = new Snake();
		
		[Embed(source = "../assets/carbon.jpg")]private var BackGround: Class;
		private var bg: Bitmap = new BackGround() as Bitmap;
		
		[Embed(source = "../assets/eating.mp3")]private var snd: Class;
		private var eatingSnd: Sound = new snd() as Sound;
		
		public var moving: Boolean = false;
		public var direction: String = "";
		private var fieldArray: Array;
		private var fieldSprite: Sprite;
		private var apple: Sprite;
		private var interval: int = 100;
		public var timeCount: Timer = new Timer(interval);
		private var score: TextField = new TextField();
		public var scoreStr: TextField = new TextField();
		private var scoreCount: uint = 0;
		
		public function Game() 
		{
			addChild(bg);
			showScore();	
			timeCount.addEventListener(TimerEvent.TIMER, onTime);			
		}		
		
		public function showScore(): void {
			scoreStr.text = scoreCount.toString(10);
			score.text = "SCORE: ";
			score.textColor = 0xFFFFFF;			
			score.x = 1092 / 4;
			score.y = 600 / 4 - 10;
			addChild(score);
			scoreStr.textColor = 0xFFFFFF;
			scoreStr.x = 1092 / 4;
			scoreStr.y = 600 / 4 + 10;
			addChild(scoreStr);
		}
		
		public function reset(): void {
			scoreCount = 0;
			showScore();
			moving = false;
			removeChild(apple);
			generateApple();			
			snake.removeSnake();
			snake.generateSnake();
			direction = "";
			timeCount.stop();
			timeCount.removeEventListener(TimerEvent.TIMER, onTime);
			interval = 100;
			timeCount = new Timer(interval);
			timeCount.addEventListener(TimerEvent.TIMER, onTime);
		}
		
		public function onTime(e: TimerEvent): void {
			eatApple();
			switch (direction) {
				case "left":
					if (canMove(snake.currentX - 1, snake.currentY)) {						
						snake.currentX--;
					}
					break;
				case "up":
					if (canMove(snake.currentX, snake.currentY - 1)) {
						snake.currentY--;
					}
					break;
				case "right":
					if (canMove(snake.currentX + 1, snake.currentY)) {						
						snake.currentX++;
					}
					break;
				case "down":
					if (canMove(snake.currentX, snake.currentY + 1)) {						
						snake.currentY++;
					}
					break;
			}
			moveSnake();
			clashTail();
		}
		
		public function clashTail(): void {
			for(var i: uint = snake.snakeArray.length - 1; i >= 1; --i){
				if (snake.snakeArray[0].x == snake.snakeArray[i].x && snake.snakeArray[0].y == snake.snakeArray[i].y) {
					reset();
					break;
				}
			}
		}
		
		public function eatApple(): void {
			for(var i: uint = snake.snakeArray.length-1; i >= 1; --i){
				if(snake.snakeArray[0].x == apple.x && snake.snakeArray[0].y == apple.y){
					scoreCount += 1000;
					showScore();
					eatingSnd.play();
					snake.snakeSection = new Sprite();
					snake.snakeSection.graphics.lineStyle(0, 0x00FF00, 1);
					snake.snakeSection.graphics.beginFill(0x00FF00);
					snake.snakeSection.graphics.drawRect(0, 0, 15, 15);
					snake.snakeSection.graphics.endFill();
					snake.snakeSection.x = snake.snakeArray[snake.snakeArray.length - 1].x;
					snake.snakeSection.y = snake.snakeArray[snake.snakeArray.length - 1].y;
					snake.snakeArray.push(snake.snakeSection);
					snake.addChild(snake.snakeSection);
					removeChild(apple);
					generateApple();
					timeCount.removeEventListener(TimerEvent.TIMER, onTime);
					timeCount.stop();
					timeCount = new Timer(interval -= interval * 0.05);
					timeCount.addEventListener(TimerEvent.TIMER, onTime);
					timeCount.start();
					break;
				}
			}
		}
		
		public function moveSnake(): void {
			var last: Sprite = snake.snakeArray[snake.snakeArray.length -1];
			last.x = snake.currentX * 15 + 1092 / 2;
			last.y = snake.currentY * 15 + 10;
			snake.snakeArray.unshift(last);
			snake.snakeArray.pop();
		}
		
		public function generateApple(): void {
			apple = new Sprite;
			apple.x = Math.floor(Math.random() * 36) * 15 + 1092 / 2;
			apple.y = Math.floor(Math.random() * 38) * 15 + 10;			
			addChild(apple);
			apple.graphics.lineStyle(0, 0xFF0000, 1);
			apple.graphics.beginFill(0xFF0000);
			apple.graphics.drawRect(0, 0, 15, 15);
			apple.graphics.endFill();
		}		
		
		public function canMove(row: int, col: int): Boolean {
			if (col < 0 || col >= 38 || row >= 36 || row < 0){
				reset();
				return false;
			}
				
			return true;
		}		
		
		public function generateField(): void {
			scoreCount = 0;
			fieldArray = new Array();
			fieldSprite = new Sprite();
			for (var i: uint = 0; i < 38; i++) {
				fieldArray[i] = new Array;
				for (var j: uint = 0; j < 36; j++) {
					fieldArray[i][j] = 0;
					fieldSprite.graphics.beginFill(0xFFFFFF, 0.2);
					fieldSprite.graphics.drawRect(15*j + 1092 / 2, 15*i + 10, 15, 15);
					fieldSprite.graphics.endFill();
				}
			}
			addChild(fieldSprite);
		}		
	}
}