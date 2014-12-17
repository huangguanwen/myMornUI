package com.book.yao.components.flipbook
{
	import com.book.yao.GC;
	import com.book.yao.components.flipbook.events.ContainerReadyEvent;
	import com.book.yao.components.flipbook.events.FlipCompleteEvent;
	import com.book.yao.components.flipbook.events.FlipEvent;
	import com.book.yao.components.flipbook.events.LoadErrorEvent;
	import com.book.yao.components.flipbook.events.LoadProgressEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	
	[Event(name="ready", type="com.book.yao.components.flipbook.events.ContainerReadyEvent")]
	[Event(name="next", type="com.book.yao.components.flipbook.events.ContainerReadyEvent")]
	[Event(name="prev", type="com.book.yao.components.flipbook.events.ContainerReadyEvent")]
	[Event(name="cover", type="com.book.yao.components.flipbook.events.ContainerReadyEvent")]
	[Event(name="flipComplete", type="com.book.yao.components.flipbook.events.FlipCompleteEvent")]
	[Event(name="loadProgress", type="com.book.yao.components.flipbook.events.LoadProgressEvent")]
	[Event(name="loadError", type="com.book.yao.components.flipbook.events.LoadErrorEvent")]
	internal class Flip_page_Action extends Sprite
	{
		protected var _checkPoint:CheckPoint;//判断各点坐标
		protected var _page:Page;//负责加载
		protected var _hot:Hot; //四个热区
		
		private var _staticPageMask:StaticMask;//不动的页面的遮罩
		private var _dragedPageMask:DragedMask;//被拖动的页面的遮罩
		private var _downShadowMask:ShadowMask;//跟随移动的阴影的遮罩
		private var _upShadowMask:DragedMask;//跟随移动的阴影的遮罩
		
		protected var _halfPage:HalfPage;//被拖动的半页
		
		private var _upShadow:Shadow;//跟随移动的c点方向的阴影
		private var _downShadow:Shadow;//跟随移动的页脚方向的阴影
		private var _staticShadow:Shadow;//翻页完毕后显示的阴影
		
		private var _shadowManager:ShadowManager;
		private var _dragedHalfPageContainer:Sprite;
		private var _allPageContainer:Sprite;
		
		private var _pageWidth:Number=1920;//页面宽度
		private var _pageHeight:Number=1080;//页面高度
		
		protected var _canBeDraged:Boolean = false;//是不是能被拖动
		
		
		
		
		
		private var _hotSize:Number;
		
		
		
		public function Flip_page_Action(pageWidth:Number=1920,pageHeight:Number=1080,hotWidth:Number=50)
		{
			super();
			init(pageWidth,pageHeight,hotWidth);
		}
		
		
		public function dispose():void{
			_checkPoint.removeEventListener(FlipEvent.MOVE, moveHandler);//翻页过程中
			_checkPoint.removeEventListener(FlipCompleteEvent.FLIP_COMPLETE, flipComHandler);//翻页完毕
			_page.removeEventListener(ContainerReadyEvent.READY, readyHandler);//页面预备好了
			_page.removeEventListener(LoadProgressEvent.LOAD_PROGRESS, loadProgressHandler);//页面加载中
			_page.removeEventListener(LoadErrorEvent.LOAD_ERROR, loadErrorHandler);//页面加载中
		}
		//页面宽度、页面高度、热区宽度
		private function init(pageWidth:Number,pageHeight:Number,hotWidth:Number):void
		{
			_pageWidth = pageWidth;
			_pageHeight = pageHeight;
			_hotSize=hotWidth
			
			_checkPoint = new CheckPoint();
			_checkPoint.addEventListener(FlipEvent.MOVE, moveHandler);//翻页过程中
			_checkPoint.addEventListener(FlipCompleteEvent.FLIP_COMPLETE, flipComHandler);//翻页完毕
			
			_page = new Page();
			
			_page.addEventListener(ContainerReadyEvent.READY, readyHandler);//页面预备好了
			_page.addEventListener(LoadProgressEvent.LOAD_PROGRESS, loadProgressHandler);//页面加载中
			_page.addEventListener(LoadErrorEvent.LOAD_ERROR, loadErrorHandler);//页面加载中
			_page.addEventListener(ContainerReadyEvent.READY,onReady)
			
			_staticPageMask = new StaticMask();
			_dragedPageMask = new DragedMask();
			_upShadowMask = new DragedMask();
			
			_allPageContainer = new Sprite();
			_dragedHalfPageContainer = new Sprite();
			_dragedHalfPageContainer.mask = _dragedPageMask;
			_allPageContainer.mask = _staticPageMask;
			
			_halfPage = new HalfPage(pageWidth, pageHeight,_dragedHalfPageContainer,_allPageContainer);
			
			//设置阴影
			_downShadowMask = new ShadowMask();		
			_upShadow = new Shadow();
			_downShadow = new Shadow();
			_staticShadow = new Shadow();
		
			_downShadow.mask = _downShadowMask ;
			_upShadow.mask = _upShadowMask ;
		
			_shadowManager = new ShadowManager();
			_shadowManager.upShadow = _upShadow;
			_shadowManager.downShadow = _downShadow;
			_shadowManager.staticShadow = _staticShadow;
			
			_hot = new Hot(pageWidth, pageHeight, hotWidth);
			_hot.showHot = Hot.RIGHT;
			
			
			addChild(_staticPageMask);
			addChild(_dragedPageMask);
			addChild(_downShadowMask);
			addChild(_upShadowMask);
			
			addChild(_page);
			addChild(_staticShadow);
			addChild(_allPageContainer);
			addChild(_downShadow);
			addChild(_dragedHalfPageContainer);
			addChild(_upShadow);
			
			addChild(_hot);
			
			
			setBookSize(_pageWidth, _pageHeight)
			
		}
		/**
		 * 设置书大小 
		 * @param w
		 * @param h
		 * 
		 */		
		public function setBookSize(w:Number,h:Number):void{
			_pageWidth=w
			_pageHeight=h
			_checkPoint.setSize(w,h);

			_page.setSize(w,h)
			
			_halfPage.pageWidth=w
			_halfPage.pageHeight=h
			_downShadowMask.creat(w,h);
			_upShadow.creat(w,h, false);
			_downShadow.creat(w,h, false);
			_staticShadow.creat(w,h, true);
			_staticShadow.x =w / 2;
			_staticShadow.y =h / 2;
			
		}
		//运动过程中
		private function moveHandler(evn:Event):void
		{
			_dragedPageMask.draw(_checkPoint.theCPoint, _checkPoint.theDPoint, _checkPoint.theBPoint, _checkPoint.theAPoint);//调整遮罩
			_upShadowMask.draw(_checkPoint.theCPoint, _checkPoint.theDPoint, _checkPoint.theBPoint, _checkPoint.theAPoint);//调整遮罩
			_staticPageMask.draw(_pageWidth, _pageHeight, _hot.pressedHotName, _checkPoint.theDPoint, _checkPoint.theBPoint, _checkPoint.theAPoint);//调整遮罩
			_halfPage.onDrag(_checkPoint.theCPoint, _checkPoint.pageAngle, _hot.pressedHotName);//调整运动的半页的状态
			_shadowManager.setShadow(_checkPoint.theDPoint, _checkPoint.theBPoint, _checkPoint.lineAngle);//调整阴影状态
			
			_hot.showHot = Hot.NULL;//隐藏所有热区			
		}
		
		private function onReady(e:ContainerReadyEvent):void{
		//	trace("准备翻页: "+e.containerType)
			switch(e.containerType)
			{
				case ContainerReady.JUMP_NEXT:
				{
					next()
					break;
				}
				case ContainerReady.JUMP_PREV:
				{
					prev()
					break;
				}
				default:
				{
					break;
				}
			}
		}
		//翻页完毕
		private function flipComHandler(evn:FlipCompleteEvent):void
		{
			_halfPage.free();
			_page.flipCompleteHandler(evn.flipType);
			if (_page.isEnd || _page.isStart)
			{
				_shadowManager.flipCompleteHandler(evn.flipType,true);
			}
			else
			{
				_shadowManager.flipCompleteHandler(evn.flipType);
			}
			_dragedPageMask.clear();
			_staticPageMask.clear();
			
			if (_page.isStart)//如果是第一页
			{
				_hot.showHot = Hot.RIGHT;//只显示右边的两个热区
			}
			else if (_page.isEnd)//如果是最后一页
			{
				_hot.showHot = Hot.LEFT;//只显示左边的两个热区
			}
			else
			{
				_hot.showHot = Hot.ALL;//热区全部显示
			}
			
			
			dispatchEvent(evn);
			
			GC.gc();
		}
		//页面准备好了
		protected function readyHandler(evn:ContainerReadyEvent):void
		{
			
			dispatchEvent(evn)
		}
		//加载过程中
		private function loadProgressHandler (evn:LoadProgressEvent):void
		{
			dispatchEvent(evn)
		}
		//加载错误
		private function loadErrorHandler(evn:LoadErrorEvent):void
		{
			dispatchEvent(evn)
		}
		
		
		public function get pages():Vector.<String>{return _page.pageArray};
		/*---------------------------------------------------------------------------------------------方法-------------------*/
		/**
		 * 调用该方法开始加载
		 * @param	array 存放页面路径数组
		 */
		public function load(array:Vector.<String>):void
		{
		//	_page.pageArray.length=0
			for (var i:int=0;i<array.length;i++){
				_page.loadPage(array[i])
			}
		//	_page.pageArray = array;
			_page.loadCover();
		}
		
		
		/**
		 * 翻到下一页
		 */
		public function next():void
		{
			if (!_checkPoint.moving)//如果没有动
			{
				if (_page.currentPage != null)//如果当前容器不为空（如果封面已经加载完了）
				{
					if (_page.nextPage!=null)//如果下一页准备好了
					{
						_page.loadingType = "";
						_page.closeLoader();
						_canBeDraged = true;
						
						//moveHandler侦听器中需要用到该属性。
						//在点击按钮翻页时，设置该属性，模拟鼠标点击hot
						_hot.pressedHotName = HotName.RIGHT_DOWN;
						
						_halfPage.addAllPage(_page.nextPage, "right");//绘制被拖动的bitmap
						_checkPoint.autoFlip(HotName.RIGHT_DOWN);//开始翻页
					}
					else
					{
						_page.loadingType = "next";
						if (_page.nextLoaderClosed)
						{
							_page.loadNext();
						}
					}
				}
			}			
		}
		
		
		
		/**
		 * 翻到上一页
		 */
		public function prev():void
		{
			if(_checkPoint.moving)return 
			if(_page.currentPage==null)return//如果当前容器为空（页面未加载完成）, return
			if (_page.prevPage != null )//如果上一页准备好了
			{
				_page.loadingType = "";
				_page.closeLoader();
				_canBeDraged = true;
				
				//moveHandler侦听器中需要用到该属性。
				//在点击按钮翻页时，设置该属性，模拟鼠标点击hot
				_hot.pressedHotName = HotName.LEFT_DOWN;
				
				_halfPage.addAllPage(_page.prevPage, "left");//绘制被拖动的bitmap
				_checkPoint.autoFlip(HotName.LEFT_DOWN);//开始翻页
			}
			else
			{
				_page.loadingType = "prev";
				if (_page.prevLoaderClosed)_page.loadPrev();
			}
		}
		
		
		
		/**
		 * 跳转页面
		 * @param	n 要跳转到的页面的序号
		 */
		public function gotoP(n:uint):void
		{
			
			if(currentPageIndex==n)return//如果已经是当前页
			if(n>=_page.pageCount)return //如果大于等于总量，直接返回
			if(_checkPoint.moving)return //如果没动,直接返回
			if(_page==null)return//如果容器为空(未加载完成)
				
			if (n == _page.currentPageIndex + 1)//如果是下一页
			{
				next();
				return
			}
			else if (n == _page.currentPageIndex - 1)//如果是上一页
			{
				
				prev();
				return
			}
			
			
			trace("直接跳转")
			_page.closeLoader();				
			_page.jump(n);
			
		}
		
		/*----------------------------------------------------------------------------------------------属性--------------------*/
		/**
		 * 翻页完毕后是否显示中间阴影
		 */
		public function set showShadowOnFlipComplete(show:Boolean):void
		{
			_shadowManager.showShadowOnFlipComplete = show;
		}
		public function get showShadowOnFlipComplete():Boolean
		{
			return _shadowManager.showShadowOnFlipComplete;
		}
		/**
		 * 当前页序号。从0开始
		 */
		public function get currentPageIndex():uint
		{
			return _page.currentPageIndex;
		}
		/**
		 * 总页数
		 */
		public function get pageCount():uint
		{
			return _page.pageCount;
		}
		/**
		 * 当前页的引用
		 */
		public function get currentPage():DisplayObject
		{
			return _page.currentPage;
		}
		/**
		 * 下一页的引用
		 */
		public function get nextPage():DisplayObject
		{
			return _page.nextPage;
		}
		/**
		 * 上一页的引用
		 */
		public function get prevPage():DisplayObject
		{
			return _page.prevPage;
		}
		/**
		 * 热区透明度
		 */
		public function set hotAlpha(a:Number):void
		{
			_hot.hotAlpha = a
		}
		public function get hotAlpha():Number
		{
			return _hot.hotAlpha;
		}
	}
}