package com.cyj.app.view.app
{
	import com.cyj.app.SimpleEvent;
	import com.cyj.app.ToolsApp;
	import com.cyj.app.view.ui.app.LeftViewUI;
	import com.cyj.app.view.unit.AvaterRes;
	import com.cyj.utils.file.FileManager;
	
	import flash.filesystem.File;
	
	public class LeftView extends LeftViewUI
	{
		private var _res:AvaterRes;
		
		public function LeftView()
		{
			super();
		}
		
		
		public function refushList():void
		{
			var file:File = new File("D:/publish/avatarres/");
			var xml:String = "";
			xml += getFileXml(file);
			treeFiles.dataSource = new XML(xml);
		}

		public function getFileXml(file:File):String
		{
			var child:String = "";
			if(file.isDirectory)
			{
				child += "<dir name='"+file.name+"' path='"+file.nativePath+"'>";
				var files:Array = file.getDirectoryListing();
				for(var i:int=0; i<files.length; i++)
				{
					child += getFileXml(files[i]);
				}
				child += "</dir>";
			}else if(file.name.indexOf(".json") != -1){
				var fileName:String = file.name.replace(".json", "");
				var filePath:String = file.nativePath.replace(".json", "");
				child += "<file name='"+fileName+"' path='"+filePath+"' />";
			}
			return child;
		}
		
		public function editAvater(res:AvaterRes):void
		{
			_res = res;
			if(!_res)return;
			if(_res.isReady)
			{
				initAvaterRes();
				ToolsApp.event.removeEventListener(AppEvent.AVATER_RES_COMPLETE, handleResComplete);
			}else{
				ToolsApp.event.addEventListener(AppEvent.AVATER_RES_COMPLETE, handleResComplete);
			}
		}
		private function handleResComplete(e:SimpleEvent):void
		{
			if(_res != e.data)return;
			if(_res.isReady)
			{
				initAvaterRes();
				ToolsApp.event.removeEventListener(AppEvent.AVATER_RES_COMPLETE, handleResComplete);
			}
		}
		
		private function initAvaterRes():void
		{
			if(!_res || !_res.isReady)return;
			listImageRes.dataSource = _res.getResKeys();
		}
		
	}
}