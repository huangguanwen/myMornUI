package morn.core.components
{
	public class ColorPiece extends Component
	{
		
		private var _color:uint=0;
		/**
		 * 色块颜色 
		 * @return 
		 * 
		 */		
		public function get color():uint { return _color; }
		public function set color(value:uint):void
		{
			if (_color == value)
				return;
			_color = value;
			drawRect()
		}
		
		override public function set height(value:Number):void
		{
			// TODO Auto Generated method stub
			super.height = value;
			drawRect()
		}
		
		override public function set width(value:Number):void
		{
			// TODO Auto Generated method stub
			super.width = value;
			drawRect()
		}
		
		
		
		
		public function ColorPiece()
		{
			super();
		}
		
		
		
		
		private function drawRect():void{
			graphics.clear()
			graphics.beginFill(_color,1)
			graphics.drawRect(0,0,width,height)
			graphics.endFill()
		}
		
		
	}
}