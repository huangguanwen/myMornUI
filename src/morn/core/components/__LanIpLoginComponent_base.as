package morn.core.components
{
	import morn.core.utils.StringUtils;
	
	
	/**
	 *@author 偷心枫贼
	 *        上午9:17:03
	 *
	 */
	internal class __LanIpLoginComponent_base extends Component
	{
		protected var _btns:Vector.<Button>=new Vector.<Button>()
		private var _skin:String;
		
		
		//////
		protected var _margin:Array = Styles.labelMargin;
		
		////
		private var btnw:Number
		private var btnh:Number
		///////
		
		private var _bkimg:Image
		
		///////
		protected var _ipInput:TextInput;	
		private var _ipInputColor:uint=Styles.labelColor;
		private var _ipInputSize:Number=15;
		private var _ipInputHeight:Number=30;
		
		//////
		private var _buttonSpace:Number=5;//间隔		
		private var _buttonLabelSize:Number=15;//按键Label大小
		private var _buttonColors:String="0,0,0,0"
		////

		protected var _submitButton:Button
		///////////////////////
		protected var _ip:String;
		
		/**
		 * 设置输入框ip 
		 * @return 
		 * 
		 */		
		public function get ip():String { return _ip; }		
		public function set ip(value:String):void
		{
			if (_ip == value)
				return;
			_ip = value;
			callLater(changeAll)
		}
		
		
		public function __LanIpLoginComponent_base()
		{
			super();			
		}
		override protected function preinitialize():void {
			mouseChildren = true;
		}
		
		
		/**在此创建组件子对象*/
		override protected function createChildren():void {
			super.createChildren()
			//	trace("创建组件")
			addChild(_bkimg=new Image())
			addChild(_ipInput=new TextInput());//添加输入框
			addChild(_submitButton=new Button());//添加提交按钮 
			//添加数字按钮 
			var btn:Button
			for (var i:int=1;i<13;i++){
				btn=new Button(_skin)
					
				if(i<10){
					btn.label=i.toFixed()
				}else if(i==10){
					btn.label="0"
				}else if(i==11){
					btn.label="."
				}else if(i==12){
					btn.label="←"
				}				
				_btns.push(btn)
				addChild(btn)
			}
		}
		protected var _maxChars:int=15
		override protected function initialize():void
		{
			// TODO Auto Generated method stub
			super.initialize();
			_bkimg.width=width
			_bkimg.height=height
			//////
			_ipInput.restrict="0-9,."
			_ipInput.align="center"
			_ipInput.editable=false//设置为不可编辑
			_ipInput.maxChars=_maxChars//最长位数15
			_ipInput.selectable=false//设置为不可选
			
			_submitButton.label="提交";
			
			exeCallLater(changeAll)
		}
		
		
		
		private var _submitLabelSize:Number;//提交按钮字体粗细
		/**
		 * 提交按钮的字体粗细 
		 * @return 
		 * 
		 */		 
		public function get submitLabelSize():Number { return _submitLabelSize; }		
		public function set submitLabelSize(value:Number):void
		{
			if (_submitLabelSize == value)
				return;
			_submitLabelSize = value;
			exeCallLater(changeAll)
		}
		
		
		private var _submitLabelColors:String="0,0,0,0"
		/**
		 * 提交按钮的颜色 
		 * @return 
		 * 
		 */			
		public function get submitLabelColors():String { return _submitLabelColors; }	
		public function set submitLabelColors(value:String):void
		{
			if (_submitLabelColors == value)
				return;
			_submitLabelColors = value;
			exeCallLater(changeAll)
		}
		
		
		/**
		 *  数字按钮字体颜色 
		 * @return 
		 * 
		 */
		public function get buttonColors():String { return _buttonColors; }		
		public function set buttonColors(value:String):void
		{
			if (_buttonColors == value)
				return;
			_buttonColors = value;
			exeCallLater(changeAll)
		}
		
		/**
		 * 按钮字体粗细 
		 * @return 
		 * 
		 */		
		public function get buttonLabelSize():Number { return _buttonLabelSize; }	
		public function set buttonLabelSize(value:Number):void
		{
			if (_buttonLabelSize == value)
				return;
			_buttonLabelSize = value;
			exeCallLater(changeAll)
		}
		
		/**
		 * 按钮间隔 
		 * @return 
		 * 
		 */		 
		public function get buttonSpace():Number { return _buttonSpace; }		
		public function set buttonSpace(value:Number):void
		{
			if (_buttonSpace == value)
				return;
			_buttonSpace = value;
			exeCallLater(changeAll)
		}
		
		
		/**
		 *  设置输入框高 
		 * @return 
		 * 
		 */		
		public function get ipInputHeight():Number { return _ipInputHeight; }		
		public function set ipInputHeight(value:Number):void
		{
			if (_ipInputHeight == value)
				return;
			_ipInputHeight = value;
			exeCallLater(changeAll)
		}
		
		/**
		 * 设置ip输入框粗细 
		 * @return 
		 * 
		 */		
		public function get ipInputSize():Number { return _ipInputSize; }		
		public function set ipInputSize(value:Number):void
		{
			if (_ipInputSize == value)
				return;
			_ipInputSize = value;
			exeCallLater(changeAll)
		}
		
		/**
		 * 设置IP 输入框颜色 
		 * @return 
		 * 
		 */
		public function get ipInputColor():uint { return _ipInputColor; }		
		public function set ipInputColor(value:uint):void
		{
			if (_ipInputColor == value)
				return;
			_ipInputColor = value;
			exeCallLater(changeAll)
		}
		
		
		/**边距(格式:左边距,上边距,右边距,下边距)*/
		public function get margin():String {
			return _margin.join(",");
		}		
		public function set margin(value:String):void {
			_margin = StringUtils.fillArray(_margin, value, int);
			exeCallLater(changeAll)
		}
		
		/**
		 * 设置皮肤 
		 * @return 
		 * 
		 */		
		public function get skin():String { return _skin; }
		public function set skin(value:String):void
		{
			if (_skin == value)
				return;
			_skin = value;
			_bkimg.skin=_skin
			exeCallLater(changeAll)
		}
		
		
		
		override public function set height(value:Number):void
		{
			// TODO Auto Generated method stub
			if(value>=200){
				super.height = value;
				_bkimg.height=height
				exeCallLater(changeAll)
			}
			
		}
		
		override public function set width(value:Number):void
		{
			// TODO Auto Generated method stub
			if(value>=300){
				super.width = value;
				_bkimg.width=width
				exeCallLater(changeAll)
			}
			
		}
		
		
		
		
		
		
		
	
		private function changeAll():void{
			changeTextInput()
			changeNumButtons()
			changeSubmitButtons()
		}
		private function changeSubmitButtons():void{
			if(_skin){
				_submitButton.width=btnw
				_submitButton.height=_ipInputHeight
				_submitButton.top=_margin[1]
				_submitButton.right=_margin[2]
				_submitButton.skin=_skin+"$submit"	
				_submitButton.labelColors=_submitLabelColors
				_submitButton.labelSize=_submitLabelSize
			}
		
		}
		
		private function changeNumButtons():void{
			if(_skin){
				var lr:Number=_margin[0]+_margin[2]//左右，
				var tb:Number=_margin[1]+_margin[3]//上下
				btnw=(this.width-lr-_buttonSpace*3)/4
				btnh=(this.height-tb-_ipInputHeight-5-_buttonSpace*2)/3
				var btn:Button
				var a:int=0;//横
				var b:int=0;//竖
				for(var i:int=0;i<_btns.length;i++){
					if(i/4==1||i/4==2){
						a=0
						b+=1
					}
					btn=_btns[i]
					btn.width=btnw
					btn.height=btnh
					btn.skin=_skin+"$num"
					btn.x=_margin[0]+(btnw+_buttonSpace)*a
					btn.y=_ipInput.y+_ipInput.height+5+(btnh+_buttonSpace)*b
					btn.labelSize=_buttonLabelSize
					btn.labelColors=_buttonColors
					a+=1
				}
			}
			
		}
		
		private function changeTextInput():void{
			if(_skin){
				_ipInput.left=_margin[0]
				_ipInput.right=_margin[2]
				_ipInput.top=_margin[1]
				_ipInput.height=_ipInputHeight
				_ipInput.size=_ipInputSize
				_ipInput.color=_ipInputColor
				_ipInput.skin=_skin+"$ipinput";
				_ipInput.text=_ip
			}
			
		}
	}
}