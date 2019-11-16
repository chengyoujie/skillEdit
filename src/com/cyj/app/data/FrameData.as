package com.cyj.app.data
{
	public class FrameData
	{
		public var items:Array = [];
		
		//编辑器用
//		public var width:int;
//		public var height:int;
		public var ox:int;
		public var oy:int;
		
		public function FrameData(data:Object=null)
		{
			if(!data)return;
				for(var i:int=0; i<data.items.length; i++)
				{
					items.push(new FrameItemData(data.items[i]));
				}
		}
	}
}