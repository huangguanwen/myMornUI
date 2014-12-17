package morn.core.components.live
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.media.Camera;
	import flash.media.Video;
	
	/** 
	 * @Content 
	 * @Author HuangGuanWen
	 * @E-mail: 527025965@qq.com
	 * @Version 1.0.0 
	 * @Date：2013-10-22 下午5:37:10 
	 */
	public class CameraMan implements IEventDispatcher
	{
		public static var isInstance:Boolean=false;
		private static var instance:CameraMan
		
		public var uiArray:Array=[];
		/**
		 *单例模式
		 *
		 **/
		public static function getInstance():CameraMan{
			isInstance=true;
			if(!instance) instance=new CameraMan();
			return instance;
		}
		
		public function get bitmapdate():BitmapData{return _bitmapdate}
		
		
		private var _cam:flash.media.Camera
		private var _video:Video
		private var _bitmapdate:BitmapData
		private var _eventDispatcher:EventDispatcher
		private var _isRun:Boolean=false;
		
		public function CameraMan()
		{
			if(!isInstance){return};//此类必须单例;
			
			_eventDispatcher=new EventDispatcher();
			
			_cam=flash.media.Camera.getCamera();
			if(_cam!=null){
				_cam.setMode(640,480,App.stage.frameRate)
			//	_cam.addEventListener(Event.VIDEO_FRAME,videoFrameHandler)
				_video=new Video(640,480);
				_video.attachCamera(_cam);
				_video.smoothing=true
				App.stage.addEventListener(Event.ENTER_FRAME,enterFrameHandler)
				_bitmapdate=new BitmapData(640,480)
				_isRun=true
			}
		
		}
		/*private function videoFrameHandler(e:Event):void{
			_cam.drawToBitmapData(_bitmapdate)
			_eventDispatcher.dispatchEvent(e);
		}*/
		private function enterFrameHandler(e:Event):void{
			
			var bitm:BitmapData=new BitmapData(_video.width,_video.height)
		/*	
			var matrix:Matrix=new Matrix()
			matrix.scale(-1,1)
			matrix.tx=_video.width;*/
			bitm.draw(_video)
				
			_bitmapdate=bitm;
			_eventDispatcher.dispatchEvent(e);
		}
		
		
		public function checkUINum():void{
			if(uiArray.length==0){
				if(_isRun){
					App.stage.removeEventListener(Event.ENTER_FRAME,enterFrameHandler)
					_cam=null
					_isRun=false
				
				}
			}else{
				if(!_isRun){
					_isRun=true
					_cam=flash.media.Camera.getCamera();
					_cam.setMode(640,480,App.stage.frameRate)
					_video.attachCamera(_cam);
					App.stage.addEventListener(Event.ENTER_FRAME,enterFrameHandler)
				}
			}
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
		    _eventDispatcher.addEventListener(type,listener,useCapture,priority,useWeakReference);	
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			_eventDispatcher.removeEventListener(type,listener,useCapture);	
		}
		
		public function dispatchEvent(e:Event):Boolean
		{
			return _eventDispatcher.dispatchEvent(e);
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return _eventDispatcher.hasEventListener(type);
		}
		
		public function willTrigger(type:String):Boolean
		{
			return _eventDispatcher.willTrigger(type);
		}
	}
}