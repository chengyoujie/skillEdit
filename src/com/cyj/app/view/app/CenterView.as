package com.cyj.app.view.app
{
	import com.cyj.app.view.common.edit.EditBlock;
	import com.cyj.app.view.common.edit.EditDisplayObject;
	import com.cyj.app.view.ui.app.CenterViewUI;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class CenterView extends CenterViewUI
	{
		private var _edits:Array = [];
		private var _startMovePos:Point = new Point();
		
		public function CenterView()
		{
			super();
			this.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
			this._width = Number.NaN;
			this._height = Number.NaN;
		}
		
		private function handleMouseDown(e:MouseEvent):void
		{
			if(e.target is EditBlock)return;
			var target:EditDisplayObject = e.target as EditDisplayObject;
			removeEdits();
			if(target)
			{
				addEdits(target);
			}
			_startMovePos.x = e.stageX;
			_startMovePos.y = e.stageY;
			App.stage.addEventListener(MouseEvent.MOUSE_MOVE, handleEditMove, false, 10000);
			App.stage.addEventListener(MouseEvent.MOUSE_UP, handleStopDrage);
		}
		
		public function addEdits(edit:EditDisplayObject):void
		{
			edit.start();
			_edits.push(edit);
		}
		
		private function handleStopDrage(e:MouseEvent):void
		{
			App.stage.removeEventListener(MouseEvent.MOUSE_MOVE, handleEditMove);
			App.stage.removeEventListener(MouseEvent.MOUSE_UP, handleStopDrage);
		}
		private function handleEditMove(e:MouseEvent):void
		{
			var offsetX:int = e.stageX - _startMovePos.x;
			var offsetY:int = e.stageY - _startMovePos.y;
			for(var i:int=0; i<_edits.length; i++)
			{
				var edit:EditDisplayObject = _edits[i];
				edit.x += offsetX;
				edit.y += offsetY;
			}
			_startMovePos.x = e.stageX;
			_startMovePos.y = e.stageY;
			e.stopImmediatePropagation();
		}
		
		public function removeEdits():void
		{
			for(var i:int=0; i<_edits.length; i++)
			{
				var edit:EditDisplayObject = _edits[i];
				edit.end();
			}
			_edits.length = 0;
		}
		
	}
}