package com.cyj.app.data
{
	import com.cyj.app.data.effect.EffectPlayItemData;

	public class EffectGroupItemData implements ICopyData
	{
		public var id:int = 0;
		public var name:String = "";
		public var data:Array = [];
		
		public function EffectGroupItemData()
		{
		}
		
		public function parser(data:Object):void
		{
			for(var key:String in data)
			{
				if(key == "data")
				{
					this.data.length = 0;
					var items:Array = this.data;
					var arr:Array = data[key];
					for(var i:int=0; i<arr.length; i++)
					{
						var item:EffectPlayItemData = new EffectPlayItemData();
						item.parser(arr[i]);
						items.push(item);
					}
				}else if(this.hasOwnProperty(key))
				{
					this[key] = data[key];
				}
			}
		}
		
		public function copy():ICopyData
		{
			var cd:EffectGroupItemData = new EffectGroupItemData();
			cd.id = id;
			cd.data = [];
			for(var i:int=0; i<data.length; i++)
			{
				var item:EffectPlayItemData = data[i];
				cd.data.push(item.copy() );
			}
			return cd;
		}
	}
}