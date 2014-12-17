package com.goven
{
	import flash.display.Sprite;
	
	public class Feather extends Sprite
	{
		private static const MIN_W:Number=10;
		private static const MIN_H:Number=10;
		private static const MAX_W:Number=60;
		private static const MAX_H:Number=60;
		private static const SPEED_AM:Number=3
		
		private var _xSpeed:Number=0;
		private var _ySpeed:Number=0
			
		public var direction:int=0
		public function Feather()
		{
			super();
		}
		
		public function init():void{
			
			var x1:Number=Math.random()*(MAX_W-MIN_W)
			var y1:Number=Math.random()*(MAX_H-MIN_H)
				
			var x4:Number=Math.random()*(MAX_W-MIN_W)
				
			var x2:Number=Math.random()*(MAX_W-MIN_W)+Math.max(x1,x4)
			var y2:Number=Math.random()*(MAX_H-MIN_H)			
			var x3:Number=Math.random()*(MAX_W-MIN_W)+Math.max(x1,x4)
			var y3:Number=Math.random()*(MAX_H-MIN_H)+Math.max(y1,y2)
			
			var y4:Number=Math.random()*(MAX_H-MIN_H)+Math.max(y1,y2)
				
			var clo:uint=Math.random()*uint(0xffffff)
			graphics.clear()
			graphics.beginFill(clo,1)
			graphics.moveTo(-x1*.5,y1)
			graphics.lineTo(-x2*.5,y2)
			graphics.lineTo(-x3*.5,y3)
			graphics.lineTo(-x4*.5,y4)
			graphics.lineTo(-x1*.5,y1)
			graphics.endFill()
			
			_xSpeed=Math.random()*SPEED_AM+ SPEED_AM
			_ySpeed=Math.random()*5+5
			this.rotation=Math.random()*180;
			_rotationSpeed=Math.random()*5-2.5
			alpha=1
		}
		
		private var _rotationSpeed:Number
		public function update():void{
			if(direction==0){
				x-=_xSpeed
			//	rotation +=5
			}else{
				x+=_xSpeed
			//	rotation -=5
			}
		
			rotation+=_rotationSpeed
			y+=_ySpeed
			
			alpha-=0.005
		}
	}
}