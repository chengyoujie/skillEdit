package com.cyj.app.view
{
	import com.cyj.app.SimpleEvent;
	import com.cyj.app.ToolsApp;
	import com.cyj.app.data.ToolsConfig;
	import com.cyj.app.view.app.FileItem;
	import com.cyj.app.view.common.Alert;
	import com.cyj.app.view.common.edit.EditDisplayObject;
	import com.cyj.app.view.ui.app.AppMainUI;
	import com.cyj.app.view.unit.Avatar;
	import com.cyj.utils.Log;
	import com.cyj.utils.cmd.CMDManager;
	import com.cyj.utils.load.ResData;
	import com.cyj.utils.load.ResLoader;
	import com.cyj.utils.md5.MD5;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.flash_proxy;
	import flash.utils.getTimer;
	
	import morn.core.handlers.Handler;
	import morn.core.managers.TipManager;
	
	import org.asmax.util.ZipWriter;
	
	public class ToolsView extends AppMainUI
	{
		
		
		public function ToolsView()
		{
			super();
			initEvent();
		}
		
//		private var ava:Avatar;
		private var _dragObj:DisplayObject;
		
		/** 初始化界面  **/		
		public function initView():void
		{
//			ava = new Avatar();
//			ava.x = 500;
//			ava.y = 300;
//			this.addChild(ava);
			
			
			leftView.refushList();
			leftView.addEventListener(FileItem.EVENT_CLICK, handleSelectChange, true);
			leftView.addEventListener(MouseEvent.MOUSE_DOWN, handleStartDrag, true);
			centerPanel.vScrollBar.touchScrollEnable = false;
			centerPanel.hScrollBar.touchScrollEnable = false;
		}
		/** 初始化事件 **/
		private function initEvent():void
		{
			
		} 
		
		
		private function handleStartDrag(e:MouseEvent):void
		{
			if(e.target is FileItem)
			{
				var fileItem:FileItem = e.target as FileItem;
				var fileItemData:Object = fileItem.dataSource;
				if(fileItemData.isDirectory)return;//点击的是文件加不做处理
				var a:Avatar =  new Avatar();
				a.path = fileItemData.path;
				_dragObj = a;
				_dragObj.x = e.stageX;
				_dragObj.y = e.stageY;
				App.stage.addChild(_dragObj);
			}else{
				return;
			}
			App.stage.addEventListener(MouseEvent.MOUSE_MOVE, handleDragMove);
			App.stage.addEventListener(MouseEvent.MOUSE_UP, handleStopDrag);
		}
		
		private function handleDragMove(e:MouseEvent):void
		{
			if(!_dragObj)return;
			_dragObj.x = e.stageX;
			_dragObj.y = e.stageY;
		}
		private function handleStopDrag(e:MouseEvent):void
		{
			if(!_dragObj)return;
			var stageX:int = e.stageX;
			var stageY:int = e.stageY;
			var rect:Rectangle = centerPanel.getBounds(App.stage);
			if(rect.contains(stageX, stageY))
			{
				var offsetRect:Rectangle = centerPanel.content.scrollRect;
				_dragObj.x = 0;
				_dragObj.y = 0;
				var edit:EditDisplayObject = new EditDisplayObject(_dragObj as Avatar);
				edit.x = stageX - rect.x + offsetRect.x;
				edit.y = stageY - rect.y+ offsetRect.y;
				centerView.addChild(edit);
				centerPanel.refresh();
			}else{
				if(_dragObj.parent)
					_dragObj.parent.removeChild(_dragObj);
			}
			_dragObj = null;
			App.stage.removeEventListener(MouseEvent.MOUSE_MOVE, handleDragMove);
			App.stage.removeEventListener(MouseEvent.MOUSE_UP, handleStopDrag);
		}
		
		private function handleSelectChange(evt:SimpleEvent):void
		{
//			if(ava && evt.data)
//			{
//				ava.path = evt.data.path;
//			}
		}
		
		
		
	}
}