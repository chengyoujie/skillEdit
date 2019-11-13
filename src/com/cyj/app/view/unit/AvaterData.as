package com.cyj.app.view.unit
{
	public class AvaterData
	{
		public var dir:int;
		public var subtexture:Object;
		public var resName:String;
		public var len:int;
		public var speed:int;
		public var acts:String;
		public function AvaterData(data:Object)
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


