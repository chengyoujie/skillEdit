/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.app {
	import morn.core.components.*;
	public class SetTweenItemUI extends View {
		public var inputFrom:TextInput = null;
		public var txtName:Label = null;
		public var checkUse:CheckBox = null;
		public var inputTo:TextInput = null;
		public var inputTime:TextInput = null;
		public var comType:ComboBox = null;
		protected static var uiView:XML =
			<View width="450" height="31">
			  <TextInput skin="png.guidecomp.textinput_文字输入底框_2" x="92" y="5" width="50" height="22" color="0xff6600" var="inputFrom" margin="3,2,2,2"/>
			  <Label text="透明度" x="36" y="7" color="0xff9900" stroke="0" width="55" height="18" var="txtName"/>
			  <CheckBox skin="png.guidecomp.checkbox_单选" labelColors="0xc79a84,0xe0a98d,0x93827a" labelStroke="0" var="checkUse" x="1" y="5"/>
			  <Label text="到" x="148" y="7" color="0xff9900" stroke="0" width="29" height="18"/>
			  <TextInput skin="png.guidecomp.textinput_文字输入底框_2" x="167" y="5" width="50" height="22" color="0xff6600" var="inputTo" margin="3,2,2,2"/>
			  <Label text="时间" x="223" y="7" color="0xff9900" stroke="0" width="29" height="18"/>
			  <TextInput skin="png.guidecomp.textinput_文字输入底框_2" x="255" y="5" width="50" height="22" color="0xff6600" var="inputTime" margin="3,2,2,2"/>
			  <ComboBox skin="png.guidecomp.combobox" x="343" y="4.5" var="comType" width="99" height="23" visibleNum="15" scrollBarSkin="png.guidecomp.vscroll" itemColors="0x262626,0xffe0ce,0xff861a,0x885202,0x3d3d3d" labelColors="0xf4a339,0xfedcaf,0xe0e0e0" labels="直线,二次方加速,二次方减速,二次方加减速,三次方加速,三次方减速,三次方加减速,四次方加速,四次方减速,四次方加减速,五次方加速,五次方减速,五次方加减速,正弦加速,正弦减速,正弦加减速,超范围加速,超范围减速,超范围加减速,圆形加速,圆形减速,圆形加减速,指数反弹加速,指数反弹减速,指数反弹加减速,指数衰减加速,指数衰减减速,指数衰减加减速" selectedIndex="0"/>
			  <Label text="类型" x="312" y="7" color="0xff9900" stroke="0" width="29" height="18"/>
			</View>;
		public function SetTweenItemUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}