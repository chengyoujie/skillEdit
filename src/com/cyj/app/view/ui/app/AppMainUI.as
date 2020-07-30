/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.app {
	import morn.core.components.*;
	import com.cyj.app.view.app.CenterView;
	import com.cyj.app.view.app.LeftView;
	import com.cyj.app.view.app.RightView;
	public class AppMainUI extends View {
		public var bg:Image = null;
		public var centerPanel:Panel = null;
		public var centerView:CenterView = null;
		public var leftView:LeftView = null;
		public var appName:Label = null;
		public var txtLog:Label = null;
		public var txtAuth:Label = null;
		public var rightView:RightView = null;
		public var boxOper:Box = null;
		public var btnSetting:Button = null;
		public var btnSvnCommit:Button = null;
		public var btnSave:Button = null;
		public var btnOpenWebDir:Button = null;
		public var btnSvnUpdate:Button = null;
		public var btnOpenDataDir:Button = null;
		protected static var uiView:XML =
			<View width="1402" height="950">
			  <Image skin="png.comp.blank" x="0" y="0" width="1402" var="bg" height="950"/>
			  <Panel x="200" y="53" width="918" height="869" vScrollBarSkin="png.comp.vscroll" hScrollBarSkin="png.comp.hscroll" var="centerPanel">
			    <CenterView var="centerView" runtime="com.cyj.app.view.app.CenterView"/>
			  </Panel>
			  <LeftView x="0" y="52" var="leftView" runtime="com.cyj.app.view.app.LeftView"/>
			  <Label text="应用界面" x="396" y="7" color="0xff9900" stroke="0" width="600" height="32" align="center" size="18" var="appName"/>
			  <Label text="日志" x="5" y="924" width="1271" height="21" color="0x33ff00" var="txtLog" wordWrap="true"/>
			  <Label text="made by cyj 2019.12.02" x="1268" y="930" color="0x666666" var="txtAuth"/>
			  <RightView x="1121" y="52" var="rightView" runtime="com.cyj.app.view.app.RightView"/>
			  <Box x="1109" y="14" var="boxOper">
			    <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" var="btnSetting" labelStroke="0" width="47" height="28" x="250" label="设置" y="0"/>
			    <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" var="btnSvnCommit" labelStroke="0" width="49" height="28" x="96" label="上传(W)" y="0"/>
			    <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" var="btnSave" labelStroke="0" width="47" height="28" label="保存(S)" y="0"/>
			    <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" var="btnOpenWebDir" labelStroke="0" width="56" height="28" x="145" label="打开web" y="0"/>
			    <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" var="btnSvnUpdate" labelStroke="0" width="49" height="28" x="47" label="更新(Q)" y="0"/>
			    <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" var="btnOpenDataDir" labelStroke="0" width="55" height="28" x="200" label="打开data" y="0"/>
			  </Box>
			</View>;
		public function AppMainUI(){}
		override protected function createChildren():void {
			viewClassMap["com.cyj.app.view.app.CenterView"] = CenterView;
			viewClassMap["com.cyj.app.view.app.LeftView"] = LeftView;
			viewClassMap["com.cyj.app.view.app.RightView"] = RightView;
			super.createChildren();
			createView(uiView);
		}
	}
}