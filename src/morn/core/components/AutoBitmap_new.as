/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import morn.core.utils.BitmapUtils;
	
	/**增强的Bitmap，组件的显示对象*/
	public final class AutoBitmap_new extends Bitmap {
		private var _bitmapData:BitmapData;
		private var _skin:String;
		private var _width:Number;
		private var _height:Number;
		private var _sizeGrid:Array;
		private var _clipX:int = 1;
		private var _clipY:int = 1;
		private var _source:Vector.<BitmapData>;
		private var _clips:Vector.<BitmapData>;
		private var _index:int = 0;
		private var _smoothing:Boolean;
		private var _anchorX:Number;
		private var _anchorY:Number;
		private var _cacheBitmapData:Boolean = true;
		
		public function AutoBitmap_new() {
		}
		
		/**宽度(显示时四舍五入)*/
		override public function get width():Number {
			App.render.exeCallLater(changeSize);
			return isNaN(_width) ? (super.bitmapData ? super.bitmapData.width : super.width) : _width;
		}
		
		override public function set width(value:Number):void {
			_width = value;
			App.render.callLater(changeSize);
		}
		
		/**高度(显示时四舍五入)*/
		override public function get height():Number {
			App.render.exeCallLater(changeSize);
			return isNaN(_height) ? (super.bitmapData ? super.bitmapData.height : super.height) : _height;
		}
		
		override public function set height(value:Number):void {
			_height = value;
			App.render.callLater(changeSize);
		}
		
		/**九宫格信息，格式：左边距,上边距,右边距,下边距,是否重复填充(值为0或1)，例如：4,4,4,4,1*/
		public function get sizeGrid():Array {
			return _sizeGrid;
		}
		
		public function set sizeGrid(value:Array):void {
			_sizeGrid = value;
			App.render.callLater(changeSize);
		}
		
		/**皮肤*/
		public function get skin():String {
			return _skin;
		}
		
		public function set skin(value:String):void {
			_skin = value;
			App.render.callLater(changeBitmap);
			App.render.callLater(changeSize);
		}
		
		/**切片X数量*/
		public function get clipX():int {
			return _clipX;
		}
		
		public function set clipX(value:int):void {
			_clipX = value;
			App.render.callLater(changeBitmap);
			App.render.callLater(changeSize);
		}
		
		/**切片Y数量*/
		public function get clipY():int {
			return _clipY;
		}
		
		public function set clipY(value:int):void {
			_clipY = value;
			App.render.callLater(changeBitmap);
			App.render.callLater(changeSize);
		}
		
		private function changeBitmap():void {
			_source = App.asset.getClips(_skin, _clipX, _clipY, true);
			trace("changeBitmapSource");
		}
		
		private function changeSize():void {
			App.render.exeCallLater(changeBitmap);	
			if (_source && _source.length > 0) {
				//清理临时位图数据
				disposeTempBitmapdata();
				//重新生成新位图(只在图片更改大小并且有9宫格设置时才创建新位图)
				var temp:Vector.<BitmapData> = new Vector.<BitmapData>();
				var w:int = !isNaN(_width) ? Math.round(_width) : _source[0].width;
				var h:int = !isNaN(_height) ? Math.round(_height) : _source[0].height;
				for (var i:int = 0, n:int = _source.length; i < n; i++) {
					var source:BitmapData = _source[i];
					if (_sizeGrid) {
						temp.push(BitmapUtils.scale9Bmd(source, _sizeGrid, w, h));
					} else {
						temp.push(source);
					}
				}
				_clips = temp;
				index = _index;
				super.width = w;
				super.height = h;
			}
			if (!isNaN(_anchorX)) {
				super.x = -Math.round(_anchorX * width);
			}
			if (!isNaN(_anchorY)) {
				super.y = -Math.round(_anchorY * height);
			}	
			trace("changeBitmapSize");
		}
		
		/**销毁临时位图*/
		private function disposeTempBitmapdata():void {
			if (_clips) {
				for (var i:int = _clips.length - 1; i > -1; i--) {
					if (_clips[i] != _source[i]) {
						_clips[i].dispose();
					}
				}
				_clips.length = 0;
			}
			_clips = null;
		}
		
		/**当前位图数据索引*/
		public function get index():int {
			return _index;
		}
		
		public function set index(value:int):void {
			_index = value;
			if (_clips && _clips.length > 0) {
				_index = (_index < _clips.length && _index > -1) ? _index : 0;
				super.bitmapData = _clips[_index];
				super.smoothing = _smoothing;
			}
		}
		
		override public function set bitmapData(value:BitmapData):void {
			super.bitmapData = value;
			if (!value) {
				disposeTempBitmapdata();
				_source = null;
				super.bitmapData = null;
			}
		}
		
		/**是否平滑显示*/
		override public function get smoothing():Boolean {
			return _smoothing;
		}
		
		override public function set smoothing(value:Boolean):void {
			super.smoothing = _smoothing = value;
		}
		
		/**X锚点，值为0-1*/
		public function get anchorX():Number {
			return _anchorX;
		}
		
		public function set anchorX(value:Number):void {
			_anchorX = value;
		}
		
		/**Y锚点，值为0-1*/
		public function get anchorY():Number {
			return _anchorY;
		}
		
		public function set anchorY(value:Number):void {
			_anchorY = value;
		}
		
		/**是否缓存bitmapData数据，如为false，则在removeFromStage后，位图数据会被自动销毁，addToStage时再被重新创建，默认为true，会缓存并共用位图数据
		 * 按钮等组件默认为true，从而节省cpu。对于Image，如不经常复用并且尺寸比较大，建议设置false，从而节省内存*/
		public function get cacheBitmapData():Boolean {
			return _cacheBitmapData;
		}
		
		public function set cacheBitmapData(value:Boolean):void {
			if (!_cacheBitmapData) {
				addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
				addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			} else {
				removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
				removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			}
		}
		
		private function onAddedToStage(e:Event):void {
			skin = _skin;
		}
		
		private function onRemovedFromStage(e:Event):void {
			dispose(true);
		}
		
		/**销毁*/
		public function dispose(removeFromCache:Boolean = false):void {
			if (bitmapData) {
				bitmapData = null;
			}
			if (removeFromCache && Boolean(_skin)) {
				App.asset.disposeBitmapData(_skin);
				App.asset.destroyClips(_skin);
			}
		}
	}
}