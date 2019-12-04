package com.cyj.app.view
{
	import com.cyj.app.SimpleEvent;
	import com.cyj.app.ToolsApp;
	import com.cyj.app.data.AvaterData;
	import com.cyj.app.data.ToolsConfig;
	import com.cyj.app.data.cost.Action;
	import com.cyj.app.data.cost.Direction;
	import com.cyj.app.data.cost.ResType;
	import com.cyj.app.utils.ComUtill;
	import com.cyj.app.view.app.AppEvent;
	import com.cyj.app.view.app.EffectItem;
	import com.cyj.app.view.app.FileItem;
	import com.cyj.app.view.app.SettingView;
	import com.cyj.app.view.app.effect.EffectPlayer;
	import com.cyj.app.view.common.Alert;
	import com.cyj.app.view.common.TipMsg;
	import com.cyj.app.view.common.edit.EditDisplayObject;
	import com.cyj.app.view.ui.app.AppMainUI;
	import com.cyj.app.view.unit.Avatar;
	import com.cyj.app.view.unit.DragImage;
	import com.cyj.app.view.unit.Effect;
	import com.cyj.app.view.unit.Role;
	import com.cyj.app.view.unit.SubImageInfo;
	import com.cyj.utils.Log;
	import com.cyj.utils.cmd.CMDManager;
	import com.cyj.utils.load.ResData;
	import com.cyj.utils.load.ResLoader;
	import com.cyj.utils.md5.MD5;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.flash_proxy;
	import flash.utils.getTimer;
	
	import morn.core.handlers.Handler;
	import morn.core.managers.TipManager;
	
	import org.asmax.util.ZipWriter;
	
	public class ToolsView extends AppMainUI
	{
		private var _settingView:SettingView;
		 
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
			ToolsApp.effectPlayer = new EffectPlayer(centerView);
			leftView.initView();
			centerView.initView();
			rightView.initView();
			leftView.addEventListener(FileItem.EVENT_CLICK, handleSelectChange, true);
			leftView.addEventListener(MouseEvent.MOUSE_DOWN, handleStartDrag, true);
			centerPanel.vScrollBar.touchScrollEnable = false;
			centerPanel.hScrollBar.touchScrollEnable = false;
			btnSetting.clickHandler = new Handler(handleOpenSettingView);
			App.stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			SimpleEvent.on(AppEvent.LOCAL_CONFIG_CHANGE, loadConfigZzp);
			loadConfigZzp();
			appName.text = ToolsApp.config.appName;
		}
		
		public function initProject():void
		{
			leftView.initProject();
			rightView.initProject();
			centerView.initProject();
		}
		/** 初始化事件 **/
		private function initEvent():void
		{
			
		} 
		
		
		
		private function handleZzpLoaded(res:ResData):void
		{
			var byte:ByteArray = res.data as ByteArray;
			byte.uncompress();
			var allLen:int = byte.readShort();
			var zzp:Object = {};
			for(var i:int=0; i<allLen; i++)
			{
				var name:String = byte.readUTF();
				var key:String = byte.readUTF();
				var obj:Object = byte.readObject();
				zzp[name] = obj.unit;
			}
			ToolsApp.projectData.config = zzp;
			initProject();
		}
		
		
		private function loadConfigZzp(e:Event=null):void
		{
			Log.log("开始加载config.zzp");
			var configPath:String = ToolsApp.localCfg.localWebPath+"/resource/config/config.zzp";
			configPath = ComUtill.commonPath(configPath);
			var file:File = new File(configPath);
			if(file.exists)
			{
				ToolsApp.loader.loadSingleRes(configPath, ResLoader.BYT, handleZzpLoaded, null, loadConfigError);	
			}else{
				if(ToolsApp.localCfg.localWebPath)
						TipMsg.show("当前的Web路径不对"+ToolsApp.localCfg.localWebPath);
				handleOpenSettingView();
			}
		}
		
		private function loadConfigError(res:ResData, msg:String):void
		{
			TipMsg.show("加载配置错误， 请检查web路径是否正确"+ToolsApp.localCfg.localWebPath);
		}
		
		
		private function handleStartDrag(e:MouseEvent):void
		{
			if(e.target is FileItem)
			{
				var fileItem:FileItem = e.target as FileItem;
				var fileItemData:Object = fileItem.dataSource;
				if(fileItemData.isDirectory)return;//点击的是文件加不做处理
				if(fileItemData.type == ResType.IMAGE)
				{
					var img:DragImage = new DragImage();
					img.path = fileItemData.path;
					_dragObj = img;
					_dragObj.x = e.stageX;
					_dragObj.y = e.stageY;
					App.stage.addChild(_dragObj);
				}else{
					var a:Avatar;
					if(fileItemData.type == ResType.ROLE)
					{
						a =  new Role(new AvaterData(fileItemData.path, true));
					}else{
						a =  new Effect(new AvaterData(fileItemData.path, fileItemData.type!=ResType.EFFECT));
					}
					_dragObj = a;
					_dragObj.x = e.stageX;
					_dragObj.y = e.stageY;
					App.stage.addChild(_dragObj);
					ToolsApp.event.dispatchEvent(new SimpleEvent(AppEvent.CHANGE_AVATER, a));
				}
			}else{
				return;
			} 
			App.stage.addEventListener(MouseEvent.MOUSE_MOVE, handleDragMove);
			App.stage.addEventListener(MouseEvent.MOUSE_UP, handleStopDrag);
		}
		
		private function handleKeyDown(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.DELETE)
			{
				centerView.doDelete();
			}else if(e.keyCode == Keyboard.S && e.ctrlKey)
			{
				ToolsApp.saveConfig();
			}
		}
		
		private function handleDragMove(e:MouseEvent):void
		{
			if(!_dragObj)return;
			_dragObj.x  = e.stageX ;
			_dragObj.y  = e.stageY ;
			centerView.onAddAvtMouseMove(_dragObj.x, _dragObj.y);
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
				var ox:int = stageX - rect.x + offsetRect.x;
				var oy:int = stageY - rect.y+ offsetRect.y;
				var dropRole:Role = centerView.getAddAvtRole(stageX, stageY);
				if(_dragObj.parent)
					_dragObj.parent.removeChild(_dragObj);
//				var edit:EditDisplayObject = centerView.addEditObj(_dragObj);//new EditDisplayObject(_dragObj as Avatar, centerView.editLayer);
				if(_dragObj is Avatar)
				{
					var avt:Avatar = _dragObj as Avatar;
					avt.x = ox;
					avt.y = oy;
					centerView.addAvatar(avt, null, dropRole);
//					ToolsApp.projectData.avaterRes = avt.avaterRes;
//					centerView.editAvater(avt.avaterRes, ox, oy);
//					leftView.editAvater(avt.avaterRes);
//					avt.dispose();
				}else{
					_dragObj.x = ox;
					_dragObj.y = oy;
					centerView.addAvatar(_dragObj, null, dropRole);
//					centerView.addChild(_dragObj);
				}
				centerPanel.refresh();
			}else{
				if(_dragObj is Avatar)
					(_dragObj as Avatar).dispose();
				if(_dragObj.parent)
					_dragObj.parent.removeChild(_dragObj);
			}
			_dragObj = null;
			centerView.onAddAvtStopMove();
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
		
		public function handleOpenSettingView():void
		{
			if(!_settingView)
			{
				_settingView = new SettingView();
			}
			_settingView.x = App.stage.stageWidth/2 - _settingView.width/2;
			_settingView.y = App.stage.stageHeight/2 - _settingView.height/2;
			App.stage.addChild(_settingView);
		}
		
		
		
	}
}