package com.cyj.app.view.unit
{
	import com.cyj.app.ToolsApp;
	import com.cyj.utils.load.ResData;
	import com.cyj.utils.load.ResLoader;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class AvaterRes
	{
//		public static var cache:AvaterCache = new AvaterCache();
		private var _path:String;
		private var _data:AvaterData;
		private var _image:BitmapData;
		private var _frameDatas:Object;
		private var _maxFrame:int=-1;
		private var _isReady:Boolean = false;
		private var _w:Number=0;
		private var _h:Number = 0;
		private var _ox:Number = 0;
		private var _oy:Number = 0;
		
		public function AvaterRes(path:String)
		{
			_path = path;
			load();
		}
		
		private function load():void
		{
			ToolsApp.loader.loadSingleRes(_path+".json", ResLoader.TXT, handleDataLoaded);
			ToolsApp.loader.loadSingleRes(_path+".png", ResLoader.IMG, handleImageLoaded);
		}
		
		private function handleDataLoaded(res:ResData):void
		{
			var json:Object = JSON.parse(res.data);
			_data = new AvaterData(json);
			checkComplete();
		}
		
		private function handleImageLoaded(res:ResData):void
		{
			_image = res.data;
			checkComplete();
		} 
		
		private function checkComplete():void
		{
			if(_data && _image)
			{
				_frameDatas ={};
				var subtexture:Object = _data.subtexture;
				for(var key:String in subtexture)
				{
					var frameData:Object = subtexture[key];
					var keyNum:int = int(key)%100;
					if(keyNum>_maxFrame)
					{
						_maxFrame = keyNum;
					}
					var fd:FrameData = new FrameData();
					fd.img = subImg(_image, frameData[0], frameData[1], frameData[2], frameData[3] );
					fd.ox = frameData[4];
					fd.oy = frameData[5];
					_frameDatas[keyNum] = fd;
					if(_w<frameData[2])_w = frameData[2];
					if(_h<frameData[3])_h = frameData[3];
					if(_ox>fd.ox)_ox = fd.ox;
					if(_oy>fd.oy)_oy = fd.oy;
				}
				_isReady = true;
			}
		}
		
		public function get width():Number
		{
			return _w;
		}
		public function get height():Number
		{
			return _h;
		}
		public function get oy():Number
		{
			return _oy;
		}
		public function get ox():Number
		{
			return _ox;
		}
		
		public function get isReady():Boolean
		{
			return _isReady;
		}
		
		public function get frameData():Object
		{
			return _frameDatas;
		}
		
		public function get data():AvaterData
		{
			return _data;
		}
		
		public function get maxFrame():int
		{
			return _maxFrame;
		}
		
		private function subImg(img:BitmapData, x:int, y:int, w:int, h:int):BitmapData
		{
			var bd:BitmapData = new BitmapData(w, h, true, 0);
			bd.copyPixels(img, new Rectangle(x, y, w, h), new Point());
			return bd;
		}
		
		public function get path():String
		{
			return _path;
		}
	}
	
}