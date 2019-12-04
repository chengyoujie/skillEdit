package com.cyj.app.view.app
{
	import com.cyj.app.SimpleEvent;
	import com.cyj.app.ToolsApp;
	import com.cyj.app.view.ui.app.SettingViewUI;
	import com.cyj.utils.file.FileManager;
	
	import morn.core.handlers.Handler;
	
	public class SettingView extends SettingViewUI
	{
		public function SettingView()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			btnClose.clickHandler = new Handler(close);
			btnDataPath.clickHandler = new Handler(handleSelectDataPath);
			btnWebPath.clickHandler = new Handler(handleSelectWebPath);
			btnSave.clickHandler = new Handler(handleSave);
			btnCancle.clickHandler = new Handler(close);
			show();
		}
		
		public function show():void
		{
			inputDataPath.text = ToolsApp.localCfg.localDataPath;
			inputWebPath.text = ToolsApp.localCfg.localWebPath;
		}
		
		private function handleSelectDataPath():void
		{
			ToolsApp.file.openFile(handleSetDataPath, true, ToolsApp.localCfg.localDataPath);
		}
		
		private function handleSelectWebPath():void
		{
			ToolsApp.file.openFile(handleSetWebPath, true, ToolsApp.localCfg.localWebPath);
		}
		
		private function handleSetDataPath(path:String):void
		{
			inputDataPath.text = path;
		}
		private function handleSave():void
		{
			if(ToolsApp.localCfg.localDataPath == inputDataPath.text && ToolsApp.localCfg.localWebPath == inputDataPath.text)return;
			ToolsApp.localCfg.localDataPath = inputDataPath.text;
			ToolsApp.localCfg.localWebPath = inputWebPath.text;
			ToolsApp.saveLocalCfg();
			close();
			SimpleEvent.send(AppEvent.LOCAL_CONFIG_CHANGE);
		}
		
		
		private function handleSetWebPath(path:String):void
		{
			inputWebPath.text = path;
		}
		
		public function close():void
		{
			if(this.parent)
			{
				this.parent.removeChild(this);
			}
		}
	}
}