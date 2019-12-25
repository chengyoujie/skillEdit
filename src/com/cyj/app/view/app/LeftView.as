package com.cyj.app.view.app
{
	import com.cyj.app.SimpleEvent;
	import com.cyj.app.ToolsApp;
	import com.cyj.app.data.EffectGroupItemData;
	import com.cyj.app.data.ICopyData;
	import com.cyj.app.data.cost.ResType;
	import com.cyj.app.data.effect.EffectPlayData;
	import com.cyj.app.utils.BindData;
	import com.cyj.app.utils.ComUtill;
	import com.cyj.app.utils.SvnOper;
	import com.cyj.app.view.common.Alert;
	import com.cyj.app.view.common.TipMsg;
	import com.cyj.app.view.ui.app.LeftViewUI;
	import com.cyj.app.view.unit.AvaterRes;
	import com.cyj.utils.Log;
	import com.cyj.utils.ObjectUtils;
	import com.cyj.utils.file.FileManager;
	import com.cyj.utils.load.ResData;
	import com.cyj.utils.load.ResLoader;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	
	import morn.core.handlers.Handler;
	
	public class LeftView extends LeftViewUI
	{
//		private var _res:AvaterRes;
		private var _groupItemBinds:Vector.<BindData> = new Vector.<BindData>();
		
		public function LeftView()
		{
			super();
		}
		
		private function loadConfig():void
		{
			if(ToolsApp.localCfg.autoCheck)
			{
				SvnOper.svnUpdata(ToolsApp.localCfg.localWebPath+"/resource/config/effect.json", handleLoadConfig);
			}else{
				handleLoadConfig();
			}
		}
		private function handleLoadConfig(success:Boolean=true):void{
			var configPath:String = ToolsApp.localCfg.localWebPath+"/resource/config/effect.json"
			configPath = ComUtill.commonPath(configPath);
			ToolsApp.loader.loadSingleRes(configPath, ResLoader.TXT, handleConfigLoaded, null, handleConfigError);
		}
		
		private function handleConfigError(res:ResData, msg:String):void
		{
			Alert.show(ToolsApp.localCfg.localWebPath+"/resource/config/effect.json\n"+"加载失败");
		}
		
		private function handleConfigLoaded(res:ResData):void
		{
			var effData:Object ;
			try{
				effData = JSON.parse(res.data);
			}catch(e:*){
				Alert.show(ToolsApp.localCfg.localWebPath+"/resource/config/effect.json\n"+"解析失败,请检查Json格式是否正确");
				return;
			}
			var data:EffectPlayData = new EffectPlayData();
			data.parser(effData);
			ToolsApp.projectData.allEffectPlayData = data;
			ToolsApp.projectData.lastSaveEffectData =ToolsApp.projectData.allEffectPlayData.copy() as EffectPlayData;
			refushEffectList();
		}
		
		private function refushEffectList():void
		{
			var effData:EffectPlayData = ToolsApp.projectData.allEffectPlayData;
			var list:Array = effData.list;
			listEffect.dataSource = list;
			listEffect.selectedIndex = list.length - 1;
			handleListEffectChange();
			SimpleEvent.send(AppEvent.REFUSH_RIGHT);
		}
		
		public function initView():void
		{
			listEffect.dataSource = [];
			_groupItemBinds.push(
				new BindData(inputId, "id", "text", handleGroupBindDataChange, checkCanSetId),
				new BindData(inputName, "name", "text", handleGroupBindDataChange)
				);
			initEvent();
		}
		
		private function checkCanSetId(id:String):Boolean
		{
			var effData:EffectPlayData = ToolsApp.projectData.allEffectPlayData;
			if(!effData)return true;
			var list:Array = effData.list;
			for(var i:int=0; i<list.length; i++)
			{
				var item:EffectGroupItemData = list[i];
				if(item.id == int(id))
				{
					TipMsg.show("特效组id更改失败， id重复");
					return false;
				}
			}
			return true;
		}
		
		private function handleGroupBindDataChange():void
		{
			listEffect.refresh();
		}
		
		
		public function initProject():void
		{
			var root:String = ToolsApp.localCfg.localWebPath+"/avatarres/";
			var file:File;
			var xml:String = "<root>";
			
			file = new File(ToolsApp.localCfg.localWebPath+"/resource/assets/");
			xml += getFileXml(file, ResType.IMAGE);
			
			file =new File(root+"effect");
			xml += getFileXml(file, ResType.EFFECT);
			
			file =new File(root+"effect2");
			xml += getFileXml(file, ResType.EFFECT);
			
			var arr:Array = ToolsApp.projectData.getResCfgByMenu("skills");
			for(var i:int=0; i<arr.length; i++)
			{
				xml += "<file  type='"+ResType.SKILL+"' name='"+arr[i].id+"' path='"+root+arr[i].resMenu+"/"+arr[i].res1+"' />";
			}
			xml+= "</root>";
			treeEffect.dataSource = new XML(xml);
			//角色资源
			var resDic:Object = ToolsApp.projectData.getResCfgDicByMenu("player", "goddess", "npc", "monster", "body");//后续可以放到config.xml中
			xml = "<root>";
			for(var key:String in resDic)
			{
				xml += "<dir  type='"+ResType.DIR+"'  name='"+key+"' path=''>";
				arr = resDic[key];
				for(i=0; i<arr.length; i++)
				{
					var item:Object = arr[i];
					xml += "<file  type='"+ResType.ROLE+"' name='"+arr[i].id+"' path='"+root+arr[i].resMenu+"/"+arr[i].res1+"' />";
				}
				xml += "</dir>";
			}
			xml+= "</root>";
			treeRole.dataSource = new XML(xml);
			
			loadConfig();
		}
		
		private function initEvent():void
		{
			btnAddEff.clickHandler = new Handler(handleAddEffect);
			btnRemoveEff.clickHandler = new Handler(handleRemoveEffect);
//			listEffect.selectHandler = new Handler(handleSelectEffect);
			listEffect.addEventListener(MouseEvent.CLICK, handleListEffectChange);
		}
		
		private function handleAddEffect():void
		{
				var effData:EffectPlayData = ToolsApp.projectData.allEffectPlayData;
				if(!effData)
				{
					Alert.show("特效组  数据不存在");
					return;
				}
				effData.addItem();
				refushEffectList();
		}
		private function handleRemoveEffect():void
		{
			var data:EffectGroupItemData = listEffect.selectedItem as EffectGroupItemData;
			if(!data)return;
			var effData:EffectPlayData = ToolsApp.projectData.allEffectPlayData;
			effData.removeItem(data.id)
			refushEffectList();
		}
		
		private function handleListEffectChange(e:MouseEvent=null):void
		{
			var data:EffectGroupItemData = listEffect.selectedItem as EffectGroupItemData;
			if(!data)return;
			bindData(data);
			ToolsApp.projectData.curEffectPlayList = data.data;
			Log.log("当前选择  特效组："+data.id);
			ToolsApp.projectData.fouceData = data;
			SimpleEvent.send(AppEvent.EFFECT_CHANGE, data);
		}
		
		private function bindData(data:EffectGroupItemData):void
		{
			for(var i:int=0; i<_groupItemBinds.length; i++)
			{
				_groupItemBinds[i].bind(data);
			}
		}

		public function getFileXml(file:File, type:String):String
		{
			var child:String = "";
			if(file.isDirectory)
			{
				child += "<dir  type='"+ResType.DIR+"'  name='"+file.name+"' path='"+file.nativePath+"'>";
				var files:Array = file.getDirectoryListing();
				for(var i:int=0; i<files.length; i++)
				{
					child += getFileXml(files[i], type);
				}
				child += "</dir>";
			}else if(file.name.indexOf(".json") != -1 && type != ResType.IMAGE){
				var fileName:String = file.name.replace(".json", "");
				var filePath:String = file.nativePath.replace(".json", "");
				child += "<file type='"+type+"' name='"+fileName+"' path='"+filePath+"' />";
			}else if((file.name.indexOf(".jpg") != -1  || file.name.indexOf(".png") != -1) && type == ResType.IMAGE){
				ToolsApp.projectData.setImagePath(file.nativePath, file.name);
				child += "<file type='"+type+"' name='"+file.name.substr(0, file.name.lastIndexOf("."))+"' path='"+file.nativePath+"' />";
			}
			return child;
		}
		
		public function past(value:ICopyData):void
		{
			if(value is EffectGroupItemData)
			{
				var effData:EffectPlayData = ToolsApp.projectData.allEffectPlayData;
				var cd:EffectGroupItemData = value as EffectGroupItemData
				effData.addItemData(cd);
				Log.log("粘贴  特效组："+cd.id);
				refushEffectList();	
			}
		}
		
		private var _mask:Shape;
		public function onResize(w:int, h:int):void
		{
			if(!_mask)
			{
				_mask = new Shape();
				this.addChild(_mask);
				this.mask = _mask;
			}
			_mask.graphics.clear();
			_mask.graphics.beginFill(0xff0000, 0.5);
			_mask.graphics.drawRect(0, 0, w, h-1);
			_mask.graphics.endFill();
			bg.width = w;
			bg.height = h;
		}
		
//		public function editAvater(res:AvaterRes):void
//		{
//			_res = res;
//			if(!_res)return;
//			if(_res.isReady)
//			{
//				initAvaterRes();
//				ToolsApp.event.removeEventListener(AppEvent.AVATER_RES_COMPLETE, handleResComplete);
//			}else{
//				ToolsApp.event.addEventListener(AppEvent.AVATER_RES_COMPLETE, handleResComplete);
//			}
//		}
//		private function handleResComplete(e:SimpleEvent):void
//		{
//			if(_res != e.data)return;
//			if(_res.isReady)
//			{
//				initAvaterRes();
//				ToolsApp.event.removeEventListener(AppEvent.AVATER_RES_COMPLETE, handleResComplete);
//			}
//		}
		
//		private function initAvaterRes():void
//		{
//			if(!_res || !_res.isReady)return;
//			listImageRes.dataSource = _res.getResKeys();
//		}
//		
	}
}