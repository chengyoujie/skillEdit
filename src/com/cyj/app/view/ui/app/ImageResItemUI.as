/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.app {
	import morn.core.components.*;
	public class ImageResItemUI extends View {
		public var txtName:Label = null;
		protected static var uiView:XML =
			<View width="120" height="25">
			  <Image skin="png.comp.blank" x="0" y="0" width="120" height="25"/>
			  <Label text="listItem" x="8" width="103" name="label" y="5" height="18" var="txtName" color="0xffffff"/>
			</View>;
		public function ImageResItemUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}