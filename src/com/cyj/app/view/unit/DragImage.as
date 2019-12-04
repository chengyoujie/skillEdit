package com.cyj.app.view.unit
{
	import com.cyj.app.ToolsApp;
	import com.cyj.utils.load.ResData;
	import com.cyj.utils.load.ResLoader;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	public class DragImage extends Sprite
	{
		private var bmp:Bitmap;
		private var _path:String;
		
		public function DragImage()
		{
			super();
			bmp = new Bitmap();
			this.addChild(bmp);
			
		}
		
		public function set path(value:String):void
		{
			_path = value;
			ToolsApp.loader.loadSingleRes(_path, ResLoader.IMG, handleImgLoaded);
		}
		
		private function handleImgLoaded(res:ResData):void
		{
			bmp.bitmapData = res.data;
			bmp.x = -bmp.width/2;
			bmp.y = -bmp.height;
		}
		
		public function get path():String
		{
			return _path;			
		}
		
	}
}