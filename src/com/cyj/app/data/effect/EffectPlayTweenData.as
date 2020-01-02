package com.cyj.app.data.effect
{
	public class EffectPlayTweenData
	{
		public var time:int;
		public var type:int;
		public var items:Array = [];//Vector.<EffectPlayTweenItemData>
		
		public function EffectPlayTweenData()
		{}
		public function init():void
		{
//			prop = $prop;
//			from = $from;
//			to = $to;
//			time = $time;
		}
		
		public function parser(data:Object):void
		{
			for(var key:String in data)
			{
				if(key == "items")
				{
					for(var i:int=0; i<data[key].length; i++)
					{
						var item:EffectPlayTweenItemData = new EffectPlayTweenItemData();
						item.parser(data[key][i]);
						items.push(item);
					}
				}else if(this.hasOwnProperty(key))
				{
					this[key] = data[key];
				}
			}
		}
		
	}
}