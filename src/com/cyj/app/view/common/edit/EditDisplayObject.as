package com.cyj.app.view.common.edit
{
	import com.cyj.app.view.common.Align;
	import com.cyj.app.view.unit.Avatar;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class EditDisplayObject extends Sprite
	{
		private var _target:Avatar;
		private var _editFrame:EditFrame;
		private var _align:int;
		private var _curBlock:EditBlock;
		private var _startMovePos:Point = new Point();
		private var _startRect:Rectangle = new Rectangle();
		private var _startOffsetPos:Point = new Point();
		private var _offsetPos:Point = new Point();
		
		
		public function EditDisplayObject(target:Avatar)
		{
			_target = target;
			this.x = target.x;
			this.y = target.y;
			target.x = 0;
			target.y = 0;
			this.addChild(_target);
			if(target is DisplayObjectContainer)
			{
				DisplayObjectContainer(target).mouseChildren = DisplayObjectContainer(target).mouseEnabled = false;	
			}
			if(_target is Avatar)
			{
				var avt:Avatar = _target as Avatar;
				_startOffsetPos.x = _offsetPos.x = avt.ox;
				_startOffsetPos.y = _offsetPos.y = avt.oy;
			}
			_editFrame = new EditFrame();
			this.addChild(_editFrame);
			this._editFrame.visible = false;
			 var editBlocks:Array = _editFrame.editBlocks;
			 for(var i:int=0; i<editBlocks.length; i++)
			 {
				 editBlocks[i].addEventListener(MouseEvent.MOUSE_DOWN, handleMoveEdit);
			 }
			 this.graphics.clear();
			 this.graphics.beginFill(0x00ff00, 0.5);
			 this.graphics.drawCircle(-2, -2, 4);
			 this.graphics.endFill();
		}
		
		private function handleMoveEdit(e:MouseEvent):void
		{
			var target:EditBlock = e.target as EditBlock;
			if(!target)return;
			_curBlock = target;
			_startMovePos.x = e.stageX;
			_startMovePos.y = e.stageY;
			_startRect.x = this.x;
			_startRect.y = this.y;
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
			_offsetPos.x = _target.ox;
			this.x  =  _startRect.x + (_startRect.width - w)*wAlign - ( _offsetPos.x -_startOffsetPos.x);
			//y
			temp = _offsetPos.y;
			_offsetPos.y = _target.oy;
			this.y  =  _startRect.y +(_startRect.height - h)*hAlign -( _offsetPos.y - _startOffsetPos.y);
			
			refushAlign();
		}
		
		private function handleStopBlockMove(e:MouseEvent):void
		{
			App.stage.removeEventListener(MouseEvent.MOUSE_MOVE, handleBlockMove);
			App.stage.removeEventListener(MouseEvent.MOUSE_UP, handleStopBlockMove);
		}
		
		public function start():void
		{
			this._editFrame.visible = true;
			_curBlock = null;
			this._editFrame.setSize(_target.width, _target.height);
			this.refushAlign();
		}
		
		public function end():void
		{
			this._editFrame.visible = false;
			_curBlock = null;
		}
		
		
		private function refushAlign():void
		{
			this._editFrame.x = _offsetPos.x;
			this._editFrame.y = _offsetPos.y;
		}
	}
}