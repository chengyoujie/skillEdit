/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.app {
	import morn.core.components.*;
	import com.cyj.app.view.app.CenterView;
	import com.cyj.app.view.app.LeftView;
	import com.cyj.app.view.app.RightView;
	public class AppMainUI extends View {
		public var centerPanel:Panel = null;
		public var centerView:CenterView = null;
		public var appName:Label = null;
		public var txtLog:Label = null;
		public var rightView:RightView = null;
		public var leftView:LeftView = null;
		public var btnSetting:Button = null;
		protected static var uiView:XML =
			<View width="1402" height="880">
			  <Image skin="png.comp.blank" x="0" y="0" width="1402" height="880"/>
			  <Panel x="216" y="53" width="896" height="800" vScrollBarSkin="png.comp.vscroll" hScrollBarSkin="png.comp.hscroll" var="centerPanel">
			    <CenterView var="centerView" runtime="com.cyj.app.view.app.CenterView"/>
			  </Panel>
			  <Label text="应用界面" x="396" y="7" color="0xff9900" stroke="0" width="600" height="32" align="center" size="18" var="appName"/>
			  <Label text="日志" x="1" y="858" width="1271" height="21" color="0x33ff00" var="txtLog" wordWrap="true"/>
			  <Label text="made by cyj 2019.12.02" x="1268" y="858" color="0x666666"/>
			  <RightView x="1118" y="51" var="rightView" runtime="com.cyj.app.view.app.RightView"/>
			  <LeftView x="6" y="52" var="leftView" runtime="com.cyj.app.view.app.LeftView"/>
			  <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" var="btnSetting" labelStroke="0" width="38" height="28" x="1356" label="设置" y="16"/>
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