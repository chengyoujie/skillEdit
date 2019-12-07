/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.app {
	import morn.core.components.*;
	public class EffectStepItemUI extends View {
		public var txtId:Label = null;
		public var txtName:Label = null;
		protected static var uiView:XML =
			<View width="200" height="25">
			  <Image skin="png.comp.blank" x="0" y="0" width="201" height="25"/>
			  <Label text="id" x="8" width="48" name="label" y="5" height="18" var="txtId" color="0xffffff"/>
			  <Clip skin="png.guidecomp.clip_格子选中" x="0" y="0" width="200" height="24" sizeGrid="5,5,5,5,1" name="selectBox"/>
			  <Label text="name" x="70" width="125" name="label" y="5" height="18" var="txtName" color="0xffffff"/>
			</View>;
		public function EffectStepItemUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}