package morn.core.components
{
	import com.book.yao.components.flipbook.FlipPage;
	
	import flash.display.DisplayObject;
	
	
	/**
	 * 
	 * 翻书组件
	 *@author 偷心枫贼
	 *        上午11:50:03
	 *
	 */
	public class Book extends Component
	{
		protected var _book:FlipPage
		
		public function get book():FlipPage{return _book}
		
		/**
		 * 翻页完毕后是否显示阴影 
		 * @param show
		 * 
		 */		
		public function set showShadowOnFlipComplete(show:Boolean):void
		{
			_book.showShadowOnFlipComplete=show
		}
		public function get showShadowOnFlipComplete():Boolean
		{
			return 	_book.showShadowOnFlipComplete
		}
		
		
		/**
		 * 热区透明度
		 */
		public function set hotAlpha(a:Number):void
		{
			_book.hotAlpha = a
		}
		public function get hotAlpha():Number
		{
			return _book.hotAlpha;
		}
		
		
		/**
		 * 当前页序号。从0开始
		 */
		public function get currentPageIndex():uint
		{
			return _book.currentPageIndex;
		}
		
		/**
		 * 总页数
		 */
		public function get pageCount():uint
		{
			return _book.pageCount;
		}
		
		
		/**
		 * 当前页的引用
		 */
		public function get currentPage():DisplayObject
		{
			return _book.currentPage;
		}
		
		
		/**
		 * 下一页的引用
		 */
		public function get nextPage():DisplayObject
		{
			return _book.nextPage;
		}
		/**
		 * 上一页的引用
		 */
		public function get prevPage():DisplayObject
		{
			return _book.prevPage;
		}
		public function Book()
		{
			super();
		}
		
		/**预初始化，在此可以修改属性默认值*/
		override protected function preinitialize():void {
			_width=400
			_height=300
			//mouseChildren = true;
			
			graphics.clear()
			graphics.beginFill(0xffffffff,1)
			graphics.drawRect(0,0,_width,_height)
			graphics.endFill()
		}
		override protected function createChildren():void
		{
			// TODO Auto Generated method stub
			super.createChildren();
			addChild(_book=new FlipPage(width,height))
		}
		
	
		public function get pages():Vector.<String>{return _book.pages}
		/**
		 * 加载数组 
		 * @param links
		 * 
		 */		
		public function load(links:Vector.<String>):void{
			_book.load(links);
		}
		
		override protected function changeSize():void
		{
			// TODO Auto Generated method stub
			super.changeSize();
			
			graphics.clear()
			graphics.beginFill(0xffffffff,1)
			graphics.drawRect(0,0,_width,_height)
			graphics.endFill()
			_book.setBookSize(_width,_height)	
		}
		
		
		
		
		/**
		 * 上一页 
		 * 
		 */		
		public function prev():void{
			_book.prev()
		}
		/**
		 * 下一页 
		 * 
		 */		
		public function next():void{
			_book.next();
		}
		/**
		 * 翻到某页 
		 * @param n
		 * 
		 */		
		public function gotoP(n:uint):void{
		
			_book.gotoP(n)
		}
		
	}
}