package com.cyj.app.view.app
{
	import com.cyj.app.view.ui.app.ImageResItemUI;
	import com.cyj.app.view.unit.SubImageInfo;
	
	public class ImageResItem extends ImageResItemUI
	{
		public function ImageResItem()
		{
			super();
			this.mouseChildren = false;
		}
		
		override public function set dataSource(value:Object):void
		{
			if(value is SubImageInfo)
				txtName.text = SubImageInfo(value).key;
			else
				txtName.text = "";
			super.dataSource = value;
		}
	}
}