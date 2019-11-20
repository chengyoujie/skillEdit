package com.cyj.app.view.app
{
	import com.cyj.app.SimpleEvent;
	import com.cyj.app.ToolsApp;
	import com.cyj.app.data.FrameData;
	import com.cyj.app.data.FrameItemData;
	import com.cyj.app.view.common.edit.EditBlock;
	import com.cyj.app.view.common.edit.EditDisplayObject;
	import com.cyj.app.view.common.frame.FrameLine;
	import com.cyj.app.view.ui.app.CenterViewUI;
	import com.cyj.app.view.unit.AvaterRes;
	import com.cyj.app.view.unit.Movie;
	import com.cyj.app.view.unit.MoviePlay;
	import com.cyj.app.view.unit.SubImageInfo;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	public class CenterView extends CenterViewUI
	{
		
		private var _res:AvaterRes;
		private var _centerPos:Point;
		private var _moviePlay:MoviePlay;
		private var _frame:int;
		private var _movieContain:Sprite;
		private var _editContain:Sprite;
		private var _editDic:Dictionary = new Dictionary();
		private var _curEdit:EditDisplayObject;
		private var _moveOffPos:Point = new Point();
		private var _curDragObj:DisplayObject;
		
		
		public function CenterView()
		{
			super();
			this._width = Number.NaN;
			this._height = Number.NaN;
			_movieContain = new Sprite();
			this.addChild(_movieContain);
			_editContain = new Sprite();
			this.addChild(_editContain);
			
			_centerPos = new Point();
			_moviePlay = new MoviePlay(_movieContain);
			ToolsApp.event.addEventListener(AppEvent.FRAME_CHANGE, handleFrameChange);
			ToolsApp.event.addEventListener(AppEvent.ADD_LAYER, handleAddLayer);
			ToolsApp.event.addEventListener(AppEvent.REMOVE_LAYER, handleRemoveLayer);
			ToolsApp.event.addEventListener(AppEvent.FRAME_LINE_VISIBLE_CHANGE, handleFrameLineVisibleChange);
			this.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
		}
		
		private function handleFrameChange(e:SimpleEvent):void
		{
			var frame:int = e.data as int;
			_moviePlay.gotoAndStop(frame);
			if(_curEdit)
				_curEdit.start();
		}
		
		public function editAvater(avaterRes:AvaterRes, centerX:int=-1, centerY:int=-1):void
		{
			if(_curEdit)
			{
				_curEdit.dispose();
				_curEdit = null;
			}
			_centerPos.x = centerX==-1?this.width/2:centerX;
			_centerPos.y = centerY == -1?this.height/2:centerY;
			this.graphics.clear();
			this.graphics.lineStyle(1, 0xff0000);
			this.graphics.moveTo(_centerPos.x - 20, _centerPos.y);
			this.graphics.lineTo(_centerPos.x + 20, _centerPos.y);
			this.graphics.moveTo(_centerPos.x , _centerPos.y- 20);
			this.graphics.lineTo(_centerPos.x , _centerPos.y+ 20);
			this.graphics.endFill();
			_res = avaterRes;
			_moviePlay.avaterRes = _res;
			_moviePlay.setPos(_centerPos.x, _centerPos.y);
		}
		
		public function get centerPos():Point
		{
			return _centerPos;
		}
		
		private function handleMouseDown(e:MouseEvent):void
		{
			var movie:Movie = e.target as Movie;
			if(!movie)return;
			_curDragObj = movie;
			var edit:EditDisplayObject  = _editDic[movie];
			if(!edit)
			{
				edit = _editDic[movie] = new EditDisplayObject(movie, _editContain);
			}
			edit.start();
			_curEdit = edit;
			_moveOffPos.x = e.stageX;
			_moveOffPos.y = e.stageY;
			App.stage.addEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
			App.stage.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
		}
		
		private function handleMouseMove(e:MouseEvent):void
		{
			if(!_curDragObj)return;
			var movie:Movie = _curDragObj as Movie;
			if(movie)
			{
				var frameItemData:FrameItemData = movie.getCurFrameData();
				if(frameItemData)
				{
					frameItemData.x += e.stageX - _moveOffPos.x;
					frameItemData.y += e.stageY - _moveOffPos.y;
					movie.handleRender();
					var edit:EditDisplayObject  = _editDic[movie];
					if(edit)
						edit.refushPos();
				}
			}
			_moveOffPos.x = e.stageX;
			_moveOffPos.y = e.stageY;
		}
		
		private function handleMouseUp(e:MouseEvent):void
		{
			App.stage.removeEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
			App.stage.removeEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
			if(!_curDragObj)return;
		}
		
		private function handleAddLayer(e:SimpleEvent):void
		{
			if(!_res || !_res.isReady)return;
//			var layer:FrameLine = e.data as FrameLine;
//			var frame:FrameData = layer.data;
			var frame:FrameData = e.data as FrameData;
			var index:int = _res.data.frames.indexOf(frame);
			var movie:Movie = new Movie(frame, _res.subImageInfos);
			_moviePlay.addMovie(movie, index);
		}
		
		private function handleRemoveLayer(e:SimpleEvent):void
		{
			if(!_res || !_res.isReady)return;
//			var layer:FrameLine = e.data as FrameLine;
//			var frame:FrameData = layer.data;
			var frame:FrameData = e.data as FrameData;
			_moviePlay.removeMovieByData(frame);
			
		}
		
		private function handleFrameLineVisibleChange(e:SimpleEvent):void
		{
			if(!_res || !_res.isReady)return;
//			var frame:FrameData = e.data as FrameData;
			if(_curEdit)
			{
				var movie:Movie = _curEdit.target as Movie;
				if(movie)
				{
					if(!movie.frameData.visible)
					{
						_curEdit.end();
						_curEdit = null;
					}
				}
			}
			_moviePlay.setMovieVisible();
		}
		
		
	}
}