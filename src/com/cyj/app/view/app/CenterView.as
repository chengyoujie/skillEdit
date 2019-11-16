package com.cyj.app.view.app
{
	import com.cyj.app.SimpleEvent;
	import com.cyj.app.ToolsApp;
	import com.cyj.app.data.FrameData;
	import com.cyj.app.view.common.edit.EditBlock;
	import com.cyj.app.view.common.edit.EditDisplayObject;
	import com.cyj.app.view.ui.app.CenterViewUI;
	import com.cyj.app.view.unit.AvaterRes;
	import com.cyj.app.view.unit.Movie;
	import com.cyj.app.view.unit.MoviePlay;
	
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
		
		private function handleMouseDown(e:MouseEvent):void
		{
			var movie:Movie = e.target as Movie;
			if(!movie)return;
			var edit:EditDisplayObject  = _editDic[movie];
			if(!edit)
			{
				edit = _editDic[movie] = new EditDisplayObject(movie, _editContain);
			}
			edit.start();
			_curEdit = edit;
		}
		
		
		
	}
}