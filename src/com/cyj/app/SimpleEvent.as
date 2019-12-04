package com.cyj.app
{
	import flash.events.Event;
	
	public class SimpleEvent extends Event
	{
		public var data:Object;
		public function SimpleEvent(type:String, $data:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.data = $data;
			super(type, bubbles, cancelable);
		}
		
		public static function send(type:String, data:*=null):void
		{
			ToolsApp.event.dispatchEvent(new SimpleEvent(type, data));
		}
		
		public static function on(type:String, fun:Function):void
		{
			ToolsApp.event.addEventListener(type, fun);
		}
	}
}