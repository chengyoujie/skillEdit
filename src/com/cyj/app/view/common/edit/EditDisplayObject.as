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
		protected var _target:DisplayObject;
		protected var _editFrame:EditFrame;
		protected var _editLayer:DisplayObjectContainer;
		protected var _curBlock:EditBlock;
		
		protected var _startMovePos:Point = new Point();
		protected var _startRect:Rectangle = new Rectangle();
		protected var _startOffsetPos:Point = new Point();
		protected var _offsetPos:Point = new Point();
		
		
		public function EditDisplayObject(target:DisplayObject, editLayer:DisplayObjectContainer)
		{
			_target = target;
			_editLayer = editLayer;
			_startOffsetPos.x = _offsetPos.x = ox;
			_startOffsetPos.y = _offsetPos.y = oy;
			_editFrame = new EditFrame();
			_editLayer.addChild(_editFrame);
			this._editFrame.visible = false;
			this._editFrame.blockVisible = false;
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
			refushTargetPos();
			_startRect.x = _tempPoint.x;
			_startRect.y = _tempPoint.y;
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
			if(_target is Avatar)
				return Avatar(_target).ox;
			return 0;
		}
		private function get oy():Number
		{
			if(_target is Movie)
				return Movie(_target).framey;
			if(_target is Avatar)
				return Avatar(_target).oy;
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
			if(this._editFrame.parent)
			{
				this._editFrame.parent.removeChild(this._editFrame);
			}
			_editLayer = null;
			_target = null;
		}
		private var _tempPoint:Point = new Point();
		
		public function refushPos():void
		{
			refushTargetPos();
			this._editFrame.x = _tempPoint.x + ox;
			this._editFrame.y = _tempPoint.y + oy;
		}
		
		public function get frameX():int
		{
			return this._editFrame.x;
		}
		public function get frameY():int
		{
			return this._editFrame.y;
		}
		
		private function refushTargetPos():Point
		{
			_tempPoint.x = 0;
			_tempPoint.y = 0;
			var pos:Point = _target.localToGlobal(_tempPoint);
			pos = this._editLayer.globalToLocal(pos);
			_tempPoint.x = pos.x;
			_tempPoint.y = pos.y;
			return _tempPoint;
		}
	}
}