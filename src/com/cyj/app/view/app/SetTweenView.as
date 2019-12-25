package com.cyj.app.view.app
{
	import com.cyj.app.SimpleEvent;
	import com.cyj.app.data.effect.EffectPlayItemData;
	import com.cyj.app.data.effect.EffectPlayTweenPropData;
	import com.cyj.app.view.ui.app.SetTweenViewUI;
	
	import morn.core.handlers.Handler;
	
	public class SetTweenView extends SetTweenViewUI
	{
		public static const  tweenData:Object = {
			"alpha":{index:0, name:"透明度", prop:"alpha", from:1, to:0.5},
			"scaleX":{index:1, name:"缩放X", prop:"scaleX", from:1, to:0.5},
			"scaleY":{index:2, name:"缩放Y", prop:"scaleY", from:1, to:0.5}
		};
//			{"name":"透明度", prop:"alpha", from:1, to:0.5},
//			{"name":"缩放X", prop:"scaleX", from:1, to:0.5},
//			{"name":"缩放Y", prop:"scaleX", from:1, to:0.5}
		private var _data:EffectPlayItemData;
		public function SetTweenView()
		{
			super();
		}
		override protected function initialize():void
		{
			super.initialize();
			btnClose.clickHandler = new Handler(close);
			btnSave.clickHandler = new Handler(handleSave);
			btnCancle.clickHandler = new Handler(close);
		} 
		
		public function open(data:EffectPlayItemData):void
		{
			App.stage.addChild(this);
			this.x = App.stage.stageWidth/2 - this.width/2;
			this.y = App.stage.stageHeight/2 - this.height/2;
			var list:Array = [];
			var hasShow:Object = {};
			_data = data;
			var tweenProps:Array = data.tweenProps;
			for(var i:int=0; i<tweenProps.length; i++)
			{
				var prop:EffectPlayTweenPropData = tweenProps[i];
				var obj:Object = tweenData[prop.prop];
				list[obj.index] = {data:prop, selected:true};
			}
			for(var key:String in tweenData)
			{
				var tdata:Object = tweenData[key];
				if(list[tdata.index])continue;
				var item:EffectPlayTweenPropData = new EffectPlayTweenPropData();
				item.init(tdata.prop, tdata.from, tdata.to, 1000);
				list[tdata.index] = {data:item, selected:false};
			}
			listProp.dataSource = list;
		}
		
		private function handleSave():void
		{
			var list:Array = listProp.dataSource as Array;
			if(!list || !_data)
			{
				close();
				return;
			}
			var tween:Array = [];
			for(var i:int=0; i<list.length; i++)
			{
				var item:SetTweenItem = listProp.getCell(i) as SetTweenItem;
				if(item.checkUse.selected)
				{
					tween.push(item.data);
				}
			}
			_data.tweenProps = tween;
			close();
			SimpleEvent.send(AppEvent.SET_TWEEN_PROP);
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