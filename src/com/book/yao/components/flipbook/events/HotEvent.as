package com.book.yao.components.flipbook.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author yaoguozhen
	 */
	public class HotEvent extends Event 
	{
		/**
		 * 在触发点按下 
		 */		
		public static const PRESSED:String = "pressed";
		/**
		 *在触发点上按下并松开 
		 */		
		public static const RELEASED:String = "released";
		/**
		 * 按下并拖动 
		 */		
		public static const DRAGED:String = "draged";
		
		public var hotName:String;
		public function HotEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new HotEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("HotEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}