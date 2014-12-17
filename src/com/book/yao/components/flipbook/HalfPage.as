package com.book.yao.components.flipbook 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author yaoguozhen
	 */
	internal class HalfPage
	{
		
	
		private var _pageWidth:Number;
		private var _pageHeight:Number;
		
		public function get pageWidth():Number { return _pageWidth; }		
		public function set pageWidth(value:Number):void
		{
			if (_pageWidth == value)
				return;
			_pageWidth = value;
		
		}
		
		
		
		
		public function get pageHeight():Number { return _pageHeight; }		
		public function set pageHeight(value:Number):void
		{
			if (_pageHeight == value)
				return;
			_pageHeight = value;
		
		}
		
		private var _dragedHalfPage:Bitmap;
		private var _allPage:Bitmap;
		private var _bmdAll:BitmapData;
		private var _bmdHalf:BitmapData;
		
		private var _dragedHalfPageContainer:Sprite;
		private var _allPageContainer:Sprite;
		
		public function HalfPage(pageWidth:Number, pageHeight:Number,dragedHalfPageContainer:Sprite,allPageContainer:Sprite) 
		{
			_pageWidth = pageWidth;
			_pageHeight = pageHeight;
			_dragedHalfPageContainer = dragedHalfPageContainer
			_allPageContainer = allPageContainer;
		}
		//添加整个的page，并且生成半页
		public function addAllPage(page:DisplayObject,dir:String):void
		{
			_bmdAll = new BitmapData(pageWidth, pageHeight);
			var matrix:Matrix=new Matrix()
			matrix.scale(pageWidth/page.width,pageHeight/page.height)
			_bmdAll.draw(page,matrix,null,null,null,true);
			_allPage = new Bitmap(_bmdAll);
			
			_bmdHalf = new BitmapData(pageWidth / 2, pageHeight);
			if (dir == "right")
			{
				_bmdHalf.copyPixels(_bmdAll, new Rectangle(0 , 0 , pageWidth/2 , pageHeight),new Point(0,0));
			}
			else if (dir == "left")
			{
				_bmdHalf.copyPixels(_bmdAll, new Rectangle(pageWidth/2 , 0, pageWidth/2, pageHeight),new Point(0,0));
			}
			
			_dragedHalfPage = new Bitmap(_bmdHalf);
			_allPageContainer.addChild(_allPage);
			_dragedHalfPageContainer.addChild(_dragedHalfPage);
		}
		//释放内存
		public function free():void
		{
			_dragedHalfPageContainer.removeChild(_dragedHalfPage);
			_allPageContainer.removeChild(_allPage);
			
			_dragedHalfPage = null;
			_allPage = null;
	
			_bmdAll.dispose();
			_bmdHalf.dispose();
		}
		//拖动时，调整半页状态
		public function onDrag(cPoint:Point,angle:Number,pressedHotName:String):void
		{
			_dragedHalfPageContainer.x = cPoint.x;
			_dragedHalfPageContainer.y = cPoint.y;
			switch(pressedHotName)
			{
				case HotName.LEFT_UP:
					_dragedHalfPageContainer.rotation = angle+180;
					_dragedHalfPage.x = -1*pageWidth/2;
					_dragedHalfPage.y = 0;
				    break;
				case HotName.LEFT_DOWN:
					_dragedHalfPageContainer.rotation = angle+180;
					_dragedHalfPage.x = -1*pageWidth/2;
					_dragedHalfPage.y = -1*pageHeight;
				    break;	
				case HotName.RIGHT_UP:
					_dragedHalfPageContainer.rotation = angle;
					_dragedHalfPage.x = 0;
					_dragedHalfPage.y = 0;
				    break;	
				case HotName.RIGHT_DOWN:
					_dragedHalfPageContainer.rotation = angle;
					_dragedHalfPage.x = 0;
					_dragedHalfPage.y = -1*pageHeight;
				    break;	
			}
		}
	}

}