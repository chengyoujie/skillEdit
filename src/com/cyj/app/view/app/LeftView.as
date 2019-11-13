package com.cyj.app.view.app
{
	import com.cyj.app.view.ui.app.LeftViewUI;
	import com.cyj.utils.file.FileManager;
	
	import flash.filesystem.File;
	
	public class LeftView extends LeftViewUI
	{
		public function LeftView()
		{
			super();
		}
		
		
		public function refushList():void
		{
			var file:File = new File("D:/publish/avatarres/");
//			var files:Array =[];
//			FileManager.readDirFiles(file,files, ["json"]);
//			list_skills.dataSource = files;
			
			var xml:String = "";//"<root>";
			xml += getFileXml(file);
//			xml += "</root>";
			trace(xml);
//			treeFiles.itemRender = FileItem;
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
	}
}