package com.cyj.app.data
{
	public class MovieData
	{
		public var dir:int;
		public var subtexture:Object;
		public var resName:String;
		public var len:int;
		public var speed:int;
		public var acts:String;
		
		public var frames:Array;
		
		public function MovieData(data:Object)
		{
			for(var key:String in data)
			{
				if(key == "frames")continue;
				if(this.hasOwnProperty(key))
				{
					this[key] = data[key];
				}
			}
			if(data["frames"])
			{
				var fms:Array = data["frames"];
				frames = [];
				for(var i:int=0; i<fms.length; i++)
				{
					frames.push(new FrameData(fms[i]));
				}
			}
		}
	}
	
	
}


