package com.cyj.app.view.app
{
	public class AppEvent
	{
		public static const CHANGE_AVATER:String = "changeAvater";
		public static const AVATER_RES_COMPLETE:String = "avaterResComplete";
		
		/**左侧的特效列表改变**/
		public static const EFFECT_CHANGE:String = "effectChange";
		
		/**右侧的特效的每一步发生改变*/
		public static const EFFECT_STEP_CHANGE:String = "effectStepChange";
		
		public static const CLICK_ROLE:String = "clickRole";
		
		public static const ITEM_ADD_RES:String = "itemAddRes";
		
		public static const AVATER_MOVE:String = "avaterMove";
		
		public static const AVATER_TYPE_CHANGE:String = "avaterTypeChange";
		
		
		public static const REFUSH_SCENE:String = "refushScene";
		
		public static const EFFECT_OPER_SET_CHANGE:String = "effectOperSetChange";
		
		/**移动的距离发生改变**/
		public static const MOVE_CHANGE:String = "moveChange";
		/**刷新右侧的列表**/
		public static const REFUSH_RIGHT:String = "refushRight";
		/**localConfig发生改变***/
		public static const LOCAL_CONFIG_CHANGE:String = "localCfgChange";
		
		public function AppEvent()
		{
		}
	}
}