package com.cyj.app.view.unit
{
	import com.cyj.app.SimpleEvent;
	import com.cyj.app.ToolsApp;
	import com.cyj.app.view.common.edit.EditBlock;
	import com.cyj.app.view.common.edit.EditDisplayObject;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	public class EditObject extends Sprite
	{
		private var _edits:Array = [];
		private var _startMovePos:Point = new Point();
		private var _editLayer:Sprite = new Sprite();
		private var _avtLayer:Sprite = new Sprite();
		private var _editDic:Dictionary = new Dictionary();
		
		public function EditObject()
		{
			super();
			this.addChild(_avtLayer);
			this.addChild(this._editLayer);//添加编辑层
			this.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
		}
		
		public function addEditObj(obj:DisplayObject):EditDisplayObject
		{
			_avtLayer.addChild(obj);
			var edit:EditDisplayObject = new EditDisplayObject(obj, _editLayer);
			_editDic[obj] = edit;
			return edit;
		}
		
		public function removeEditObj(obj:DisplayObject):EditDisplayObject
		{
			var edit:EditDisplayObject  = _editDic[obj];
			if(edit)
			{
				var index:int = _edits.indexOf(edit);
				if(index!=-1)
				{
					_edits.splice(index, 1);
				}
				edit.dispose();
				delete _editDic[obj];
			}
			if(_avtLayer.contains(obj))
			{
				_avtLayer.removeChild(obj);
			}
			return edit;
		}
		
		//		public function get editLayer():Sprite
		//		{
		//			return _editLayer;
		//		}
		
		private function handleMouseDown(e:MouseEvent):void
		{
			if(e.target is EditBlock)return;
			var target:EditDisplayObject = _editDic[e.target] as EditDisplayObject;
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