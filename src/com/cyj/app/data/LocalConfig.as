package com.cyj.app.data
{
	public class LocalConfig
	{
		
		
		public var localWebPath:String = "";
		public var localDataPath:String = "";
		public var sceneAvater:Array = [];
		
		public function LocalConfig()
		{
		}
		
		public function parse(data:Object):void
		{
			for(var key:String in data)
			{
				if(key == "sceneAvater")
				{
					var list:Array = data[key] || [];
					for(var  i:int=0; i<list.length; i++)
					{
						var avt:AvaterData = new AvaterData();
						avt.parse(list[i]);
						sceneAvater.push(avt);
					}
				}else if(this.hasOwnProperty(key))
				{
					this[key] = data[key];
				}
			}
		}
	}
}