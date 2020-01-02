/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.app {
	import morn.core.components.*;
	public class SetTweenPropItemUI extends View {
		public var inputFrom:TextInput = null;
		public var inputTo:TextInput = null;
		public var comProp:ComboBox = null;
		public var txtIndex:Label = null;
		protected static var uiView:XML =
			<View width="190" height="25">
			  <Clip skin="png.guidecomp.clip_格子选中" x="-1" y="0" width="192" height="24" sizeGrid="5,5,5,5,1" name="selectBox"/>
			  <TextInput skin="png.guidecomp.textinput_文字输入底框_2" x="67" y="2" width="50" height="22" color="0xff6600" var="inputFrom" margin="3,2,2,2"/>
			  <Label text="到" x="119" y="4" color="0xff9900" stroke="0" width="15" height="18"/>
			  <TextInput skin="png.guidecomp.textinput_文字输入底框_2" x="138" y="2" width="50" height="22" color="0xff6600" var="inputTo" margin="3,2,2,2"/>
			  <ComboBox skin="png.guidecomp.combobox" var="comProp" width="56" height="23" visibleNum="15" scrollBarSkin="png.guidecomp.vscroll" itemColors="0x262626,0xffe0ce,0xff861a,0x885202,0x3d3d3d" labelColors="0xf4a339,0xfedcaf,0xe0e0e0" labels="透明度,缩放X,缩放Y,x,y" selectedIndex="0" x="9" y="1"/>
			  <Label text="0" x="-1" y="2" color="0xff9900" stroke="0" width="15" height="18" var="txtIndex"/>
			</View>;
		public function SetTweenPropItemUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}