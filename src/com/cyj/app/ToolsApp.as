package com.cyj.app
{
	import com.cyj.app.data.LocalConfig;
	import com.cyj.app.data.MovieData;
	import com.cyj.app.data.ProjectData;
	import com.cyj.app.data.ToolsConfig;
	import com.cyj.app.data.effect.EffectPlayData;
	import com.cyj.app.utils.ComUtill;
	import com.cyj.app.utils.SvnOper;
	import com.cyj.app.view.ToolsView;
	import com.cyj.app.view.app.effect.EffectPlayer;
	import com.cyj.app.view.common.Alert;
	import com.cyj.app.view.common.TipMsg;
	import com.cyj.app.view.ui.common.AlertUI;
	import com.cyj.app.view.unit.Role;
	import com.cyj.utils.Log;
	import com.cyj.utils.ObjectUtils;
	import com.cyj.utils.XML2Obj;
	import com.cyj.utils.cmd.CMDManager;
	import com.cyj.utils.cmd.CMDStringParser;
	import com.cyj.utils.file.FileManager;
	import com.cyj.utils.ftp.SimpleFTP;
	import com.cyj.utils.load.LoaderManager;
	import com.cyj.utils.load.ResData;
	import com.cyj.utils.load.ResLoader;
	import com.cyj.utils.md5.MD5;
	
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeApplication;
	import flash.desktop.NativeDragManager;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NativeDragEvent;
	import flash.filesystem.File;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import morn.core.events.UIEvent;

	/**
	 * 应用入口
	 * @author cyj
	 * 
	 */	
	public class ToolsApp
	{
		public static var view:ToolsView;
		public static var loader:LoaderManager = new LoaderManager();
		public static var file:FileManager = new FileManager();
		public static var config:ToolsConfig;
		public static var event:EventDispatcher = new EventDispatcher();
		public static var localCfg:LocalConfig = new LocalConfig();
		public static var projectData:ProjectData = new ProjectData();
		
		public static var effectPlayer:EffectPlayer;
		
		public static var totalNum:int = 0;
		public static var delaNum:int = 0;
		
		public static var VERSION:String = "1.0.1";
		
		private static const localCfgPath:String = File.userDirectory.nativePath+"/AppData/Local/effectEdit/res/local.json";
		
//		public static var ftp:SimpleFTP;		
		public function ToolsApp()
		{
		}
		
		public static function start():void
		{
			loader.loadManyRes(["res/comp.swf", "res/guidecomp.swf"], handleSwfLoaded, null, handleLoadError);
		}
		
		private static function handleSwfLoaded():void
		{
			view = new ToolsView();
			App.stage.addChild(view);
			Log.initLabel(view.txtLog);
			
			startDoDrag();
			exitAppEvent();
			
			Log.log("开始加载系统config.xml");
			loader.loadSingleRes("res/config.xml", ResLoader.TXT, handleAppConfigLoaded, null, handleLoadError);
		}
		
		
		private static function handleAppConfigLoaded(res:ResData):void
		{
			XML2Obj.registerClass("toolsconfig", ToolsConfig);
//			XML2Obj.registerClass("local", LocalConfig);
			config = XML2Obj.readXml(res.data) as ToolsConfig;
			VERSION = config.version;
			App.stage.nativeWindow.title = config.title+"@"+VERSION;
			
			Log.log("开始加载local.json");
			var f:File = new File(localCfgPath);
			if(f.exists)
				loader.loadSingleRes(localCfgPath, ResLoader.TXT, handleLocalLoaded, null, handleLoadError);
			else{
				handleLocalLoaded();
			}
			
//			Log.init(App.stage, 9, 360, 586, 65);
			//
//			new ReadMapCfg();
//			ftp = new SimpleFTP(config.ftphost, config.ftpname, config.ftppass);
//			ftp.
//			SimpleFTP.getFile(config.ftphost, config.ftpname, config.ftppass, "/data/", handleGetFtpList);
		}
		
		
//		private static function handleLocalConfigLoaded(res:ResData):void
//		{
//			var data:Object = JSON.parse(res.data);
//			localCfg.parse(data); //XML2Obj.readXml(res.data) as LocalConfig;
//			Log.log("开始加载config.zzp");
//			var configPath:String = ToolsApp.localCfg.localWebPath+ComUtill.getCfgPath()+"config.zzp"
//			ToolsApp.loader.loadSingleRes(configPath, ResLoader.BYT, handleZzpLoaded);
//		}
		
		private static function handleLocalLoaded(res:ResData=null):void
		{
			if(res)
			{
				var data:Object = JSON.parse(res.data);
				localCfg.parse(data);
			} else{
				localCfg = new LocalConfig();
			}

			try{
				CMDManager.startCmd();
				CMDManager.addParser(new CMDStringParser(), SvnOper.handleCmdResult);
//				ToolsApp.cmdOper("net use \\\\"+ToolsApp.config.upip+" "+ToolsApp.config.uppass+" /user:\""+ToolsApp.config.upname+"\"");
			}catch(e:*){
				Alert.show("当前不支持CMD命令行\n"+e);
			}
			
			view.initView();
			
			Log.log("系统启动成功");
			//因为没有共享目录， 暂时去掉否则其他人打开的时候会卡
//			loader.loadSingleRes(config.versionconfig, ResLoader.TXT, handleVersionConfigLoaded, null, null);
		}
		
		private static function handleVersionConfigLoaded(res:ResData):void
		{
			var versiontxt:String = res.data;
			var versionReg:RegExp = /[\n\r]*\[(.*?)\][\n\r]*/gi;
			var obj:Object= {};
			var arr:Array= versionReg.exec(versiontxt);
			var lastIndex:int = 0;
			var lastProp:String;
			while(arr)
			{
				if(lastProp)
				{
					obj[lastProp] = versiontxt.substring(lastIndex, versionReg.lastIndex-arr[0].length);
					lastIndex = versionReg.lastIndex;
				}
				lastProp = arr[1];
				lastIndex = versionReg.lastIndex;
				arr = versionReg.exec(versiontxt);
			}
			if(lastProp)
			{
				obj[lastProp] = versiontxt.substring(lastIndex, versiontxt.length);
			}
			if(obj.version != VERSION)
			{
				Alert.show("<font color='#FF0000'>当前版本<font color='#00FF00'>"+VERSION+"</font>最新版本:<font color='#00FF00'>"+obj.version+"</font></font>\n<p align='left'><font color='#FFFF00'>更新内容</font>\n"+obj.desc.replace(/\r\n/gi, "\n")+"</p>", "更新提醒");
			}
			
		}
		
//		private static var logMsgReg:RegExp = /-{72,}\s+r([0-9]+)\s+\|\s+(\w+)\s+\|\s+([0-9]{4}-[0-9]{2}-[0-9]{2}\s+[0-9]{2}:[0-9]{2}:[0-9]{2}).*?\s+Changed paths:\s+(.*[^\s][\r\n])+/gi;
		
		
		public static function getTimeId(day:String, time:String):Number
		{
			var n:Number = 0;
			var days:Array = day.split("-");
			var nstr:String = "";
			if(days.length>0)
				nstr = getLenStr(days[0], 4, "", "0");
			if(days.length>1)
				nstr += getLenStr(days[1], 2);
			if(days.length>2)
				nstr += getLenStr(days[2], 2);
			var times:Array = time.split(":");
			if(times.length>0)
				nstr += getLenStr(times[0], 2, "", "0");
			if(times.length>1)
				nstr += getLenStr(times[1], 2, "", "0");
			if(times.length>2)
				nstr += getLenStr(times[2], 2, "", "0");
			n = Number(nstr);
			return n;
		}
		public static function getLenStr(str:String, len:int, addstr:String="0", endstr:String=""):String
		{
			if(!addstr)
				addstr = " ";
			for(var i:int=str.length; i<len; i++)
			{
				str = addstr+str+endstr;
			}
			return str;
		}
		
		
		
		 
		private static function handleGetFtpList(res:*, msg:*):void
		{
			Log.log(res);
		}
		
		
		public static function handleLoadError(res:ResData, msg:*):void
		{
			Alert.show("资源加载错误"+res.resPath+"\nerror : "+msg, "加载错误");
		}
		
		private static function startDoDrag():void
		{
			App.stage.addEventListener(NativeDragEvent.NATIVE_DRAG_ENTER, handleDragEnter);
			App.stage.addEventListener(NativeDragEvent.NATIVE_DRAG_DROP, handleDropEvent);
			App.stage.addEventListener(NativeDragEvent.NATIVE_DRAG_EXIT, handleDropExit);
		}
		
		private static function handleDragEnter(e:NativeDragEvent):void
		{
			var clipBoard:Clipboard = e.clipboard;
			if(clipBoard.hasFormat(ClipboardFormats.FILE_LIST_FORMAT))
			{
				NativeDragManager.acceptDragDrop(App.stage);
			}
		}
		
		private static  function handleDropEvent(e:NativeDragEvent):void
		{
			var clip:Clipboard = e.clipboard;
			if(clip.hasFormat(ClipboardFormats.FILE_LIST_FORMAT))
			{
				var arr:Array = clip.getData(ClipboardFormats.FILE_LIST_FORMAT) as Array;
				var file:File;
				for(var i:int=0; i<arr.length; i++)
				{
					file = arr[i];
					if(file.isDirectory==false)
					{
						var type:String = file.name.substr(file.name.lastIndexOf("."));
						if(type == ".dat")
						{
							
						}
					}
//					trace("拖入文件"+file.name);
					//file.namefile.name.lastIndexOf(".")
				}
			}
		}
		
		private static  function handleDropExit(e:NativeDragEvent):void
		{
			//trace("Exit Drop");
		}
		
		private static function exitAppEvent():void
		{
			App.stage.nativeWindow.addEventListener(Event.CLOSING, handleCloseApp);
		}
		
		public static function saveLocalCfg():void
		{
			if(!localCfg)return;
			var list:Vector.<Role> = view.centerView.roleLayer.all;
			localCfg.sceneAvater.length = 0;
			for(var i:int=0; i<list.length; i++)
			{
				localCfg.sceneAvater.push(list[i].data);
			}
			file.saveFile(localCfgPath, JSON.stringify(localCfg));
		}
		
		public static function saveConfig():void
		{
			var errStr:String = projectData.allEffectPlayData.getErrStr();
			if(errStr)
			{
				Alert.show(errStr);
				return;
			}
			var data:String = JSON.stringify(projectData.allEffectPlayData.data);
			var thinData:String = JSON.stringify(projectData.allEffectPlayData.thinData);
			if(localCfg.localDataPath)//保存全数据
			{
				file.saveFile(localCfg.localDataPath+"/XmlData/export/effect.json", data); 
			}
			if(localCfg.localWebPath)//保存瘦身过的数据
			{
//				var file:File = new File(localCfg.localWebPath+ComUtill.getCfgPath()+"effect.json");
				file.saveFile(localCfg.localWebPath+ComUtill.getCfgPath()+"effect.json", thinData); 
			}
			projectData.lastSaveEffectData = projectData.allEffectPlayData.copy() as EffectPlayData;
			TipMsg.show("保存成功");
		}
		
		private static function handleCloseApp(e:Event):void
		{
			Log.log("退出系统");
			Log.refushLog();
			saveLocalCfg();
			if(checkProjectDataSave(saveAndExit, "保存并退出", "直接退出"))
			{
				//关闭
				App.stage.nativeWindow.close();
				
			}else{//取消默认关闭
				e.preventDefault();
				NativeApplication.nativeApplication.activeWindow.visible = true;
			}
		}
		
		private static function saveAndExit(isOk:Boolean):void
		{
			if(isOk)
			{
				saveConfig();
			}
			//关闭
			App.stage.nativeWindow.close();
			
		}
		
		
		public static function checkProjectDataSave(onOkCall:Function, okLabel:String="保存", cancleLabel:String="退出", noclose:Boolean=false):Boolean
		{
			if(projectData.lastSaveEffectData && projectData.allEffectPlayData.data)
			{
				if(ObjectUtils.checkIsSame(projectData.lastSaveEffectData.data, projectData.allEffectPlayData.data)==false)
				{
					Alert.show("当前数据还没有保存，是否保存一下了？ ctr+s 哦~", "提示", Alert.ALERT_OK_CANCLE, function(dowhat:int):void{
						if(dowhat == Alert.ALERT_OK)
						{
							onOkCall(true);
						}else{
							onOkCall(false);
						}
					}, okLabel, cancleLabel, noclose);
					return false;
				}
			}
			return true;
		}
		
		
		
	}
}