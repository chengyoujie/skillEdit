package com.cyj.app.data
{
	import com.cyj.app.view.unit.SubImageInfo;

	public class FrameItemData
	{
		//		"movex":0,
		//		"angle":90,
		//		"y":-40,
		//			"below":false,
		//			"time":0,
		//			"movey":0,
		//			"res":"img2",
		//			"delay":0,
		//			"sx":2,
		//			"sy":2,
		//			"x":-139
		//		public var angle:int;
		public var x:int;
		public var y:int;
		public var ox:int;
		public var oy:int;
		public var w:int;
		public var h:int;
		public var res:String;
		
		public function FrameItemData(data:Object=null)
		{
			if(!data)return;
			for(var key:String in data)
			{
				if(this.hasOwnProperty(key))
				{
					this[key] = data[key];
				}
			}
		}
		
		public static function getNewBySubImg(sub:SubImageInfo):FrameItemData
		{
			var item:FrameItemData = new FrameItemData();
			item.w = sub.img.width;
			item.h = sub.img.height;
			item.ox = sub.ox;
			item.oy = sub.oy;
			item.res = sub.key;
			item.x = 0;
			item.y = 0;
			return item;
		}
	}
}