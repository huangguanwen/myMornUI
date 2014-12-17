package morn.core.components
{
	import spin.Spinner;
	
	
	/**
	 *@author 偷心枫贼
	 *        下午1:11:45
	 *
	 */
	public class Loading extends Component
	{
		private var _autoPlay:Boolean=false
		private var _value:Number=0
		//////////////
		private var _spinner:Spinner
	  //  private var _label:Label
		/**
		 * spin 
		 * @return 
		 * 
		 */		
		final public function get spinner():Spinner{return _spinner}
		public function Loading()
		{
			super();
		}
		
		override protected function createChildren():void {
			addChild(_spinner = new  Spinner());
		/*	addChild(_label=new Label())
		    _label.align="center"
			_label.text=_value.toFixed()+"%"
			_label.x=-_label.width*.5
			labelSize=15*/
		}

		/**
		 * 字体大小 
		 * @return 
		 * 
		 */		
		/*final public function get labelSize():Number { return _label.size as Number }		
		final public function set labelSize(value:Number):void
		{
			_label.size=value
			
			
			_label.width =radius
			_label.height = ObjectUtils.getTextField(_label.format).height;
			_label.x =-_label.width*.5
			_label.y = (radius - _label.height) * 0.5
			
		}*/
		
		/**
		 * 字体颜色  
		 * @return 
		 * 
		 */
	/*	final public function get labelColor():uint { return _label.color as uint}
		final public function set labelColor(value:uint):void
		{
			_label.color=value
		}*/
		
		/**
		 *  是否显示label 
		 * @return 
		 * 
		 */		
		/*final public function get showLabel():Boolean { return _label.visible}
		final public function set showLabel(value:Boolean):void
		{
			_label.visible=value			
		}*/
		
		
		/**
		 * 0-100 
		 * @return 
		 * 
		 */		
		/*final public function get value():Number { return _value; }		
		final public function set value(value:Number):void
		{
			if (_value == value)
				return;
			_value = value;
			_label.text=_value.toFixed()+"%"
		}
		*/
		/**
		 * 是否自动播放 
		 * @return 
		 * 
		 */		
		final public function get autoPlay():Boolean { return _autoPlay; }		
		final public function set autoPlay(value:Boolean):void
		{
			if (_autoPlay == value)
				return;
			_autoPlay = value;
			if(_autoPlay)_spinner.spin()
			else _spinner.pause()
		}
		
		/**
		 * 行数 
		 * @return 
		 * 
		 */		
		final public function get lineCount():uint { return 	_spinner.lineCount }	
		final public function set lineCount(value:uint):void
		{
			_spinner.lineCount=value
			
		}
		
		/**
		 * 每一行的长度 
		 * @return 
		 * 
		 */		
		final public function get length():Number { return _spinner.length }		
		final public function set length(value:Number):void
		{
			_spinner.length=value
			
		}
		
		/**
		 * 每行粗细 
		 * @return 
		 * 
		 */		
		final public function get thickness():Number { return _spinner.thickness }	
		final public function set thickness(value:Number):void
		{
			_spinner.thickness=value
		}
		
		
		/**
		 * 内圈的半径
		 * @return 
		 * 
		 */		
		final public function get radius():Number { return _spinner.radius}	
		final public function set radius(value:Number):void
		{
			_spinner.radius=value
	
			callLater(resetPosition);
		}
		
		
		
		
		
		
		/**
		 * 圆度  0-1 
		 * @return 
		 * 
		 */		
		final public function get roundness():Number { return _spinner.roundness }		
		final public function set roundness(value:Number):void
		{
			if(value<0)_spinner.roundness=0
			else if(value>1)_spinner.roundness=1
			else _spinner.roundness=value			
		}
		
	
		/**
		 * 圆的颜色  
		 * @return 
		 * 
		 */		
		final public function get color():uint { return _spinner.color }		
		final public function set color(value:uint):void
		{
			_spinner.color=value;
		}
		/**
		 * 圆转的速度 
		 * @return 
		 * 
		 */
		final public function get speed():Number { return _spinner.speed}		
		final public function set speed(value:Number):void
		{
			_spinner.speed=value
		}
		
	
		/**
		 * 余辉程度
		 * @return 
		 * 
		 */		
		final public function get trail():Number { return _spinner.trail }		
		final public function set trail(value:Number):void
		{
			if(value<0)_spinner.trail=0
			else if(value>1)_spinner.trail=1
			else _spinner.trail=value
		}
		
		
		/**
		 * 不透明的线
		 * @return 
		 * 
		 */		
		final public function get opacity():Number { return _spinner.opacity }	
		final public function set opacity(value:Number):void
		{
			if(value<0)_spinner.opacity=0
			else if(value>1)_spinner.opacity=1
			else _spinner.opacity=value
		}
		
		
		/**
		 * 是否显示影子
		 * @return 
		 * 
		 */		
		final public function get shadow():Boolean { return _spinner.shadow }		
		final public function set shadow(value:Boolean):void
		{
			_spinner.shadow=value
		}
		
		
		
		
		
		/**重置位置*/
	override	protected function resetPosition():void {
			if (parent) {
				if (!isNaN(_centerX)) {
					x = parent.width*.5+ _centerX;
				}/* else if (!isNaN(_left)) {
					x = _left;
					if (!isNaN(_right)) {
						width = (parent.width - _left - _right) / scaleX;
					}
				} else if (!isNaN(_right)) {
					x = parent.width - displayWidth - _right;
				}*/
				if (!isNaN(_centerY)) {
					y = parent.height* .5 + _centerY;
				} /*else if (!isNaN(_top)) {
					y = _top;
					if (!isNaN(_bottom)) {
						height = (parent.height - _top - _bottom) / scaleY;
					}
				} else if (!isNaN(_bottom)) {
					y = parent.height - displayHeight - _bottom;
				}*/
			}
		}
		
		
		
	}
}