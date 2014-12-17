﻿package com.book.yao.components.flipbook
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import com.book.yao.components.flipbook.events.HotEvent;
	
	internal class Hot extends Sprite
	{
		public static const ALL:String = "all";
		public static const NULL:String = "null";
		public static const LEFT:String = "left";
		public static const RIGHT:String = "right";
		
		private var _pressedHotName:String = "";//当前热区的名称
		private var _draged:Boolean = false;
		
		private var _pageWidth:Number;//page的宽度
		private var _pageHeight:Number;//page的高度
		
		private var _hotSize:Number;//热区的宽度
	
		
		
		//热区的容器
		private var _hotLeftUp:Sprite=new Sprite();
		private var _hotLeftDown:Sprite=new Sprite();
		private var _hotRightUp:Sprite=new Sprite();
		private var _hotRightDown:Sprite = new Sprite();
		
		private var _alpha:Number = 0;
		
		

		
		/**
		 * 构造函数
		 */
		public function Hot(pageWidth:Number,pageHeight:Number,hotWidth:Number):void
		{
			//trace("初始化热区: "+pageWidth,pageHeight)
			_hotLeftUp.name = HotName.LEFT_UP;
			addListener(_hotLeftUp);
			addChild(_hotLeftUp)
			
			_hotLeftDown.name = HotName.LEFT_DOWN;
			addListener(_hotLeftDown);
			addChild(_hotLeftDown)
			
			_hotRightUp.name = HotName.RIGHT_UP;
			addListener(_hotRightUp);
			addChild(_hotRightUp)
			
			_hotRightDown.name = HotName.RIGHT_DOWN;
			addListener(_hotRightDown);
			addChild(_hotRightDown)
			
			_hotLeftUp.alpha = _alpha;
			_hotLeftDown.alpha = _alpha;
			_hotRightUp.alpha = _alpha;
			_hotRightDown.alpha = _alpha;
			
			_pageWidth = pageWidth;
			_pageHeight = pageHeight;
			_hotSize = hotWidth;
			creatFourHot();
		}
		/**
		 * 生成四个角的热区
		 */
		private function creatFourHot():void
		{
			drawAndSetHot(_hotLeftUp,0,0);
			drawAndSetHot(_hotLeftDown,0,_pageHeight-_hotSize);
			drawAndSetHot(_hotRightUp,_pageWidth-_hotSize,0);
			drawAndSetHot(_hotRightDown,_pageWidth-_hotSize,_pageHeight-_hotSize);
		}
		/**
		 * 生成并且设置每一个热区
		 * @param	sprite 热区矩形的容器
		 * @param	x 热区的横坐标
		 * @param	y 热区的纵坐标
		 */
		private function drawAndSetHot(sprite:Sprite,x:Number,y:Number):void
		{
			sprite.x=x;
			sprite.y=y;
            drawHots(sprite)	
		}
		private function drawHots(sprite:Sprite):void{
			sprite.graphics.clear()
			sprite.graphics.beginFill(0xffff);
			sprite.graphics.drawRect(0,0,_hotSize,_hotSize);
		    sprite.graphics.endFill()
		}
		/**
		 * 在热区按下鼠标
		 * @param	evn 鼠标事件
		 */
		private function hotMouseDownHandler(evn:MouseEvent):void
		{
            trace("按下了鼠标")
			stage.addEventListener(MouseEvent.MOUSE_MOVE,hotStageMouseMoveHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP,hotStageMouseUpHandler);
			
			_pressedHotName=evn.target.name;
			
			var event:HotEvent = new HotEvent(HotEvent.PRESSED);
			event.hotName = _pressedHotName;
			dispatchEvent(event);
		}
		/**
		 * 在热区按下鼠标后松开鼠标
		 * @param	evn 鼠标事件
		 */
		private function hotStageMouseUpHandler(evn:MouseEvent):void
		{
			//_pressedHotName = "";
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,hotStageMouseMoveHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP,hotStageMouseUpHandler);
			
			var event:HotEvent = new HotEvent(HotEvent.RELEASED);
			event.hotName = _pressedHotName;
			dispatchEvent(event);
			
			_draged = false;
		}
		/**
		 * 在热区按下鼠标后移动鼠标
		 * @param	evn 鼠标事件
		 */
		private function hotStageMouseMoveHandler(evn:MouseEvent):void
		{
			_draged = true;
			var event:HotEvent = new HotEvent(HotEvent.DRAGED);
			event.hotName = _pressedHotName;
			dispatchEvent(event);
			
			trace("按下了鼠标")
		}
		
		
		private function addListener(obj:Sprite):void
		{
		
			if (!obj.hasEventListener(MouseEvent.MOUSE_DOWN))
			{
				//trace("注册鼠标")
				obj.addEventListener(MouseEvent.MOUSE_DOWN,hotMouseDownHandler);
			}
		}
		private function removeListener(obj:Sprite):void
		{
			obj.removeEventListener(MouseEvent.MOUSE_DOWN,hotMouseDownHandler);
		}
		
		/*-------------------------------------------------------------------------------------------------------------*/

		/*-------------------------------------------------------------------------------------------公共属性----------------*/
		//设置可见的热区
		public function set showHot(type:String):void
		{
			
			switch(type)
			{
				case "all":
			        _hotRightDown.visible = true;
					_hotRightUp.visible = true;
					_hotLeftDown.visible = true;
					_hotLeftUp.visible = true;
				    break;
				case "null":
				    _hotRightDown.visible = false;
					_hotRightUp.visible = false;
					_hotLeftDown.visible = false;
					_hotLeftUp.visible = false;
				    break;
				case "left":
				    _hotRightDown.visible = false;
					_hotRightUp.visible = false;
					_hotLeftDown.visible = true;
					_hotLeftUp.visible = true;
				    break;
				case "right":
				    _hotRightDown.visible = true;
					_hotRightUp.visible = true;
					_hotLeftDown.visible = false;
					_hotLeftUp.visible = false;
				    break;
			}
		}
		/**
		 * 当前点击热区的名字
		 */
		public function get pressedHotName():String
		{
			return _pressedHotName;
		}
		public function set pressedHotName(s:String):void
		{
			_pressedHotName=s;
		}
		//在热区上按下后是否拖动了
		public function get draged():Boolean
		{
			return _draged;
		}
		//热区透明度
		public function set hotAlpha(a:Number):void
		{
			_alpha = a;
			_hotLeftUp.alpha = a;
			_hotLeftDown.alpha = a;
			_hotRightUp.alpha = a;
			_hotRightDown.alpha = a;
		}
		public function get hotAlpha():Number
		{
			return _alpha;
		}
	}
	
}
