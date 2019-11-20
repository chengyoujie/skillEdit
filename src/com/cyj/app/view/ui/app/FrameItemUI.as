/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.app {
	import morn.core.components.*;
	public class FrameItemUI extends View {
		public var txtTest:Label = null;
		protected static var uiView:XML =
			<View width="10" height="30">
			  <Label text="●" x="-1" y="7" color="0xcccccc" var="txtTest" size="8"/>
			</View>;
		public function FrameItemUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}