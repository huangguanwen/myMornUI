package morn.core.components.live
{
	import flash.display.Graphics;
	
	import morn.core.components.ComboBox;
	
	/** 
	 * @Content 
	 * @Author HuangGuanWen
	 * @E-mail: 527025965@qq.com
	 * @Version 1.0.0 
	 * @Date：2013-10-18 下午3:24:38 
	 */
	public class LiveComboBox extends ComboBox
	{
		
		
		
		public function LiveComboBox(skin:String=null, labels:String=null)
		{
			super(skin, labels);
		}
		
		override public function set labelSize(value:Object):void
		{
			// TODO Auto Generated method stub
			super.labelSize = value;
			
		}
		
		override protected function changeItem():void
		{
			// TODO Auto Generated method stub
			//赋值之前需要先初始化列表
			exeCallLater(changeList);
			
			//显示边框
			_listHeight = _labels.length > 0 ? Math.min(_visibleNum, _labels.length) *  _button.height :  _button.height;
			_scrollBar.height = _listHeight - 2;
			//填充背景
			var g:Graphics = _list.graphics;
			g.clear();
			g.lineStyle(1, _itemColors[3]);
			g.beginFill(_itemColors[4]);
			g.drawRect(0, 0, width - 1, _listHeight);
			g.endFill();
			//填充数据			
			var a:Array = [];
			for (var i:int = 0, n:int = _labels.length; i < n; i++) {
				a.push({label: _labels[i]});
			}
			_list.array = a;
		}
		
		
		override protected function changeList():void {
			var labelWidth:Number = width - 2;
			var labelHeight:Number = _button.height
			var labelColor:Number = _itemColors[2];
			var size:Number=Number(_button.labelSize);
		
			
			list.itemRender = new XML("<Box><Label name='label' size='"+size+ "'width='" + labelWidth + "' height='" + labelHeight + "' color='" + labelColor + "' x='1' /></Box>");
			list.repeatY = _visibleNum;
			
			_scrollBar.x = width - _scrollBar.width - 1;
			_list.refresh();
		}
		
		
		
		

		
		
		
	}
}