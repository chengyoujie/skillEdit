package com.cyj.app.view.app
{
	import com.cyj.app.SimpleEvent;
	import com.cyj.app.view.ui.app.FileItemUI;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	
	public class FileItem extends FileItemUI
	{
		public static const EVENT_CLICK:String = "eventClick";
		private var _data:Object;
		
		public function FileItem()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			this.addEventListener(MouseEvent.CLICK, this.handleClick);
		}
		
		private function handleClick(e:MouseEvent):void
		{
			if(_data && !_data.isDirectory)
				this.dispatchEvent(new SimpleEvent(EVENT_CLICK, _data));
		}
		
		override public function set dataSource(value:Object):void
		{
			if(!value)return;
			txtName.text = value.name;
			var txtColor:int = 0xffffff;
			if(value.path && value.type != "effect")
			{
				var file:File = new File(value.path);
				if(!file.exists)
					txtColor = 0xff0000;
			}
			txtName.color = txtColor;
			_data = value;
			if(_data.isDirectory)
			{
				this.mouseChildren = true;
			}else{
				this.mouseChildren = false;
			}
			super.dataSource = value;	
		}
		
		
	}
}