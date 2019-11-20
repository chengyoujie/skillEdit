package com.cyj.app.view.unit
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	public class DragImage extends Sprite
	{
		private var bmp:Bitmap;
		private var _data:SubImageInfo;
		
		public function DragImage()
		{
			super();
			bmp = new Bitmap();
			this.addChild(bmp);
			
		}
		
		public function set data(value:SubImageInfo):void
		{
			_data = value;
			if(_data)
			{
				bmp.bitmapData = _data.img;
				bmp.x = _data.ox;
				bmp.y = _data.oy;
			}else{
				bmp.bitmapData = null;
				bmp.x = 0; 
				bmp.y = 0;
			}
		}
		
		public function get data():SubImageInfo
		{
			return _data;			
		}
		
	}
}