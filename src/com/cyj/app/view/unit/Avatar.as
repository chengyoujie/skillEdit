package com.cyj.app.view.unit
{
	import com.cyj.app.SimpleEvent;
	import com.cyj.app.ToolsApp;
	import com.cyj.app.data.FrameData;
	import com.cyj.app.view.app.AppEvent;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	public class Avatar extends Sprite
	{
		private var _res:AvaterRes;
//		private var bmp:Bitmap;
		private var _path:String;
//		private var _w:Number;
//		private var _h:Number;
//		private var _sx:Number=1;
//		private var _sy:Number=1;
		private var _frame:int = 0;
		private var _moviePlay:MoviePlay;
		
		public function Avatar($path:String)
		{
			super();
//			this.addEventListener(Event.ADDED_TO_STAGE, handleAddStage);
//			this.addEventListener(Event.REMOVED_FROM_STAGE, handleRemoveStage);
			this.graphics.clear();
			this.graphics.beginFill(0xff0000, 0.5);
			this.graphics.drawCircle(-2, -2, 4);
			this.graphics.endFill();
			_moviePlay = new MoviePlay(this);
			path = $path;
		} 
		
		public function set path(value:String):void
		{
			if(_path == value)return;
			_path = value;
			_res = AvaterRes.get(value);
			_moviePlay.avaterRes = _res;
			App.timer.doFrameLoop(1,  handleRender);
		}
		
		private var _curFrame:int = 0;
		private var _renderTime:int = 0;
		private function handleRender():void
		{
			if(!_res.isReady)return;
			if(_moviePlay)
			{
				if(getTimer()<_renderTime)return;
				if(_curFrame>=_res.maxFrame)_curFrame = 0;
				_renderTime = getTimer() + 1000/_res.data.speed;
				_moviePlay.gotoAndStop(_curFrame);
				_curFrame ++;
			}
		}
		
		public function get path():String
		{
			return _path;
		}

		public function get avaterRes():AvaterRes
		{
			return _res;
		}
		
		public  function dispose():void
		{
			if(this.parent)
				this.parent.removeChild(this);
			_moviePlay.dispose();
			_moviePlay = null;
			App.timer.clearTimer( handleRender);
		}
	}
}