package morn.core.components
{
	import com.greensock.TweenLite;
	
	
	/**
	 *@author 偷心枫贼
	 *        下午5:08:15
	 *
	 */
	public class LiveProgressBar extends ProgressBar
	{
		public function LiveProgressBar(skin:String=null)
		{
			super(skin);
		
		}
		
		override protected function changeValue():void {
			try
			{
				TweenLite.killTweensOf(_bar)
			} 
			catch(error:Error) 
			{
				
			}
			if (sizeGrid) {
				var grid:Array = sizeGrid.split(",");
				var left:Number = grid[0];
				var right:Number = grid[2];
				var max:Number = width - left - right;
				var sw:Number = max * _value;
				TweenLite.to(_bar,.3,{width: left + right + sw})
			//	_bar.width = left + right + sw;
				_bar.visible = _bar.width > left + right;
			} else {
			//	_bar.width = width * _value;
				
				TweenLite.to(_bar,.3,{width:width * _value})
			}
		}
	}
}