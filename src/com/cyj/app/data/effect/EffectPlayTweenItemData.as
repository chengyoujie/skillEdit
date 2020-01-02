package com.cyj.app.data.effect
{
	public class EffectPlayTweenItemData
	{
		public var prop:String;
		public var from:Number = 0;
		public var to:Number = 0;
		
		public function EffectPlayTweenItemData()
		{
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