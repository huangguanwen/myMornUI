package morn.core.components.live
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import morn.core.components.Component;
	
	/**
	 * @author 偷心枫贼
	 * @E-mail: 527025965@qq.com
	 * 创建时间：2013-12-23 上午10:52:27
	 * 
	 */
	public class ColorComponent extends Component
	{
		public static const boxColors:Dictionary=new Dictionary(true);
		
		
		private var _color:uint=0
		public function get color():uint{return _color}
		public function ColorComponent(color:uint)
		{
			_color=color
			super();
			draw()
			this.addEventListener(MouseEvent.MOUSE_DOWN,onDown)
			this.addEventListener(Event.ADDED,onAddToStage)
		   // App.stage.addEventListener(MouseEvent.MOUSE_UP,onUp)
			//trace(this.parent,this.parent is IColorBox)
		}
		private function onAddToStage(e:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,onAddToStage)
				if(this.parent is IColorBox){
					IColorBox(this.parent).colors[this]=this
				}
		//		trace(e.target.parent,e.currentTarget.parent,e.target.parent is IColorBox)
		//	boxColors[this.parent][this]=this
		}
		private function onDown(e:MouseEvent):void{
			for each(var box:ColorComponent in IColorBox(this.parent).colors){
				box.alpha=1
			}
			IColorBox(this.parent).colors[this].alpha=.5
		}
		private function onUp(e:MouseEvent):void{
			alpha=1
		}
		private function draw():void{
			graphics.clear()
			graphics.beginFill(_color,1)
			graphics.drawRect(0,0,width,height)
			graphics.endFill()
		}
		override public function set height(value:Number):void
		{
			// TODO Auto Generated method stub
			super.height = value;
			draw()
		}
		
		override public function set width(value:Number):void
		{
			// TODO Auto Generated method stub
			super.width = value;
			draw()
		}
		
		
	}
}