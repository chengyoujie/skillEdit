package com.cyj.app.view.app
{
	import com.cyj.app.SimpleEvent;
	import com.cyj.app.ToolsApp;
	import com.cyj.app.view.common.frame.FrameItem;
	import com.cyj.app.view.common.frame.FrameLine;
	import com.cyj.app.view.ui.app.TimeLineUI;
	import com.cyj.app.view.unit.Avatar;
	import com.cyj.app.view.unit.AvaterRes;
	
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	
	import morn.core.handlers.Handler;
	
	public class TimeLineView extends TimeLineUI
	{
		private var _isPlay:Boolean = false;
		private var _curFrame:int =0;
		
		private var _res:AvaterRes;
		
		public function TimeLineView()
		{
			super();
//			addFrameLine();
			listFrameLine.addEventListener(MouseEvent.MOUSE_DOWN, handleClickList);
			btnPlay.clickHandler = new Handler(handlePlayStop);
		}
		
		public function editAvater(res:AvaterRes):void
		{
			_res = res;
			if(!_res)return;
			if(_res.isReady)
			{
				initAvaterRes();
				ToolsApp.event.removeEventListener(AppEvent.AVATER_RES_COMPLETE, handleResComplete);
			}else{
				ToolsApp.event.addEventListener(AppEvent.AVATER_RES_COMPLETE, handleResComplete);
			}
		}
		
		private function handleResComplete(e:SimpleEvent):void
		{
			if(_res != e.data)return;
			if(_res.isReady)
			{
				initAvaterRes();
				ToolsApp.event.removeEventListener(AppEvent.AVATER_RES_COMPLETE, handleResComplete);
			}
		}
		
		private function initAvaterRes():void
		{
			if(!_res || !_res.isReady)return;
			listFrameLine.dataSource = _res.getFrames();
			onResize();
		}
		
		
		private function handlePlayStop():void
		{
			_isPlay = !_isPlay;
			refushPlayStop();
		}
		private function refushPlayStop():void{
			if(_isPlay)
			{
				btnPlay.label = "||";
				App.timer.doFrameLoop(1, handleRender);
			}else{
				btnPlay.label = "|>";
				App.timer.clearTimer( handleRender);
			}
		}
		
		private var _renderTime:int = 0;
		private function handleRender():void
		{
			if(!_res || !_res.isReady)return;
			if(getTimer()<_renderTime)return;
			_curFrame %= _res.maxFrame;
			_renderTime = getTimer() + 1000/_res.data.speed;
			ToolsApp.event.dispatchEvent(new SimpleEvent(AppEvent.FRAME_CHANGE, _curFrame));
			_curFrame ++;
		}
		
		public function onResize():void{
			var arr:Array = listFrameLine.array;
			if(!arr)return;
			for(var i:int=0; i<arr.length; i++)
			{
				var line:FrameLine = listFrameLine.getCell(i) as FrameLine;
				line.setSize(this.width, 35);
			}
		}
		
		private var _lastFrame:FrameItem;
		private function handleClickList(e:MouseEvent):void
		{
			var frame:FrameItem = e.target as FrameItem;
			if(!frame)return;
			if(_lastFrame)
					_lastFrame.select = false;
			_lastFrame = frame;
			_lastFrame.select = true;
			_curFrame = frame.index;
			arrow.x = frame.x + frame.width/2 - arrow.width/2;
			ToolsApp.event.dispatchEvent(new SimpleEvent(AppEvent.FRAME_CHANGE, _curFrame));
		}
		
//		public function addFrameLine():void
//		{
//			_frameLines.push([1, 2, 3, 4]);
//			_frameLines.push([1, 2, 3, 4]);
//			_frameLines.push([1, 2, 3, 4]);
//			listFrameLine.dataSource = _frameLines;
//			onResize();
//		}
		
	}
}