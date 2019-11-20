package com.cyj.app.view.common.frame
{
	import com.cyj.app.SimpleEvent;
	import com.cyj.app.ToolsApp;
	import com.cyj.app.data.FrameData;
	import com.cyj.app.view.app.AppEvent;
	import com.cyj.app.view.ui.app.FrameLineUI;
	
	import flash.display.Sprite;
	
	import morn.core.handlers.Handler;
	
	public class FrameLine extends FrameLineUI
	{
		private var _frames:Array = [];
		public static const MAX_FRAME:int = 500;//最大帧数
		private var _data:FrameData;
//		private var _isHide:Boolean = false;
		
		public function FrameLine()
		{
			super();
			this.width = Number.NaN;
			this.height = Number.NaN;
			imgBg.mouseEnabled = false;
			_frames.length = MAX_FRAME;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			btnHide.clickHandler = new Handler(handleHideClick);
			btnLock.clickHandler = new Handler(handleLockClick);
		}
		
		private function handleHideClick():void
		{
			if(!_data)return;
			_data.visible = !_data.visible;
			refushHideBtnState();
			ToolsApp.event.dispatchEvent(new SimpleEvent(AppEvent.FRAME_LINE_VISIBLE_CHANGE, _data));
		}
		
		private function refushHideBtnState():void
		{
			if(!_data)return ;
			if(!_data.visible)
			{
				btnHide.label = "显";
			}else{
				btnHide.label = "隐";
			}
		}
		
		private function handleLockClick():void
		{
			
		}
		
		override public function setSize(w:Number, h:Number):void
		{
			listFrame.width = w-listFrame.x;
			imgBg.width = w - imgBg.x;
			listFrame.repeatX = int(listFrame.width/(10+listFrame.spaceX));
			super.setSize(w, h);
		}
		
		public function get data():FrameData
		{
			return _data;
		}
		
		override public function set dataSource(value:Object):void
		{
			_frames.length = 0;
			_frames.length = MAX_FRAME;
			if(value is FrameData)
			{
				var frame:FrameData = value as FrameData;
				txtName.text = frame.name;
				var items:Array = frame.items;
				for(var i:int=0; i<items.length; i++)
				{
					_frames[i] = items[i];
				}
				_data = value as FrameData;
				listFrame.dataSource =_frames; 
			}else{
				_data = null;
				listFrame.dataSource = _frames;
			}
			for(var m:int=0; m<_frames.length; m++)//暂时这样处理
			{
				FrameItem(listFrame.getCell(m)).frameLine = this;
			}
			super.dataSource = value;
		}
	}
}