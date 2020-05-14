package com.cyj.app.data
{
	import com.cyj.app.view.unit.SubImageInfo;

	public class FrameData
	{
		public var items:Array = [];
		
		//编辑器用
//		public var width:int;
//		public var height:int;
		public var ox:int;
		public var oy:int;
		
		public var name:String;
		public var scale:Number=1;
		public var visible:Boolean = true;
		
		public function FrameData(data:Object=null)
		{
			if(!data)return;
				for(var i:int=0; i<data.items.length; i++)
				{
					items.push(new FrameItemData(data.items[i]));
				}
		}
		
		
		
		public function addFrameItemBySubInfo(sub:SubImageInfo, index:int=-1):FrameItemData
		{
			var item:FrameItemData = FrameItemData.getNewBySubImg(sub);
			if(index==-1)
			{
				items.push(item);
			}else{
//				items.splice(index, 0, item);
				items[index] = item;
			}
			return item;
		}
	}
}