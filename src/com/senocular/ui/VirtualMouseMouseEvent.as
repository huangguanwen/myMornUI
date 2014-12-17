package com.senocular.ui
{
	import flash.events.Event;
	
	public class VirtualMouseMouseEvent extends Event
	{
		public function VirtualMouseMouseEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}