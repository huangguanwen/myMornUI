package com.book.yao.components.flipbook
{
	import flash.display.Shape;
	
	/**
	 * 阴影层
	 * @author yaoguozhen
	 */
	internal class ShadowMask extends Shape
	{
		
		public function ShadowMask():void
		{
			
		}
		public function creat(pageWidth:Number,pageHeight:Number):void
		{
			graphics.clear()
			graphics.beginFill(0x0000ff);
			graphics.drawRect(0,0,pageWidth,pageHeight);
			graphics.endFill()
		}
		
	}
	
}

