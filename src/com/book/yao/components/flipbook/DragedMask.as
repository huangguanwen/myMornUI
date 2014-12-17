package com.book.yao.components.flipbook 
{
	import flash.display.Shape;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author yaoguozhen
	 */
	internal class DragedMask extends Shape
	{
		
		public function DragedMask():void
		{
		   
		}
		public function draw(cPoint:Point,dPoint:Point,bPoint:Point,aPoint:Point=null):void
		{
			graphics.clear();
			graphics.beginFill(0x0000ff);	
			graphics.moveTo(cPoint.x, cPoint.y);
			graphics.lineTo(dPoint.x, dPoint.y);
			graphics.lineTo(bPoint.x, bPoint.y);
			
			if(aPoint!=null)//如果没有a点
			{
				graphics.lineTo(aPoint.x, aPoint.y);
			}
			
			graphics.endFill()
		}
		public function clear():void
		{
			graphics.clear();
		}
	}

}