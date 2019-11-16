package com.cyj.app.view.common.frame
{
	import com.cyj.app.data.FrameData;
	import com.cyj.app.data.FrameItemData;
	import com.cyj.app.view.ui.app.FrameItemUI;
	
	import flash.display.Sprite;
	
	public class FrameItem extends FrameItemUI
	{
		private var _data:FrameItemData;
		
		public function FrameItem()
		{
			super(); 
			this.mouseChildren = false;
			draw(0x333333);
		}
		
		override public function set dataSource(value:Object):void
		{
			if(value is FrameItemData)
			{
				txtTest.text = "1";
				_data = value as FrameItemData;
			}else{
				txtTest.text = "0";
				_data = null;
			}
			super.dataSource = value;
		}
		
		public function get data():FrameItemData
		{
			return _data;
		}
		
		public function get index():int
		{
			return int(this.name.replace("item", ""));
		}
		
		public function set select(value:Boolean):void
		{
			if(value)
				draw(0x00ff00);
			else
				draw(0x333333);
		}
		
		public function draw(color:int):void
		{
			this.graphics.clear();
			this.graphics.beginFill(color, 0.8);
			this.graphics.drawRect(0, 0, width, height);
			this.graphics.endFill();
		}
	}
}