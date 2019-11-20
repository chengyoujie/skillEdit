package com.cyj.app.view.unit
{
	import com.cyj.app.ToolsApp;
	import com.cyj.app.data.FrameData;
	import com.cyj.app.data.FrameItemData;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	public class Movie extends Sprite
	{
		private var bmp:Bitmap;
		private var _path:String;
//		private var _w:Number;
//		private var _h:Number;
		private var _sx:Number=1;
		private var _sy:Number=1;
		private var _frameData:FrameData;
		private var _subImageInfos:Object;
		
		public function Movie(framedata:FrameData=null, subImageInfos:Object=null)
		{
			super();
			this.mouseChildren = false;
			_subImageInfos = subImageInfos;
			bmp = new Bitmap();
			this.addChild(bmp);
			if(framedata)
				frameData = framedata;
		}
		
		public function set frameData(data:FrameData):void
		{
//			_w = Number.NaN;
//			_h = Number.NaN;
			_sx = 1;
			_sy = 1;	
			_frameData = data;
		}
		
		public function get frameData():FrameData
		{
			return _frameData;
		}
		
		
		public function gotoAndStop(index:int):void
		{
			if(index<0)index = 0;
			_frame = index;
			handleRender();
		}
		
		public function render():void
		{
			handleRender();
			
			if(_frameData&&_frame>=_frameData.items.length)_frame = 0;
			_frame ++;
		}
		 
		private var _frame:int = 0;
		public function handleRender():void
		{
			if(_frameData && _subImageInfos)
			{
				var frameData:FrameItemData = _frameData.items[_frame];
				if(!frameData)
				{
					bmp.bitmapData = null;
					return;
				}
				var sub:SubImageInfo = _subImageInfos[frameData.res];
				if(sub)
				{
					bmp.bitmapData = sub.img; 
				}else{
					bmp.bitmapData = null;
				}
				bmp.x = frameData.x + frameData.ox;
				bmp.y =  frameData.y + frameData.oy;
				bmp.width = frameData.w;
				bmp.height = frameData.h;
			}else{
				bmp.bitmapData = null;
			}
		}
		
		public function getCurFrameData():FrameItemData
		{
			if(_frameData && _frameData.items)
			{
				if(_frame<0||_frame>=_frameData.items.length)return null;
				return _frameData.items[_frame];
			}
			return null;
		}
		
		override public function get width():Number
		{
			var frame:FrameItemData = getCurFrameData();
			if(frame)
				return frame.w;
			return super.width;
		}
		
		override public function get height():Number
		{
			var frame:FrameItemData = getCurFrameData();
			if(frame)
				return frame.h;
			return super.height;
		}
		
		override public function set width(value:Number):void
		{
			var frame:FrameItemData = getCurFrameData();
			if(!frame)return;
			frame.w = value;
			bmp.width = value;
		}
		
		override public function set height(value:Number):void
		{
			var frame:FrameItemData = getCurFrameData();
			if(!frame)return;
			frame.h= value;
			bmp.height = value;
		}
		
//		override public function get scaleX():Number
//		{
//			return _sx;
//		}
//		override public function get scaleY():Number
//		{
//			return _sy;
//		}
		
		public function get ox():int
		{
			return _frameData.ox;
		}
		public function get oy():int
		{
			return _frameData.oy;
		}
		
		public function get framey():int
		{
			var frame:FrameItemData = getCurFrameData();
			if(!frame)return 0;
			return frame.oy+frame.y;
		}
		public function get framex():int
		{
			var frame:FrameItemData = getCurFrameData();
			if(!frame)return 0;
			return frame.ox+frame.x;
		}
		
	}
}