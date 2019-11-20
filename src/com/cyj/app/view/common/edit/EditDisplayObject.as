package com.cyj.app.view.common.edit
{
	import com.cyj.app.view.common.Align;
	import com.cyj.app.view.unit.Avatar;
	import com.cyj.app.view.unit.Movie;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class EditDisplayObject
	{
		private var _target:DisplayObject;
		private var _editFrame:EditFrame;
		private var _editLayer:DisplayObjectContainer;
		private var _curBlock:EditBlock;
		
		private var _startMovePos:Point = new Point();
		private var _startRect:Rectangle = new Rectangle();
		private var _startOffsetPos:Point = new Point();
		private var _offsetPos:Point = new Point();
		
		
		public function EditDisplayObject(target:DisplayObject, editLayer:DisplayObjectContainer)
		{
			_target = target;
			_editLayer = editLayer;
			_startOffsetPos.x = _offsetPos.x = ox;
			_startOffsetPos.y = _offsetPos.y = oy;
			_editFrame = new EditFrame();
			_editLayer.addChild(_editFrame);
			this._editFrame.visible = false;
			 var editBlocks:Array = _editFrame.editBlocks;
			 for(var i:int=0; i<editBlocks.length; i++)
			 {
				 editBlocks[i].addEventListener(MouseEvent.MOUSE_DOWN, handleMoveEdit);
			 }
		}
		
		public function get target():DisplayObject
		{
			return _target;
		}
		
		
		private function handleMoveEdit(e:MouseEvent):void
		{
			var target:EditBlock = e.target as EditBlock;
			if(!target)return;
			_curBlock = target;
			_startMovePos.x = e.stageX;
			_startMovePos.y = e.stageY;
			_startRect.x = _target.x;
			_startRect.y = _target.y;
			_startRect.width = _target.width;
			_startRect.height = _target.height;
			_startOffsetPos.x = _offsetPos.x;
			_startOffsetPos.y = _offsetPos.y;
			App.stage.addEventListener(MouseEvent.MOUSE_MOVE, handleBlockMove);
			App.stage.addEventListener(MouseEvent.MOUSE_UP, handleStopBlockMove);
		}
		
		private function handleBlockMove(e:MouseEvent):void
		{
			if(!_curBlock)return;
			var pos:int = _curBlock.pos;
			var changeX:Number = _startMovePos.x - e.stageX;
			var changeY:Number = _startMovePos.y - e.stageY;
			var w:Number=_startRect.width;
			var h:Number = _startRect.height;
			var wAlign:int = 1;//1 表示右对齐   0表示左对齐
			var hAlign:int = 1;//1表示底部对齐    0表示顶部对齐
			if(pos & Align.LEFT)//左方向移动
			{
				w = _startRect.width+changeX;
				wAlign = 1;
			}else if(pos & Align.RIGHT){//右方向移动
				w = _startRect.width-changeX;
				wAlign = 0;
			}
			if(pos & Align.TOP)//顶部移动
			{
				h = _startRect.height+changeY;
				hAlign = 1;
			}else if(pos & Align.BOTTOM){//底部移动
				h = _startRect.height-changeY;
				hAlign = 0;
			}
			
			_editFrame.setSize(w, h);
			_target.width = w;
			_target.height = h;
			//x
			var temp:Number = _offsetPos.x;
			_offsetPos.x = ox;
			this.x  =  _startRect.x + (_startRect.width - w)*wAlign - ( _offsetPos.x -_startOffsetPos.x);
			//y
			temp = _offsetPos.y;
			_offsetPos.y = oy;
			this.y  =  _startRect.y +(_startRect.height - h)*hAlign -( _offsetPos.y - _startOffsetPos.y);
			
			refushPos();
		}
		
		public function set x(value:Number):void
		{
			_target.x = value;
			refushPos();
		}
		public function get x():Number
		{
			return _target.x;
		}
		
		public function set y(value:Number):void
		{
			_target.y = value;
			refushPos();
		}
		public function get y():Number
		{
			return _target.y;
		}
		
		private function get ox():Number
		{
			if(_target is Movie)
				return Movie(_target).framex;
			return 0;
		}
		private function get oy():Number
		{
			if(_target is Movie)
				return Movie(_target).framey;
			return 0;
		}
		
		private function handleStopBlockMove(e:MouseEvent):void
		{
			App.stage.removeEventListener(MouseEvent.MOUSE_MOVE, handleBlockMove);
			App.stage.removeEventListener(MouseEvent.MOUSE_UP, handleStopBlockMove);
		}
		
		public function start():void
		{
			if(_target.width==0 ||  _target.height==0)
			{
				this.end();
				return;
			}
			this._editFrame.visible = true;
			_curBlock = null;
			this._editFrame.setSize(_target.width, _target.height);
			this.refushPos();
		}
		
		public function end():void
		{
			this._editFrame.visible = false;
			_curBlock = null;
		}
		
		public function dispose():void
		{
			end();
		}
		
		public function refushPos():void
		{
			this._editFrame.x = _target.x + ox;
			this._editFrame.y = _target.y + oy;
		}
	}
}