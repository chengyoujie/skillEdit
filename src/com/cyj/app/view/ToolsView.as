package com.cyj.app.view
{
	import com.cyj.app.SimpleEvent;
	import com.cyj.app.ToolsApp;
	import com.cyj.app.data.AvaterData;
	import com.cyj.app.data.EffectGroupItemData;
	import com.cyj.app.data.ICopyData;
	import com.cyj.app.data.ToolsConfig;
	import com.cyj.app.data.cost.Action;
	import com.cyj.app.data.cost.Direction;
	import com.cyj.app.data.cost.ResType;
	import com.cyj.app.utils.BindData;
	import com.cyj.app.utils.ComUtill;
	import com.cyj.app.utils.SvnOper;
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
			btnSave.clickHandler = new Handler(handleSaveData);
			btnOpenDir.clickHandler = new Handler(handleOpenDir);
			btnSvnCommit.clickHandler = new Handler(handleSvnCommit);
			btnSvnUpdate.clickHandler = new Handler(handleSvnUpdate);
			App.stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			App.stage.addEventListener(Event.RESIZE, handleStageReSize);
			SimpleEvent.on(AppEvent.LOCAL_CONFIG_CHANGE, loadConfigZzp);
			loadConfigZzp();
			appName.text = ToolsApp.config.appName;
			handleStageReSize();
		}
		
		public function initProject():void
		{
			Log.log("项目初始化完毕");
			leftView.initProject();
			rightView.initProject();
			centerView.initProject();
		}
		/** 初始化事件 **/
		private function initEvent():void
		{
			
		} 
		
		private function handleStageReSize(e:Event=null):void
		{
			var sw:int = App.stage.stageWidth;
			var sh:int = App.stage.stageHeight;
			var cw:int = sw - centerPanel.x- rightView.width - 3;
			if(cw<1)
				cw = 1;
			var ch:int = sh - centerPanel.y - 30;
			centerPanel.width = cw;
			centerPanel.height = ch;
			appName.x = sw/2 - appName.width/2;
			boxOper.x = sw-boxOper.width-10;
			txtLog.width = sw - txtAuth.width;
			txtLog.y = sh - txtLog.height - 3;
			txtAuth.x = sw - txtAuth.width;
			txtAuth.y = sh - txtAuth.height - 3;
			rightView.x = sw - rightView.width;
			bg.width = sw;
			bg.height = sh;
			centerPanel.refresh();
			leftView.onResize(leftView.width, sh-leftView.y-30);
			rightView.onResize(rightView.width, sh-rightView.y - 30);
			centerView.onResize(cw, ch);
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
//				var keyProp:Object = byte.readObject();
				var obj:Object = byte.readObject();
				zzp[name] = obj.unit;
			}
			ToolsApp.projectData.config = zzp;
			Log.log("config.zzp加载完毕");
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
			if(e.keyCode == Keyboard.DELETE)//删除
			{
				centerView.doDelete();
			}else if(e.keyCode == Keyboard.S && e.ctrlKey)//保存
			{
				ToolsApp.saveConfig();
			}else if(e.keyCode == Keyboard.C && e.ctrlKey)//复制
			{
				if(ToolsApp.projectData.fouceData)
				{
					ToolsApp.projectData.copyData = ToolsApp.projectData.fouceData.copy();
					Log.log("复制成功");
				}
			}else if(e.keyCode == Keyboard.V && e.ctrlKey)//粘贴
			{
				var pastData:ICopyData = ToolsApp.projectData.copyData;
				if(pastData)
				{
					pastData = pastData.copy();
					leftView.past(pastData);
					centerView.past(pastData);
					rightView.past(pastData);
				}
			}else if(e.keyCode == Keyboard.Q && e.ctrlKey)//更新
			{
				handleSvnUpdate();
			}else if(e.keyCode == Keyboard.W && e.ctrlKey)//上传
			{
				handleSvnCommit();
			}else if(e.keyCode == Keyboard.E && e.ctrlKey)//目录
			{
				handleOpenDir();
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
					centerView.addAvatar(avt, dropRole);
//					ToolsApp.projectData.avaterRes = avt.avaterRes;
//					centerView.editAvater(avt.avaterRes, ox, oy);
//					leftView.editAvater(avt.avaterRes);
//					avt.dispose();
				}else{
					_dragObj.x = ox;
					_dragObj.y = oy;
					centerView.addAvatar(_dragObj, dropRole);
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
		public function handleSaveData():void
		{
			ToolsApp.saveConfig();
		}
		public function handleOpenDir():void
		{
			var file:File = new File(ToolsApp.localCfg.localWebPath + "/resource/config/");
			if(file.exists)
			{
				file.openWithDefaultApplication();
			}else{
				TipMsg.show("没有找到目录"+file.nativePath);
			}
		}
		public function handleSvnCommit():void
		{
			SvnOper.svnCommit(ToolsApp.localCfg.localWebPath + "/resource/config/", handleSvnCommitComplete);
		}
		
		public function handleSvnUpdate():void
		{
			SvnOper.svnUpdata(ToolsApp.localCfg.localWebPath + "/resource/config/", handleSvnUpdateComplete);
		}
		private function handleSvnCommitComplete(success:Boolean):void
		{
			if(success)
				Alert.show("提交成功");
		}
		private function handleSvnUpdateComplete(success:Boolean):void
		{
			if(success)
				Alert.show("更新成功");
		}
		
	}
}