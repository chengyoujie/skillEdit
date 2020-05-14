package com.cyj.app.view.unit
{
	import com.cyj.app.SimpleEvent;
	import com.cyj.app.ToolsApp;
	import com.cyj.app.data.FrameData;
	import com.cyj.app.data.FrameItemData;
	import com.cyj.app.data.MovieData;
	import com.cyj.app.view.app.AppEvent;
	import com.cyj.app.view.common.Alert;
	import com.cyj.utils.Log;
	import com.cyj.utils.load.ResData;
	import com.cyj.utils.load.ResLoader;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
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
		private var _resKeys:Array = [];
		
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
				if(_data.scale)
				{
					_defaultFrameData.scale = _data.scale;
				}
				var arr:Array = _data.sub;
				var i:int=0;
				var key:int = 0;
				while(arr.length>i)
				{
					var size:int = arr[i];
					var rotated:Boolean = false;
					if(size>=7)
						rotated = arr[i+7];
//					if(size>=6)
//						movie.addSubTexture(arr[i+1], arr[i+2], arr[i+3], arr[i+4], arr[i+5], arr[i+6], rotated);
					if(size<0)
					{
						Alert.show("当前json数据格式有误");
						Log.log("当前json数据格式有误");
						break;
					}
					key ++;
					var keyNum:int = int(key)%100;
					var fd:SubImageInfo = new SubImageInfo();
					fd.img = subImg(_image, arr[i+1], arr[i+2], arr[i+3], arr[i+4] , rotated);
					fd.ox = arr[i+5];
					fd.oy = arr[i+6];
					fd.key = keyNum;
					_subImgInfos[keyNum] = fd;
					if(_w< arr[i+3])_w =arr[i+3];
					if(_h< arr[i+4])_h = arr[i+4];
					if(_ox>fd.ox)_ox = fd.ox;
					if(_oy>fd.oy)_oy = fd.oy;
					//default frame
					var frameItem:FrameItemData = new FrameItemData();
					frameItem.ox = fd.ox;
					frameItem.oy = fd.oy;
					frameItem.res = keyNum+"";
					frameItem.w = arr[i+3];
					frameItem.h = arr[i+4];
					_resKeys.push(fd);
					_defaultFrameData.items.push(frameItem);
					i = i+ size+1;//加上size自身占位
				}
//				movie.speed = json.speed;
//				if(json.scale)
//				{
//					movie.scale = json.scale;
//				}
//				var subtexture:Object = _data.subtexture;
//				for(var key:String in subtexture)
//				{
//					var frameData:Object = subtexture[key];
//					var keyNum:int = int(key)%100;
//					var fd:SubImageInfo = new SubImageInfo();
//					fd.img = subImg(_image, frameData[0], frameData[1], frameData[2], frameData[3] );
//					fd.ox = frameData[4];
//					fd.oy = frameData[5];
//					fd.key = keyNum;
//					_subImgInfos[keyNum] = fd;
//					if(_w<frameData[2])_w = frameData[2];
//					if(_h<frameData[3])_h = frameData[3];
//					if(_ox>fd.ox)_ox = fd.ox;
//					if(_oy>fd.oy)_oy = fd.oy;
//					//default frame
//					var frameItem:FrameItemData = new FrameItemData();
//					frameItem.ox = fd.ox;
//					frameItem.oy = fd.oy;
//					frameItem.res = keyNum+"";
//					frameItem.w = frameData[2];
//					frameItem.h = frameData[3];
//					_resKeys.push(fd);
//					_defaultFrameData.items.push(frameItem);
//				}
				_resKeys.sortOn("key", Array.NUMERIC);
				if(_data.frames.length==0)
				{
					_data.frames.push(_defaultFrameData);
				}
				_maxFrame = -1;
				for(i=0; i<_data.frames.length; i++)
				{
					var frame:FrameData = _data.frames[i];
					if(frame.items.length>_maxFrame)
					{
						_maxFrame = frame.items.length;
					}
				}
				_isReady = true;
				ToolsApp.event.dispatchEvent(new SimpleEvent(AppEvent.AVATER_RES_COMPLETE, this));
			}
		}
		
		public function getResKeys():Array
		{
			return _resKeys;
		}
		 
//		public function getSubImageInfo(id:String):SubImageInfo
//		{
//			return _subImgInfos[id];
//		}
		
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
		
		
		private function subImg(img:BitmapData, x:int, y:int, w:int, h:int, rotated:Boolean=false):BitmapData
		{
			var bd:BitmapData;
			if(rotated)
			{
				bd = new BitmapData(w, h, true, 0);
				var matrix:Matrix = new Matrix(0, -1, 1,0, 0, 0);
				matrix.translate(-y, x+ h);
				bd.draw(img, matrix, null, null);
			}else{
				bd = new BitmapData(w,  h, true, 0);
				bd.copyPixels(img, new Rectangle(x, y, w, h), new Point());
			}
			return bd;
		}
		
		public function get path():String
		{
			return _path;
		}
	}
	
}