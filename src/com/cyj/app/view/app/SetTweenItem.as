package com.cyj.app.view.app
{
	import com.cyj.app.data.effect.EffectPlayTweenData;
	import com.cyj.app.data.effect.EffectPlayTweenItemData;
	import com.cyj.app.utils.BindData;
	import com.cyj.app.view.ui.app.SetTweenItemUI;
	
	import morn.core.handlers.Handler;
	
	public class SetTweenItem extends SetTweenItemUI
	{
		private var _data:EffectPlayTweenData;
		public function SetTweenItem()
		{
			super();
		}
		//{"name":"透明度", prop:"alpha", defaultFrom:1, defaultTo:0.5},
		private var _itemBindTweenData:Vector.<BindData>;
		override protected function initialize():void
		{
			super.initialize();
			_itemBindTweenData = new Vector.<BindData>();
			_itemBindTweenData.splice(0, 0,			
				new BindData(inputTime, "time"),
				new BindData(comType, "type", "selectedIndex")
			);
			btnAddTween.clickHandler = new Handler(handleAddTween);
			btnRemoveTween.clickHandler = new Handler(handleRemoveTween);
		} 
		private function toBind(binds:Vector.<BindData>, data:Object):void
		{
			for(var i:int=0; i<binds.length; i++)
			{
				binds[i].bind(data);
			}
		}
		
		
		
		override public function set dataSource(value:Object):void
		{
			if(!value)return;
			_data = value as EffectPlayTweenData;
			toBind(_itemBindTweenData, _data);
			listProp.dataSource = _data.items;
		}
		
		private function handleAddTween():void
		{
			var item:EffectPlayTweenItemData = new EffectPlayTweenItemData();
			_data.items.push(item);
			listProp.dataSource = _data.items;
		}
		
		private function handleRemoveTween():void
		{
			var item:EffectPlayTweenItemData = listProp.selectedItem as EffectPlayTweenItemData;
			if(!item)return;
			var index:int = _data.items.indexOf(item);
			if(index != -1)
			{
				_data.items.splice(index, 1);
			}
		}
		
		public function get data():Object
		{
			return _data;
		}
		
	}
}