/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.app {
	import morn.core.components.*;
	public class CenterViewUI extends View {
		public var bg:Image = null;
		public var checkLockEffect:CheckBox = null;
		public var checkLockRole:CheckBox = null;
		protected static var uiView:XML =
			<View width="918" height="870">
			  <Image skin="png.guidecomp.外框_1" x="0" y="0" width="918" height="870" sizeGrid="8,8,8,8,1" var="bg"/>
			  <CheckBox label="锁定特效层" skin="png.guidecomp.checkbox_单选" x="10" y="10" labelColors="0xc79a84,0xe0a98d,0x93827a" labelStroke="0" var="checkLockEffect"/>
			  <CheckBox label="锁定角色层" skin="png.guidecomp.checkbox_单选" x="10" y="37" labelColors="0xc79a84,0xe0a98d,0x93827a" labelStroke="0" var="checkLockRole"/>
			</View>;
		public function CenterViewUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}