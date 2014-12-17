package morn.core.components
{
	import com.greensock.TweenLite;
	
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;

	public class VideoDisplay extends Component
	{
		
		private var _url:String=""
		public function get url():String { return _url; }
		
		public function set url(value:String):void
		{
			if (_url == value)
				return;
			_url = value;
		}
		
		
	
		public function get skin():String {
			return _url;
		}
		
		public function set skin(value:String):void {
			url = value;
		}
		
		
		/**
		 * 是否自动重播 
		 * 
		 */			
		public var autoPlay:Boolean=false;
		
		
		public function get isPlaying():Boolean{return _isPlaying}
		
		
		private var connection:NetConnection;
		private var stream:NetStream;
		private var video:Video = new Video(); 
		private var _duration:Number
		private var _isPlaying:Boolean=false;
		
		public function VideoDisplay()
		{
			super();
			
			listeners()
				
     
		}
		
	
		override protected function createChildren():void
		{
			// TODO Auto Generated method stub
			super.createChildren();
			connection = new NetConnection();
			//cacheAsBitmap=true
			video.smoothing=true
            video.cacheAsBitmap=true
            
			addChild(video);
		}
		
		override protected function preinitialize():void
		{
			// TODO Auto Generated method stub
			super.preinitialize();
			width=200
			height=150;
		}
		
		
		
		
		
		
		
		/**
		 *暂停或恢复流的播放。第一次调用此方法时，将暂停播放；下一次调用此方法时，将恢复播放。您可以使用此方法，允许用户通过按某个按钮来暂停或恢复播放。 
		 * 
		 */		
		public function togglePause():void{
			if(stream){
			stream.togglePause();
			_isPlaying=!_isPlaying
			}
		}
		
		/**
		 *暂停视频流的播放。如果视频已经暂停，则调用此方法将不会执行任何操作。要在暂时视频后恢复播放，请调用 resume()。要在暂停和播放之间切换（先暂停视频，然后恢复），请调用 togglePause()。  
		 * 
		 */		
		public function pause():void{
			if(stream){
				stream.pause();
				_isPlaying=false;	
			}
		
		}
		
		/**
		 *恢复播放暂停的视频流。如果视频已在播放，则调用此方法将不会执行任何操作。 
		 * 
		 */		
		public function resume():void{
			if(stream){
		
			stream.resume();
			_isPlaying=true;
			
			}
		}
		override public function set width(value:Number):void
		{
			
			
			video.width=value;
			drawBlack()
			
			
			// TODO Auto Generated method stub
			super.width= value;
			
		}
		
		override public function set height(value:Number):void
		{
			
			
			video.height=value;
			drawBlack()
			
		
			// TODO Auto Generated method stub
			super.height = value;
			
		}
		
		
		
		/**
		 * 开始播放 
		 * @param $url
		 * 
		 */		
		public function play($url:String=""):void{
			if($url!="")url=$url;
			_isPlaying=true;
			video.alpha=0;
			connection.connect(null);	
		
			TweenLite.to(video,1,{alpha:1,delay:1});
				
		}
		
		
		
		
		private function drawBlack():void{
			graphics.clear()
			graphics.beginFill(0,1)
			graphics.drawRect(0,0,video.width,video.height);
			graphics.endFill()
		}
		
		private  function connectStream():void {			
			stream = new NetStream(connection);			
			stream.play(url);
			stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			stream.client = new CustomClient();			
			video.attachNetStream(stream);
					
			var obj:Object=new Object(); 
			obj.onMetaData = onMetaData; 
			stream.client = obj; 			
		}
		
		private function listeners():void{
			connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			
		}
		
		
		private function netStatusHandler(event:NetStatusEvent):void {
			//trace("状态: "+event.info.code)
			switch (event.info.code) {
				case "NetStream.Play.Start":
				case "NetStream.Unpause.Notify":
				//	clip_playBtn.frame=2;
					//TweenLite.to(this,.5,{alpha:1})
					break;
				case "NetStream.Pause.Notify":
				//	clip_playBtn.frame=1;
					//TweenLite.to(this,.5,{alpha:0})
					break;
				
				case "NetConnection.Connect.Success":
					connectStream();
					break;
				case "NetStream.Play.StreamNotFound":
					//	trace("Stream not found: " + videoURL);
				case "NetStream.Play.Stop":
					_isPlaying=false;
					if(autoPlay){
						stream.play(url);
						_isPlaying=true
					}else{
						//TweenLite.to(video,1,{alpha:0});
					}
					dispatchEvent(new Event(Event.COMPLETE));
					break;
			}
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("securityErrorHandler: " + event);
		}
		
		private function onMetaData(infoObject:Object):void 
		{ 
			_duration=infoObject.duration;//获取总时间 
		} 
	}
}




class CustomClient {
	public function onMetaData(info:Object):void {
		trace("metadata: duration=" + info.duration + " width=" + info.width + " height=" + info.height + " framerate=" + info.framerate);
	}
	public function onCuePoint(info:Object):void {
		trace("cuepoint: time=" + info.time + " name=" + info.name + " type=" + info.type);
	}
}