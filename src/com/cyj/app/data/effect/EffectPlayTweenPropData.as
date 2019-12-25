package com.cyj.app.data.effect
{
	public class EffectPlayTweenPropData
	{
		public var from:Number = 0;
		public var to:Number = 0;
		public var time:int;
		public var type:int;
		public var prop:String;
		
		public function EffectPlayTweenPropData()
		{}
		public function init($prop:String, $from:Number, $to:Number, $time:int):void
		{
			prop = $prop;
			from = $from;
			to = $to;
			time = $time;
		}
		
		public function parser(data:Object):void
		{
			for(var key:String in data)
			{
				if(this.hasOwnProperty(key))
				{
					this[key] = data[key];
				}
			}
		}
		
	}
}