/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.app {
	import morn.core.components.*;
	public class CenterViewUI extends View {
		protected static var uiView:XML =
			<View width="892" height="720">
			  <Image skin="png.guidecomp.外框_1" x="0" y="0" width="892" height="720" sizeGrid="8,8,8,8,1"/>
			</View>;
		public function CenterViewUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}