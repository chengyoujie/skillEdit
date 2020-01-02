package com.cyj.app.view.app
{
	import com.cyj.app.SimpleEvent;
	import com.cyj.app.data.effect.EffectPlayItemData;
	import com.cyj.app.data.effect.EffectPlayTweenData;
	import com.cyj.app.data.effect.EffectPlayTweenItemData;
	import com.cyj.app.view.ui.app.SetTweenViewUI;
	
	import morn.core.handlers.Handler;
	
	public class SetTweenView extends SetTweenViewUI
	{
		public static const  tweenData:Object = {
			"alpha":{index:0, name:"透明度", prop:"alpha", from:1, to:0.5},
			"scaleX":{index:1, name:"缩放X", prop:"scaleX", from:1, to:0.5},
			"scaleY":{index:2, name:"缩放Y", prop:"scaleY", from:1, to:0.5},
			"x":{index:3, name:"X", prop:"x", from:0, to:1},
			"y":{index:4, name:"Y", prop:"y", from:0, to:1}
		};
		public static var tweenIndex2Data:Object = {};
		public static var allKeys:Array = [];
//			{"name":"透明度", prop:"alpha", from:1, to:0.5},
//			{"name":"缩放X", prop:"scaleX", from:1, to:0.5},
//			{"name":"缩放Y", prop:"scaleX", from:1, to:0.5}
		private var _data:EffectPlayItemData;
		public function SetTweenView()
		{
			super();
			for(var key:String in tweenData)
			{
				tweenIndex2Data[tweenData[key].index] = tweenData[key];
			}
		}
		override protected function initialize():void
		{
			super.initialize();
			allKeys = [];
			for(var key:String in tweenData)
			{
				allKeys[tweenData[key].index] = tweenData[key].name;
			}
			btnClose.clickHandler = new Handler(close);
			btnAddTween.clickHandler = new Handler(handleAddItem);
			btnRemoveTween.clickHandler = new Handler(handleRemoveItem);
		} 
		
		public function open(data:EffectPlayItemData):void
		{
			App.stage.addChild(this);
			this.x = App.stage.stageWidth/2 - this.width/2;
			this.y = App.stage.stageHeight/2 - this.height/2;
			_data = data;
			refushList();
		}
		
		private function refushList():void
		{
			if(!_data)return;
			var list:Array = [];
			var tweenProps:Array = _data.tweenProps;
			listProp.dataSource = tweenProps;
		}
		
		private function handleAddItem():void
		{
			var item:Object = listProp.selectedItem;
			var addTween:EffectPlayTweenData = new EffectPlayTweenData();
			_data.tweenProps.push(addTween);
			refushList();
		}
		
		private function handleRemoveItem():void
		{
			var item:Object = listProp.selectedItem;
			if(!item)return;
			var tweenData:EffectPlayTweenData = item as EffectPlayTweenData;
			var index:int = _data.tweenProps.indexOf(tweenData);
			if(index != -1)
			{
				_data.tweenProps.splice(index, 1);
			}
			refushList();
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
			var tw:EffectPlayTweenData;
			for(var i:int=0; i<list.length; i++)
			{
				var item:SetTweenItem = listProp.getCell(i) as SetTweenItem;
				if(item.data.group)
				{
					tween.push(item.data.data);
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