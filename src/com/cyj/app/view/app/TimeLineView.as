package com.cyj.app.view.app
{
	import com.cyj.app.SimpleEvent;
	import com.cyj.app.ToolsApp;
	import com.cyj.app.data.FrameData;
	import com.cyj.app.data.FrameItemData;
	import com.cyj.app.utils.BindData;
	import com.cyj.app.view.common.Alert;
	import com.cyj.app.view.common.frame.FrameItem;
	import com.cyj.app.view.common.frame.FrameLine;
	import com.cyj.app.view.ui.app.TimeLineUI;
	import com.cyj.app.view.unit.Avatar;
	import com.cyj.app.view.unit.AvaterRes;
	import com.cyj.app.view.unit.SubImageInfo;
	
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import morn.core.handlers.Handler;
	
	public class TimeLineView extends TimeLineUI
	{
		private var _isPlay:Boolean = false;
		private var _curFrame:int =0;
		private var _selectFrames:Vector.<FrameItem> = new Vector.<FrameItem>();
		
		private var _res:AvaterRes;
		private var _bindDataDic:Dictionary = new Dictionary();
		public function TimeLineView()
		{
			super();
//			addFrameLine();
			panelFrameLine.hScrollBar.touchScrollEnable = false;
			panelFrameLine.vScrollBar.touchScrollEnable = false;
			listFrameLine.addEventListener(MouseEvent.MOUSE_DOWN, handleClickList);
			btnPlay.clickHandler = new Handler(handlePlayStop);
			_bindDataDic[inputSpeed] = new BindData(inputSpeed, "speed", "text");
			_bindDataDic[inputFrame] = new BindData(inputFrame, null, "text", handleFrameChange);
			btnAddLayer.clickHandler = new Handler(handleAddLayer);
			btnRemoveLayer.clickHandler = new Handler(handleRemoveLayer);
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
			listFrameLine.dataSource = _res.data.frames;
			inputSpeed.text = _res.data.speed+"";
			inputFrame.text = _curFrame+"";
			txtAvtName.text = _res.path.substring(_res.path.lastIndexOf("\\")+1);
			txtResPath.text = _res.path;
			BindData(_bindDataDic[inputSpeed]).bind(_res.data);
			BindData(_bindDataDic[inputFrame]).bind({});
			onResize();
		}
		
		private function handleFrameChange():void
		{
			setFrame(int(inputFrame.text));
		}
		
		private function handleAddLayer():FrameLine
		{
			if(!_res || !_res.isReady)return null;
			var frame:FrameData = _res.data.addFrameData();
			listFrameLine.dataSource = _res.data.frames;
			App.render.renderAll();
			var layer:FrameLine = listFrameLine.getCell(_res.data.frames.length-1) as FrameLine;
			ToolsApp.event.dispatchEvent(new SimpleEvent(AppEvent.ADD_LAYER, frame));
			return layer;
		}
		private function handleRemoveLayer():void
		{
			if(!_res || !_res.isReady)return;
			var data:FrameData = listFrameLine.selectedItem as FrameData;
			if(data)
					removeLayer(data);
		}
		
		private function removeLayer(frame:FrameData):void
		{
			if(!_res || !_res.isReady)return;
//			var index:int = _res.data.frames.indexOf(frame);
			 _res.data.removeFrameData(frame);
//			 var layer:FrameLine = listFrameLine.getCell(index) as FrameLine;
			 ToolsApp.event.dispatchEvent(new SimpleEvent(AppEvent.REMOVE_LAYER, frame));
			listFrameLine.dataSource = _res.data.frames;
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
			_curFrame ++;
			setFrame(_curFrame %_res.data.maxFrame);
			_renderTime = getTimer() + 1000/_res.data.speed;
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
		
		private function setFrame(frame:int, selectLine:Boolean =true):void
		{
			var arr:Array = listFrameLine.array;
			if(!arr)return;
			_curFrame =frame;
			var gap:int = 0;
			var w:int = 0;
			var startx:int = 125;
			var item:FrameItem;
			if(selectLine)
				clearSelected();
			for(var i:int=0; i<arr.length; i++)
			{
				var line:FrameLine = listFrameLine.getCell(i) as FrameLine;
				if(gap == 0)
				{
					gap = line.listFrame.spaceX;
					startx = line.listFrame.x;
				}
				item = line.listFrame.getCell(frame) as FrameItem;
				
				if(item)
				{
					if(selectLine)
						addSelect(item);
					if(w == 0) w = item.width;
				}
			}
			inputFrame.text = _curFrame+"";
			boxFrameTop.x = startx;
			arrow.x = ((w+gap)*_curFrame)+ w/2 - arrow.width/2;
			ToolsApp.event.dispatchEvent(new SimpleEvent(AppEvent.FRAME_CHANGE, _curFrame));
		}
		 
		private function handleClickList(e:MouseEvent):void
		{
			var frame:FrameItem = e.target as FrameItem;
			if(!frame)return;
			setFrame(frame.index, false);
			clearSelected();
			addSelect(frame);
		}
		
		private function clearSelected():void
		{
			for(var i:int=0; i<_selectFrames.length; i++)
			{
				if(_selectFrames[i])
					_selectFrames[i].select = false;
			}
			_selectFrames.length = 0;
		}
		
		private function addSelect(item:FrameItem):void
		{
			_selectFrames.push(item);
			item.select = true;
		}
		
		private var _lastImage:Object;
		public function addImage(img:SubImageInfo, x:int=0, y:int=0):void
		{
			if(_selectFrames.length == 0)
			{
				_lastImage ={img:img, x:x, y:y};
				Alert.show("当前没有选择要插入的空帧, 是否新建图层", "提示", 	Alert.ALERT_OK_CANCLE, handleAlert, "新建图层", "替换"); 
			}
			var item:FrameItem;
			for(var i:int=0; i<_selectFrames.length; i++)
			{
				if(!_selectFrames[i].dataSource)
				{	
					item = _selectFrames[i];
					break;
				}
			}
			if(item)
			{
				addFrameItem(item.frameLine, item.index, img, x, y);
			}else{
				_lastImage ={img:img, x:x, y:y};
				Alert.show("当前没有可以添加的空帧, 是否新建图层", "提示", 	Alert.ALERT_OK_CANCLE, handleAlert,  "新建图层", "替换"); 
			}
		}
		
		
		private function handleAlert(del:int):void
		{
			var item:FrameItem;
			if(del == Alert.ALERT_OK)
			{
				var layer:FrameLine = handleAddLayer();
				if(!layer)return;
				var index:int = 0;
				if(_selectFrames.length>0)
				{
					item = _selectFrames[0];
					index = item.index;
				}
				if(_lastImage)
				{
					addFrameItem(layer, 0, _lastImage.img, _lastImage.x, _lastImage.y);
				}
			}else if(del == Alert.ALERT_CANCLE){
				if(_selectFrames.length>0)
					item = _selectFrames[0];
				if(item)
				{
					addFrameItem(item.frameLine, item.index, _lastImage.img, _lastImage.x, _lastImage.y);
				}
			}
			_lastImage = null;
		}
		
		/**添加某一帧**/
		private function addFrameItem(layer:FrameLine, index:int, subImg:SubImageInfo, x:int=0, y:int=0):void
		{
			var data:FrameData = layer.dataSource as FrameData;
			var frame:FrameItemData = data.addFrameItemBySubInfo(subImg, index);
			frame.x = x;
			frame.y = y;
			layer.dataSource = data;
			ToolsApp.event.dispatchEvent(new SimpleEvent(AppEvent.FRAME_CHANGE, _curFrame));//重新刷新下当前帧
		}
		
	}
}