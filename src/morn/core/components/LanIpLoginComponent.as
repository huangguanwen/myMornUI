package morn.core.components
{
	import flash.events.MouseEvent;
	
	import morn.core.handlers.Handler;
	
	
	
	/**
	 * 局域网IP登录组件
	 *@author 偷心枫贼
	 *        下午4:31:53
	 *
	 */
	public class LanIpLoginComponent extends __LanIpLoginComponent_base
	{
		
		private var _outIpHandler:Handler;
		public function get outIpHandler():Handler { return _outIpHandler; }
		public function set outIpHandler(value:Handler):void
		{
			if (_outIpHandler == value)
				return;
			_outIpHandler = value;
		}
		
		/**
		 * 提交按钮  
		 * @return 
		 * 
		 */		
		public function get submitButton():Button{return _submitButton}
		
		
		override public function set disabled(value:Boolean):void
		{
			// TODO Auto Generated method stub
			super.disabled = value;
			_submitButton.disabled=value
			for each(var b:Button in _btns){
				b.disabled=value
			}
			_ipInput.disabled=value
		}
		
		
		//private var _state:String;
		
		
		
		/**
		 * 当前状态 
		 * @return 
		 * 
		 */		
		public function get state():String { return _submitButton.label; }	
		public function set state(value:String):void
		{
			_submitButton.label=value;
		}
		
		/**
		 *  
		 * 
		 */		
		public function LanIpLoginComponent()
		{
			super();	
			listeners()
		}
		private function listeners():void{
			for each(var btn:Button in _btns){
				btn.addEventListener(MouseEvent.CLICK,onMouseClickNumBtn)
			}
			
			_submitButton.addEventListener(MouseEvent.CLICK,onMouseClickSubmit)
		}
		private function onMouseClickSubmit(e:MouseEvent):void{
			if(_outIpHandler!=null){
				_outIpHandler.executeWith([_ip])
			}
		}
		private function onMouseClickNumBtn(e:MouseEvent):void{
			var btn:Button=e.target as Button
			if(btn.label=="←"){
				//删除
				_ipInput.text=_ipInput.text.substr(0,_ipInput.text.length-1)
			}else{
				if(_ipInput.text.length<_maxChars){
					_ipInput.appendText(btn.label)
				}
				
			}		
			
			_ip=_ipInput.text
		}
		
	}
}

