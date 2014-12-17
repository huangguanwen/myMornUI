package com.senocular.ui
{
	import flash.events.Event;
	
	public class VirtualMouseEvent extends Event
	{
		public function VirtualMouseEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}