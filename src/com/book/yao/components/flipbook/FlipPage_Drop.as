package com.book.yao.components.flipbook
{
	import com.book.yao.components.flipbook.events.HotEvent;

	[Event(name="pressed", type="com.book.yao.components.flipbook.events.HotEvent")]
	[Event(name="draged", type="com.book.yao.components.flipbook.events.HotEvent")]
	[Event(name="released", type="com.book.yao.components.flipbook.events.HotEvent")]
	
	/**
	 * 可以用鼠标进行拖动四个角进行翻书 
	 * @author Administrator
	 * 
	 */
	public class FlipPage_Drop extends FlipPage
	{
		public function FlipPage_Drop(pageWidth:Number, pageHeight:Number, hotWidth:Number=50)
		{
			super(pageWidth, pageHeight, hotWidth);
			
		
			_hot.addEventListener(HotEvent.PRESSED, hotPressedHandler);//在热区按下
			_hot.addEventListener(HotEvent.RELEASED, hotReleasedHandler);//在热区按下后松开
			_hot.addEventListener(HotEvent.DRAGED, hotDragedHandler);//在热区按下后并拖动
			
	
	
		}
		
		
		override public function dispose():void{
			super.dispose();
			_hot.removeEventListener(HotEvent.PRESSED, hotPressedHandler);//在热区按下
			_hot.removeEventListener(HotEvent.RELEASED, hotReleasedHandler);//在热区按下后松开
			_hot.removeEventListener(HotEvent.DRAGED, hotDragedHandler);//在热区按下后并拖动
		}
		
		//在热区上按下
		private function hotPressedHandler(evn:HotEvent):void
		{
			trace(evn)
			if (evn.hotName == HotName.LEFT_DOWN || evn.hotName == HotName.LEFT_UP)
			{
				if (_page.prevPage)//如果上一页准备好了
				{
					_page.loadingType = "";
					_page.closeLoader();
					
					_canBeDraged = true;
					_halfPage.addAllPage(_page.prevPage, "left");//生成半页
				}
				else
				{
					_canBeDraged = false;
				}
			}
			else if (evn.hotName == HotName.RIGHT_DOWN || evn.hotName == HotName.RIGHT_UP)
			{
				if (_page.nextPage)
				{
					_page.loadingType = "";
					_page.closeLoader();
					
					_canBeDraged = true;
					_halfPage.addAllPage(_page.nextPage, "right");
				}
				else
				{
					_canBeDraged = false;
				}
			}
			dispatchEvent(evn)
		}
		
		
		//在热区上按下并松开
		private function hotReleasedHandler(evn:HotEvent):void
		{
			if (_canBeDraged)
			{
				if (_hot.draged)//如果移动过
				{
					_checkPoint.autoFlipAferDrag();
				}
				else//如果没有移动过
				{
					_checkPoint.autoFlip(_hot.pressedHotName);
				}
				_canBeDraged = false;
				dispatchEvent(evn)
			}
		}
		
		
		//在热区上按下并且拖动
		private function hotDragedHandler(evn:HotEvent):void
		{
			if (_canBeDraged)
			{
				_checkPoint.checkPoints(mouseX, mouseY, _hot.pressedHotName);
				dispatchEvent(evn)
			}
		}
		
	}
}