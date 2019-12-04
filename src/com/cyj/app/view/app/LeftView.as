package com.cyj.app.view.app
{
	import com.cyj.app.SimpleEvent;
	import com.cyj.app.ToolsApp;
	import com.cyj.app.data.cost.ResType;
	import com.cyj.app.data.effect.EffectPlayData;
	import com.cyj.app.utils.ComUtill;
	import com.cyj.app.view.ui.app.LeftViewUI;
	import com.cyj.app.view.unit.AvaterRes;
	import com.cyj.utils.file.FileManager;
	import com.cyj.utils.load.ResData;
	import com.cyj.utils.load.ResLoader;
	
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	
	import morn.core.handlers.Handler;
	
	public class LeftView extends LeftViewUI
	{
//		private var _res:AvaterRes;
		
		public function LeftView()
		{
			super();
		}
		
		private function loadConfig():void
		{
//			D:\publish\resource\config
			var configPath:String = ToolsApp.localCfg.localWebPath+"/resource/config/effect.json"
			configPath = ComUtill.commonPath(configPath);
			ToolsApp.loader.loadSingleRes(configPath, ResLoader.TXT, handleConfigLoaded);
		}
		
		private function handleConfigLoaded(res:ResData):void
		{
			var effData:Object = JSON.parse(res.data);
			var data:EffectPlayData = new EffectPlayData();
			data.parser(effData);
			ToolsApp.projectData.allEffectPlayData = data;
			refushEffectList();
		}
		
		private function refushEffectList():void
		{
			var effData:EffectPlayData = ToolsApp.projectData.allEffectPlayData;
			var list:Array = effData.list;
			listEffect.dataSource = list;
			listEffect.selectedIndex = list.length - 1;
			handleSelectEffect(listEffect.selectedIndex);
			SimpleEvent.send(AppEvent.REFUSH_RIGHT);
		}
		
		public function initView():void
		{
			listEffect.dataSource = [];
			initEvent();
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
			listEffect.selectHandler = new Handler(handleSelectEffect);
		}
		
		private function handleAddEffect():void
		{
				var effData:EffectPlayData = ToolsApp.projectData.allEffectPlayData;
				effData.addItem();
				refushEffectList();
		}
		private function handleRemoveEffect():void
		{
			var data:Object = listEffect.selectedItem;
			if(!data)return;
			var effData:EffectPlayData = ToolsApp.projectData.allEffectPlayData;
			effData.removeItem(data.id)
			refushEffectList();
		}
		
		private function handleSelectEffect(index:int):void{
			var data:Object = listEffect.selectedItem;
			if(!data)return;
			ToolsApp.projectData.curEffectPlayList = data.data;
			SimpleEvent.send(AppEvent.EFFECT_CHANGE, data);
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