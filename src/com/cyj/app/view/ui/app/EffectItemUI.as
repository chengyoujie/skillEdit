/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.app {
	import morn.core.components.*;
	public class EffectItemUI extends View {
		public var txtName:Label = null;
		public var txtId:Label = null;
		protected static var uiView:XML =
			<View width="150" height="25">
			  <Image skin="png.comp.blank" x="0" y="0" width="150" height="25"/>
			  <Clip skin="png.guidecomp.clip_格子选中" x="2" y="0" width="149" height="24" sizeGrid="5,5,5,5,1" name="selectBox"/>
			  <Label text="名字" x="37" width="112" name="label" y="4" height="18" var="txtName" color="0xffffff"/>
			  <Label text="0" x="5" width="26" name="label" y="5" height="18" var="txtId" color="0xffffff"/>
			</View>;
		public function EffectItemUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}