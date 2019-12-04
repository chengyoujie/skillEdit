/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.app {
	import morn.core.components.*;
	public class SettingViewUI extends View {
		public var bg:Image = null;
		public var txtTitle:Label = null;
		public var btnWebPath:Button = null;
		public var btnClose:Button = null;
		public var inputWebPath:TextInput = null;
		public var btnDataPath:Button = null;
		public var inputDataPath:TextInput = null;
		public var btnSave:Button = null;
		public var btnCancle:Button = null;
		protected static var uiView:XML =
			<View width="419" height="270">
			  <Image skin="png.guidecomp.通用面板_2" x="0" y="0" width="419" height="270" sizeGrid="160,40,160,40,1" var="bg"/>
			  <Label text="设置" x="127" y="8" width="168" height="18" align="center" color="0xccff00" stroke="0x0" var="txtTitle"/>
			  <Button label="浏览" skin="png.guidecomp.btn_四字常规_1" x="325" y="52" labelColors="0xc79a84,0xe0a98d,0x93827a" labelStroke="0x0" var="btnWebPath"/>
			  <Button skin="png.guidecomp.btn_关闭_1" x="392" y="13" var="btnClose"/>
			  <TextInput skin="png.guidecomp.textinput_文字输入底框_2" x="103" y="63" width="216" height="22" color="0xff6600" var="inputWebPath" margin="3,2,2,2"/>
			  <Label text="选择web路径" x="18" y="64" color="0xff9900" stroke="0"/>
			  <Button label="浏览" skin="png.guidecomp.btn_四字常规_1" x="323" y="106" labelColors="0xc79a84,0xe0a98d,0x93827a" labelStroke="0x0" var="btnDataPath"/>
			  <TextInput skin="png.guidecomp.textinput_文字输入底框_2" x="101" y="117" width="216" height="22" color="0xff6600" var="inputDataPath" margin="3,2,2,2"/>
			  <Label text="选择数据路径" x="16" y="118" color="0xff9900" stroke="0"/>
			  <Button label="保存" skin="png.guidecomp.btn_四字常规_1" x="99" y="192" labelColors="0xc79a84,0xe0a98d,0x93827a" labelStroke="0x0" var="btnSave"/>
			  <Button label="取消" skin="png.guidecomp.btn_四字常规_1" x="224" y="191" labelColors="0xc79a84,0xe0a98d,0x93827a" labelStroke="0x0" var="btnCancle"/>
			  <Label x="105" y="90" color="0x999999" stroke="0" width="140" height="20" text="avatarres的上一层目录"/>
			  <Label x="102" y="144" color="0x999999" stroke="0" width="140" height="20" text="ExcelData的上一层目录"/>
			</View>;
		public function SettingViewUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}