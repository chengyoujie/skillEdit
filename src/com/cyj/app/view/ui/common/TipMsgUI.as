/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.common {
	import morn.core.components.*;
	public class TipMsgUI extends View {
		public var imgBg:Image = null;
		public var txtMsg:Label = null;
		protected static var uiView:XML =
			<View width="250" height="25">
			  <Image skin="png.comp.blank" x="0" y="0" width="250" height="25" var="imgBg"/>
			  <Label text="提示" x="0" y="0" width="250" height="25" align="center" color="0xccff00" size="20" var="txtMsg"/>
			</View>;
		public function TipMsgUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}