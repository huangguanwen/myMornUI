package morn.core.components
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class ScrollMenuBox extends Box
	{
		private var _maskSprite:Sprite=new Sprite();
		
		public const contentArr:Vector.<DisplayObject>=new Vector.<DisplayObject>();
		
		override public function set height(value:Number):void
		{
			// TODO Auto Generated method stub
			super.height = value;
			reDrawMask()
			
			
		}
		public function push(content:DisplayObject):void{
			
		}
		override public function set width(value:Number):void
		{
			// TODO Auto Generated method stub
			super.width = value;
			reDrawMask()
		}
		
		
	
		
		public function ScrollMenuBox()
		{
			super();
			
			reDrawMask();
			this.mask=_maskSprite
		}
		
		
		
		
		private function reDrawMask():void{
			_maskSprite.graphics.clear();
			_maskSprite.graphics.beginFill(0,1);
			_maskSprite.graphics.drawRect(0,0,this.width,this.height);
			_maskSprite.graphics.endFill();
		}
	}
}