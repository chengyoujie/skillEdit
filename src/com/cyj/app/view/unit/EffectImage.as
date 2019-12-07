package com.cyj.app.view.unit
{
	import com.cyj.app.ToolsApp;
	import com.cyj.app.data.ImageData;
	import com.cyj.utils.load.ResData;
	import com.cyj.utils.load.ResLoader;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	import morn.core.components.Image;
	
	public class EffectImage extends Sprite
	{
		private var _bmd:Bitmap;
		private var _path:String;
		private var _data:ImageData;
		
		public function EffectImage()
		{
			super();
			_bmd = new Bitmap();
			addChild(_bmd);
			_data = new ImageData();
			this.mouseChildren = false;
		}
		
		/**图片地址，如果值为已加载资源，会马上显示，否则会先加载后显示，加载后图片会自动进行缓存
		 * 举例：url="png.comp.bg" 或者 url="assets/img/face.png"*/
		public function get path():String {
			return _path;
		}
		
		public function set path(value:String):void {
			if (_path != value) {
				_path = value;
				_data.path = value;
				if (Boolean(value)) {
					ToolsApp.loader.loadSingleRes(_path, ResLoader.IMG, handleLoadComplete);
				} else {
					bitmapData = null;
				}
			}
		}
		
		public function get data():ImageData
		{
			return _data;
		}
		
		private function handleLoadComplete(res:ResData):void
		{
			if(_bmd)
			{
				_bmd.bitmapData = res.data;
			}
		}
		
		public function set bitmapData(value:BitmapData):void {
			_bmd.bitmapData = value;
		}
		
		public function dispose():void
		{
			if(this.parent)
			{
				this.parent.removeChild(this);
			}
			_bmd.bitmapData = null;
			_bmd = null;	
		}
	}
}