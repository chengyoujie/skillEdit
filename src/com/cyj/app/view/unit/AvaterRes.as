package com.cyj.app.view.unit
{
	import com.cyj.app.SimpleEvent;
	import com.cyj.app.ToolsApp;
	import com.cyj.app.data.FrameData;
	import com.cyj.app.data.FrameItemData;
	import com.cyj.app.data.MovieData;
	import com.cyj.app.view.app.AppEvent;
	import com.cyj.utils.load.ResData;
	import com.cyj.utils.load.ResLoader;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

	public class AvaterRes
	{
		private static var _cache:Dictionary = new Dictionary();
		public static function get(path:String):AvaterRes
		{
			if(_cache[path])return _cache[path];
			var res:AvaterRes = new AvaterRes(path);
			_cache[path] = res;
			return res;
		}
		
//		public static var cache:AvaterCache = new AvaterCache();
		private var _path:String;
		private var _data:MovieData;
		private var _image:BitmapData;
		private var _subImgInfos:Object;
		private var _maxFrame:int=-1;
		private var _isReady:Boolean = false;
		private var _w:Number=0;
		private var _h:Number = 0;
		private var _ox:Number = 0;
		private var _oy:Number = 0;
		private var _defaultFrameData:FrameData;
		
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
			_data = new MovieData(json);
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
				_subImgInfos ={};
				_defaultFrameData = new FrameData();
				var subtexture:Object = _data.subtexture;
				var imgFrame:int = 0;
				for(var key:String in subtexture)
				{
					var frameData:Object = subtexture[key];
					var keyNum:int = int(key)%100;
					if(keyNum>imgFrame)
					{
						imgFrame = keyNum;
					}
					var fd:SubImageInfo = new SubImageInfo();
					fd.img = subImg(_image, frameData[0], frameData[1], frameData[2], frameData[3] );
					fd.ox = frameData[4];
					fd.oy = frameData[5];
					_subImgInfos[keyNum] = fd;
					if(_w<frameData[2])_w = frameData[2];
					if(_h<frameData[3])_h = frameData[3];
					if(_ox>fd.ox)_ox = fd.ox;
					if(_oy>fd.oy)_oy = fd.oy;
					//default frame
					var frameItem:FrameItemData = new FrameItemData();
					frameItem.ox = fd.ox;
					frameItem.oy = fd.oy;
					frameItem.res = keyNum+"";
					frameItem.w = frameData[2];
					frameItem.h = frameData[3];
					_defaultFrameData.items.push(frameItem);
				}
				if(_data.frames)
				{
					_maxFrame = -1;
					for(var i:int=0; i<_data.frames.length; i++)
					{
						var frame:FrameData = _data.frames[i];
						if(frame.items.length>_maxFrame)
						{
							_maxFrame = frame.items.length;
						}
					}
				}else{
					_maxFrame = imgFrame;
				}
				_isReady = true;
				ToolsApp.event.dispatchEvent(new SimpleEvent(AppEvent.AVATER_RES_COMPLETE, this));
			}
		}
		
		public function getFrames():Array
		{
			if(_data && _data.frames)
				return _data.frames;
			return [_defaultFrameData];
		}
		
		public function getDefaultFrameData():FrameData
		{
			return _defaultFrameData;
		}
		
		public function getSubImageInfo(id:String):SubImageInfo
		{
			return _subImgInfos[id];
		}
		
		public function get subImageInfos():Object
		{
			return _subImgInfos;
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
		
//		public function get frameData():Object
//		{
//			return _frameDatas;
//		}
		
		public function get data():MovieData
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