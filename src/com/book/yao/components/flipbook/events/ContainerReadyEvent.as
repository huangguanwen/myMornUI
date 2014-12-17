package com.book.yao.components.flipbook.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author yaoguozhen
	 */
	public class ContainerReadyEvent extends Event 
	{
		/**
		 * 页面准备好了 
		 */		
		public static const READY:String = "ready";
		public static const NEXT:String = "next";
		public static const PREV:String = "prev";
	    public static const COVER:String = "cover";
		
		public static const JUMP_NEXT:String = "jump_next";
		public static const JUMP_PREV:String = "jump_prev";
		
	
		

		private var _containerType:String
		public function get containerType():String{return _containerType}
		
		
		public function set containerType(value:String):void{
			_containerType=value
		}
		
		public function ContainerReadyEvent(type:String, containerType:String=null,bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
		//	_containerType=containerType
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new ContainerReadyEvent(type, _containerType,bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ContainerReadyEvent", "type", "containerType","bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}