package morn.core.components.live
{
	import flash.display.BitmapData;
	
	import morn.core.components.AutoBitmap;
	import morn.core.components.Component;
	
	public class AnimationComponents extends Component
	{
		protected var _bitmap:AutoBitmap;
		private var _clipMultipX:int=8
		private var _clipMultipY:int=8
		private var _n:int=0	
		private var _speed:int=1
		private var _skin:String
		
		
		
		override public function set height(value:Number):void
		{
			// TODO Auto Generated method stub
			super.height = value;
			_bitmap.height=value
		}
		
		override public function set width(value:Number):void
		{
			// TODO Auto Generated method stub
			super.width = value;
			_bitmap.width=value
		}
		
		
		
		public function AnimationComponents()
		{
			super();
			_bitmap.smoothing=true
		}
		override protected function createChildren():void {
			addChild(_bitmap = new AutoBitmap());
		}
		
		
		/**皮肤*/
		public function get skin():String {
			return _skin;
		}
		
		public function set skin(value:String):void {
			if (_skin != value) {
				_skin = value;
				//更新切片
				updateClips()
			}
		}
		
		
		/**
		 * 切片乘方X 
		 * @return 
		 * 
		 */	
		public function get clipMultipX():int { return _clipMultipX; }
		public function set clipMultipX(value:int):void
		{
			if (_clipMultipX == value)
				return;
			_clipMultipX = value;
			updateClips()
		}
		/**
		 * 切片乘方Y 
		 * @return 
		 * 
		 */		
		public function get clipMultipY():int { return _clipMultipY; }		
		public function set clipMultipY(value:int):void
		{
			if (_clipMultipY == value)
				return;		
			_clipMultipY = value;
			updateClips()
		}
		
		
		
		
		
		private function updateClips():void{
			if(_skin!=""){
				
				_bitmap.clips = App.asset.getClips(_skin, _clipMultipX, _clipMultipY);
 
				_bitmap.index=Math.random()*_bitmap.clips.length
			}
		}
		
		
		
		
		
		
		
		
		/**
		 * 更新帧频 
		 * 
		 */		
		public function update():void{
			_n++
			if(_n==_speed){
				_bitmap.index=_bitmap.index<_bitmap.clips.length-1?_bitmap.index+1:0
				_n=0
			}
			
		}
		
		/**
		 * 动画帧频 
		 * @return 
		 * 
		 */		
		public function get speed():int { return _speed; }		
		public function set speed(value:int):void
		{
			if (_speed == value)
				return;
		    if(value==0){
				_speed=1
				return
			}
			_speed = value;
		}
		
	}
}