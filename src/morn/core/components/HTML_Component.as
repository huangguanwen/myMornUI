package morn.core.components
{
	import flash.events.Event;
	import flash.events.LocationChangeEvent;
	import flash.html.HTMLHistoryItem;
	import flash.html.HTMLLoader;
	import flash.net.URLRequest;
	
	import morn.core.events.UIEvent;
	import morn.core.utils.StringUtils;
	
	
	/**
	 * html 浏览器
	 *@author 偷心枫贼
	 *        上午8:57:46
	 *
	 */
	public class HTML_Component extends Component
	{
		private var _html:HTMLLoader
		private var _url:String//网址
		
		private var _skinImage:Image//皮肤图层
		
		
		protected var _vScrollBar:VScrollBar;
		protected var _hScrollBar:HScrollBar;
		
		
		protected var _margin:Array = Styles.labelMargin;//间距
		
		private var _htmlContent:String;
		//////////////////////////////
		
		
	
		
		/**
		 * 加载HTML内容 
		 * @return 
		 * 
		 */		
		public function get htmlContent():String { return _htmlContent; }
		public function set htmlContent(value:String):void
		{
			if (_htmlContent == value)
				return;
			_htmlContent = value;
			_html.loadString(_htmlContent);
		}
		
		/**
		 * 指定此对象发出的 HTTP 请求的空闲超时值（以毫秒为单位）。
		 
		 * 空闲超时值是指客户端在建立连接之后、放弃请求之前等待服务器响应的时间。
		 
		 * 默认值为 initialized from URLRequestDefaults.idleTimeout。 
		 * 
		 * @return 
		 * 
		 */		
		public function get idleTimeout():Number{return _html.idleTimeout}
		public function set idleTimeout(value:Number):void{
			if(_html.idleTimeout==value)return
			_html.idleTimeout=value
		}
		
		/**
		 * 指定是否应为此对象发出的 HTTP 请求缓存成功的响应数据。设置为 true 时，HTMLLoader 对象将使用操作系统的 HTTP 缓存。
		 * 默认值为 initialized from URLRequestDefaults.cacheResponse。 
		 * @return 
		 * 
		 */		
		public function get cacheResponse():Boolean{return _html.cacheResponse}
		public function set cacheResponse(value:Boolean):void{
			if(_html.cacheResponse==value)return 
			_html.cacheResponse=value
		}
		/**
		 * 来自此 HTMLLoader 对象的任何后续内容请求中使用的用户代理字符串。
		 
		 * 要设置用户代理字符串，请在调用 load() 方法之前设置 HTMLLoader 对象的 userAgent 属性。不 使用传递到 load() 方法的 URLRequest 对象的 userAgent 属性。
		 
		 * 通过设置 URLRequestDefaults.userAgent 属性，可以设置应用程序域中所有 HTMLLoader 对象使用的默认用户代理字符串。如果未为 HTMLLoader 对象的 userAgent 属性设置值（或者将该值设置为 null），则会将用户代理字符串设置为静态 URLRequestDefaults.userAgent 属性的值。
		 
		 * 如果既未为 HTMLLoader 的 userAgent 属性设置值，也未为 URLRequestDefaults.userAgent 设置值，则会使用默认值作为用户代理字符串。此默认值随着运行时操作系统（如 Mac OS、Linux 或 Windows）、运行时语言和运行时版本而变化，如下面的示例所示：
		 
		 * "Mozilla/5.0 (Macintosh; U; PPC Mac OS X; en) AppleWebKit/526.9+ (KHTML, like Gecko) AdobeAIR/1.5"
		 * "Mozilla/5.0 (Windows; U; en) AppleWebKit/526.9+ (KHTML, like Gecko) AdobeAIR/1.5"
		 * "Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/526.9+ (KHTML, like Gecko) AdobeAIR/1.5" 
		 * @return 
		 * 
		 */		
		public function get userAgent():String{return _html.userAgent}
		public function set userAgent(value:String):void{
			if(_html.userAgent==value)return;
			_html.userAgent=value
		}
		
		
		
		override public function set height(value:Number):void
		{
			// TODO Auto Generated method stub
			super.height = value;
			exeCallLater(changeHtml)
			exeCallLater(changeSkinImage)
		}
		
		override public function set width(value:Number):void
		{
			// TODO Auto Generated method stub
			super.width = value;
			exeCallLater(changeHtml)
			exeCallLater(changeSkinImage)
		}
		
		
		/**
		 *  指定在此对象发出的 HTTP 请求获取数据之前是否应查询本地缓存。
		 *  默认值为 initialized from URLRequestDefaults.useCache。 
		 * @return 
		 * 
		 */		
		public function get useCache():Boolean{return _html.useCache}
		public function set useCache(value:Boolean):void{
			if(_html.useCache==value)return
			_html.useCache=value
		}
		
		
		/**
		 *  HTMLLoader 内容使用的字符编码，它将覆盖 HTML 页中的任何设置。HTML 页在 meta 标记中指定字符编码，如下所示：
		 *
		 *  <meta http-equiv="content-type" content="text/html" charset="ISO-8859-1"> 
		 * @return 
		 * 
		 */		
		public function get textEncodingOverride():String{return _html.textEncodingOverride}
		public function set textEncodingOverride(value:String):void{
			if(_html.textEncodingOverride==value)return 
			_html.textEncodingOverride=value
		}
		
		
		/**
		 *在 HTML 页未指定字符编码时 HTMLLoader 内容使用的字符编码。HTML 页在 meta 标记中指定字符编码，如下所示：
		 *
		 *<meta http-equiv="content-type" content="text/html" charset="ISO-8859-1"> 
		 * @return 
		 * 
		 */		
		public function get textEncodingFallback():String{return _html.textEncodingFallback}
		public function set textEncodingFallback(value:String):void{
			if(_html.textEncodingFallback==value)return
			_html.textEncodingFallback=value
		}
		
		
		/**垂直滚动条皮肤*/
		public function get vScrollBarSkin():String {
			return _vScrollBar.skin;
		}
		
		public function set vScrollBarSkin(value:String):void {
			if (_vScrollBar == null) {
				addChild(_vScrollBar = new VScrollBar());
				_vScrollBar.addEventListener(Event.CHANGE, onScrollBarChange);
				_vScrollBar.target = _html
				callLater(changeScroll);
			}
			_vScrollBar.skin = value;
		}
		
		
		/**水平滚动条皮肤*/
		public function get hScrollBarSkin():String {
			return _hScrollBar.skin;
		}
		
		public function set hScrollBarSkin(value:String):void {
			if (_hScrollBar == null) {
				addChild(_hScrollBar = new HScrollBar());
				_hScrollBar.addEventListener(Event.CHANGE, onScrollBarChange);
				_hScrollBar.mouseWheelEnable = false;
				_hScrollBar.target = _html
				callLater(changeScroll);
			}
			_hScrollBar.skin = value;
		}
		
		
		
		/**
		 * 网页链接 
		 * @return 
		 * 
		 */		
		public function get location():String { return _url; }	
		public function set location(value:String):void
		{
			if (_url == value)
				return;
			_url = value;
			_html.load(new URLRequest(_url))
		}
		
		
		/**
		 * 指定 HTMLLoader 文档背景是否为不透明白色，如果是，则为 true，否则为 false。 
		 * @return 
		 * 
		 */
		public function get paintsDefaultBackground():Boolean { return _html.paintsDefaultBackground; }		
		public function set paintsDefaultBackground(value:Boolean):void
		{
			if (_html.paintsDefaultBackground == value)
				return;
			_html.paintsDefaultBackground=value;
		}
		
		
		
		/**
		 * 设置水平滚动位置 
		 * @return 
		 * 
		 */		
		public function get scrollH():Number { return _html.scrollH; }		
		public function set scrollH(value:Number):void
		{
			if (_html.scrollH == value)
				return;
			_html.scrollH=value
		}
		
		/**
		 * 设置垂直滚动位置 
		 * @return 
		 * 
		 */		
		public function get scrollV():Number { return _html.scrollV; }
		public function set scrollV(value:Number):void
		{
			if (_html.scrollV == value)
				return;
			_html.scrollV = value;
		}
		
		
		
		
		
		
		
		/**皮肤九宫格信息，格式：左边距,上边距,右边距,下边距,是否重复填充(值为0或1)，例如：4,4,4,4,1*/
		public function get sizeGrid():String {
			return _skinImage.bitmap.sizeGrid.join(",");
		}
		
		public function set sizeGrid(value:String):void {
			_skinImage.bitmap.sizeGrid = StringUtils.fillArray(Styles.defaultSizeGrid, value, int);
		}
		
		
		/**边距(格式:左边距,上边距,右边距,下边距)*/
		public function get margin():String {
			return _margin.join(",");
		}
		
		public function set margin(value:String):void {
			_margin = StringUtils.fillArray(_margin, value, int);
			_html.x=_margin[0];
			_html.y=_margin[1];
			callLater(changeSize);
		}
		/**
		 * 皮肤 
		 * @return 
		 * 
		 */	
		public function get skin():String { return _skinImage.url; }		
		public function set skin(value:String):void
		{
			if (_skinImage.url == value)
				return;
			_skinImage.url=value
		}
		
		/////////////////////////
		public function HTML_Component()
		{
			super();
						
			listeners()
			
		}
		/**预初始化，在此可以修改属性默认值*/
		override protected function preinitialize():void {
			super.preinitialize()
			_width=400
			_height=400
			changeDrawBackground()
		}
		
		override protected function createChildren():void
		{
			// TODO Auto Generated method stub
			super.createChildren();
			
			addChild(_skinImage=new Image())
			addChild(_html=new HTMLLoader())
			_skinImage.width=width
			_skinImage.height=height
			_html.width=width
			_html.height=height
		}
		
		override protected function initialize():void
		{
			// TODO Auto Generated method stub
			super.initialize();
			
		//	exeCallLater(changeHtml)
		//	exeCallLater(changeSkinImage)
			
		}
		
		
		//////////////////////////////////////////////
		private function listeners():void{
			_html.addEventListener(Event.COMPLETE,onComplete)
			_html.addEventListener(Event.HTML_BOUNDS_CHANGE,onHtmlBoundsChange)
			_html.addEventListener(Event.RENDER,onRender)
			_html.addEventListener(LocationChangeEvent.LOCATION_CHANGING,onLoacationChanging)
			_html.addEventListener(Event.LOCATION_CHANGE,onLocationChange)
		}
		
		/**
		 * 更改了loacation  属性 
		 * @param e
		 * 
		 */		
		private function onLocationChange(e:Event):void{
			dispatchEvent(e)
		}
		/**
		 * 正在更改loacation属性 
		 * @param e
		 * 
		 */		
		private function onLoacationChanging(e:LocationChangeEvent):void{
			dispatchEvent(e)
		}
		/**
		 * 正在渲染新的内容 
		 * @param e
		 * 
		 */		
		private function onRender(e:Event):void{
			changeScroll()
			dispatchEvent(e)	
		}
		/**
		 * 更改了网页内容大小 
		 * @param e
		 * 
		 */		
		private function onHtmlBoundsChange(e:Event):void{
			changeScroll()
			dispatchEvent(e)			
		}
		/**
		 *  网页加载完成 
		 * @param e
		 * 
		 */		
		private function onComplete(e:Event):void{
			dispatchEvent(e)
		}
		
		
		
		/////////////////////////////////
		
		/**
		 * 
		 * 
		 * 取消正在进行的任何加载操作。
		 */		
		public function cancellLoad():void{
			_html.cancelLoad()
		}
		
		/**
		 * 返回指定位置的历史记录条目。
		 * @param position
		 * @return 
		 * 
		 */		
		public function  getHistoryAt(position:uint):HTMLHistoryItem{
			return _html.getHistoryAt(position);
		}
		
		/**
		 *	如果可能，在浏览器历史记录中向后浏览。 
		 * 
		 */		
		public function  historyBack():void{
			_html. historyBack();
		}
		
		
		/**
		 *如果可能，在浏览器历史记录中向前浏览。 
		 * 
		 */		
		public function  historyForward():void{
			_html. historyForward()
		}
		/**
		 * 在浏览器历史记录中浏览指定的步骤数。 
		 * @param steps
		 * 
		 */		
		public function  historyGo(steps:int):void{
			_html.historyGo(steps);
		}
		
		/**
		 *  重新加载 
		 * 
		 */		
		public function reload():void{
			_html.reload()
		}
		
		
		
		
		
		
		
		
		
		
		protected function onScrollBarChange(e:Event):void {
			if (e.currentTarget == _vScrollBar) {
				if (_html.scrollV != _vScrollBar.value) {
					_html.removeEventListener(Event.SCROLL, onHtmlScroll);
					_html.scrollV = _vScrollBar.value;
					_html.addEventListener(Event.SCROLL, onHtmlScroll);
					sendEvent(UIEvent.SCROLL);
				}
			} else {
				if (_html.scrollH != _hScrollBar.value) {
					_html.removeEventListener(Event.SCROLL, onHtmlScroll);
					_html.scrollH = _hScrollBar.value;
					_html.addEventListener(Event.SCROLL, onHtmlScroll);
					sendEvent(UIEvent.SCROLL);
				}
			}
		}
		
		
		
		
		
		private function changeDrawBackground():void{
			graphics.clear();
			graphics.beginFill(0xffff,1)
			graphics.drawRect(0,0,width,height)
			graphics.endFill()
		}
		private function changeHtml():void{
			changeDrawBackground()
			
			var vShow:Boolean = _vScrollBar;
			var hShow:Boolean = _hScrollBar;
			var showWidth:Number = vShow ? _width - _vScrollBar.width : _width;
			var showHeight:Number = hShow ? _height - _hScrollBar.height : _height;
			if(_html){
				_html.x=_margin[0];
				_html.y=_margin[1];
				if (!isNaN(_width)) {
					_html.width=showWidth- _margin[0] - _margin[2]
				}
				
				if(!isNaN(_height)){
					_html.height=showHeight-_margin[1]-_margin[3]
				}
			}
			
			
			
		}
		private function changeSkinImage():void{
			if(_skinImage){
				_skinImage.width=width
				_skinImage.height=height	
			}
		
		}
		
		protected function onHtmlScroll(e:Event):void {
			changeScroll();
			sendEvent(UIEvent.SCROLL);
		}
		
		private function changeScroll():void {
			var vShow:Boolean = _vScrollBar
			var hShow:Boolean = _hScrollBar
			
			changeHtml()
			
			if (_vScrollBar) {
				_vScrollBar.x = _width - _vScrollBar.width - _margin[2];
				_vScrollBar.y = _margin[1];
				_vScrollBar.height = _height - (hShow ? _hScrollBar.height : 0) - _margin[1] - _margin[3];
				_vScrollBar.scrollSize = 1;
				_vScrollBar.thumbPercent =_html.scrollV/ _html.contentHeight
				_vScrollBar.setScroll(1, _html.contentHeight,scrollV)
			}
			if (_hScrollBar) {
				_hScrollBar.x = _margin[0];
				_hScrollBar.y = _height - _hScrollBar.height - _margin[3];
				_hScrollBar.width = _width - (vShow ? _vScrollBar.width : 0) - _margin[0] - _margin[2];
				_hScrollBar.scrollSize = 1
				_hScrollBar.thumbPercent =_html.scrollH/_html.contentWidth
				_hScrollBar.setScroll(0, _html.contentWidth, scrollH);
			}
		}
		
		
	}
}