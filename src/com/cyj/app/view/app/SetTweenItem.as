package com.cyj.app.view.app
{
	import com.cyj.app.data.effect.EffectPlayTweenPropData;
	import com.cyj.app.utils.BindData;
	import com.cyj.app.view.ui.app.SetTweenItemUI;
	
	public class SetTweenItem extends SetTweenItemUI
	{
		private var _data:EffectPlayTweenPropData;
		public function SetTweenItem()
		{
			super();
		}
		//{"name":"透明度", prop:"alpha", defaultFrom:1, defaultTo:0.5},
		private var _itemBindData:Vector.<BindData>;
		override protected function initialize():void
		{
			super.initialize();
			_itemBindData = new Vector.<BindData>();
			_itemBindData.splice(0, 0,			
//				new BindData(txtName, "id", "text", handleIdNameChange, handleIdChangeCheck),
				new BindData(inputFrom, "from"),
				new BindData(inputTo, "to" ),
				new BindData(inputTime, "time"),
				new BindData(comType, "type", "selectedIndex")
			);
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
			checkUse.selected = value.selected;
			_data = value.data as EffectPlayTweenPropData ;
			txtName.text = SetTweenView.tweenData[_data.prop].name;
//			inputFrom.text = _data.from+"";
//			inputTo.text = _data.to+"";
//			inputTime.text = _data.time+"";
//			comType.selectedIndex = _data.type;
			toBind(_itemBindData, _data);
		}
		
		public function get data():EffectPlayTweenPropData
		{
			return _data;
		}
		
	}
}