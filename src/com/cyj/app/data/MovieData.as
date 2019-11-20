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
		
		public var frames:Array = [];//FrameData[]
		
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
		
//		public function getNewFrameData():FrameData
//		{
//			var startIndex:int = 0;
//				var f:FrameData;
//				for(var i:int=0; i<frames.length; i++)
//				{
//					f = frames[i];
//					var idx:int = int(f.name.replace("mv", ""));
//					if(idx>=startIndex)
//						startIndex = idx+1;
//				}
//				var frame:FrameData = new FrameData();
//				frame.name = "mv"+startIndex;
//				return frame;
//		}
		
		public function addFrameData(frameData:FrameData=null, index:int=-1):FrameData
		{
			if(!frames)
			{
				frames = [];
			}
			if(!frameData)
			{
				frameData = new FrameData();
				var startIndex:int = 0;
				var f:FrameData;
				for(var i:int=0; i<frames.length; i++)
				{
					f = frames[i];
					var idx:int = int(f.name.replace("mv", ""));
					if(idx>=startIndex)
						startIndex = idx+1;
				}
				frameData.name = "mv"+startIndex;
			}
			if(index == -1 || index>=frames.length)
			{
				frames.push(frameData);
			}else{
				frames.splice(index, 0, frameData);
			}
			return frameData;
		}
		
		public function removeFrameData(frameData:FrameData):FrameData
		{
			if(!frames)return null;
			var index:int = frames.indexOf(frameData);
			if(index == -1)return null;
			frames.splice(index, 1);
			return frameData;
		}
		
		public function get maxFrame():int
		{
			var maxFrame:int = 0;
			for(var i:int=0; i<frames.length; i++)
			{
				var len:int = FrameData(frames[i]).items.length;
				if(maxFrame<len)
				{
					maxFrame = len;
				}
			}
			return maxFrame;
		}
		
	}
	
	
}


