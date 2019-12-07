package com.cyj.app.data
{
	public class LocalConfig
	{
		
		
		public var localWebPath:String = "";
		public var localDataPath:String = "";
		public var sceneAvater:Array = [];
		/**开启时是否自动更新**/
		public var autoCheck:Boolean = true;
		
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