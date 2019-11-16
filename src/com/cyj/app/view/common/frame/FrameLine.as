package com.cyj.app.view.common.frame
{
	import com.cyj.app.data.FrameData;
	import com.cyj.app.view.ui.app.FrameLineUI;
	
	import flash.display.Sprite;
	
	public class FrameLine extends FrameLineUI
	{
		private var _frames:Array = [];
		public static const MAX_FRAME:int = 500;//最大帧数
		public static const EMPTY_FRAMES:Array = [];
		public function FrameLine()
		{
			super();
			this.width = Number.NaN;
			this.height = Number.NaN;
			imgBg.mouseEnabled = false;
			EMPTY_FRAMES.length = MAX_FRAME;
		}
		
		override public function setSize(w:Number, h:Number):void
		{
			listFrame.width = w-listFrame.x;
			imgBg.width = w - imgBg.x;
			listFrame.repeatX = int(listFrame.width/(10+listFrame.spaceX));
			super.setSize(w, h);
		}
		
		
		override public function set dataSource(value:Object):void
		{
			if(value is FrameData)
			{
				var items:Array = FrameData(value).items;
//				var arr:Array = [];
//				arr.length = MAX_FRAME;
//				for(var i:int=0; i<items.length; i++)
//				{
//					arr[i] = items[i];
//				}
				listFrame.dataSource =items; 
			}else{
				listFrame.dataSource = [];
			}
			super.dataSource = value;
		}
	}
}