package com.cyj.app.view.unit
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	public class Avatar extends Sprite
	{
		private var res:AvaterRes;
		private var bmp:Bitmap;
		private var _path:String;
		private var _w:Number;
		private var _h:Number;
		private var _sx:Number=1;
		private var _sy:Number=1;
		
		public function Avatar()
		{
			super();
			//test
			bmp = new Bitmap();
			this.addChild(bmp);
			this.addEventListener(Event.ADDED_TO_STAGE, handleAddStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, handleRemoveStage);
			this.graphics.clear();
			this.graphics.beginFill(0xff0000, 0.5);
			this.graphics.drawCircle(-2, -2, 4);
			this.graphics.endFill();
		}
		
		private function handleAddStage(e:Event):void
		{
			App.timer.doFrameLoop(1, handleRender);
		}
		private function handleRemoveStage(e:Event):void
		{
			App.timer.clearTimer( handleRender);
		}
		
		public function set path(value:String):void
		{
			_path = value;
			_w = Number.NaN;
			_h = Number.NaN;
			_sx = 1;
			_sy = 1;
			res = new AvaterRes(value);
		}
		
		public function get path():String
		{
			return _path;
		}
		
		private var _frame:int = 1;
		private var _renderTime:int = 0;
		private function handleRender():void
		{
			if(res && res.isReady)
			{
				if(getTimer()<_renderTime)return;
				if(_frame>=res.maxFrame)_frame = 1;
				var frameData:FrameData = res.frameData[_frame];
				if(!frameData)return;
				bmp.bitmapData = frameData.img;
				bmp.x = frameData.ox*_sx;
				bmp.y = frameData.oy*_sy;
				_frame ++;
				_renderTime = getTimer() + 1000/res.data.speed;
			}
		}
		
		override public function get width():Number
		{
			if(!isNaN(_w))return _w;
			return res.width*_sx;
		}
		
		override public function get height():Number
		{
			if(!isNaN(_h))return _h;
			return res.height*_sy;
		}
		
		override public function set width(value:Number):void
		{
			_w = value;	
			bmp.scaleX = _sx = value/res.width;
		}
		
		override public function set height(value:Number):void
		{
			_h = value;	
			bmp.scaleY = _sy = value/res.height;
		}
		
		override public function get scaleX():Number
		{
			return _sx;
		}
		override public function get scaleY():Number
		{
			return _sy;
		}
		
//		public function get ow():Number
//		{
//			return res.width;
//		}
//		
//		public function get oh():Number
//		{
//			return res.height;
//		}
		public function get oy():int
		{
			return res.oy*scaleY;
		}
		public function get ox():int
		{
			return res.ox*scaleX;
		}
		
		public  function distory():void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, handleAddStage);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, handleRemoveStage);
		}
	}
}