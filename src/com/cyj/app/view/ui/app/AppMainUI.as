/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.app {
	import morn.core.components.*;
	import com.cyj.app.view.app.CenterView;
	import com.cyj.app.view.app.LeftView;
	import com.cyj.app.view.app.TimeLineView;
	public class AppMainUI extends View {
		public var centerPanel:Panel = null;
		public var centerView:CenterView = null;
		public var timeLineView:TimeLineView = null;
		public var appName:Label = null;
		public var txtLog:Label = null;
		public var leftView:LeftView = null;
		protected static var uiView:XML =
			<View width="1402" height="890">
			  <Image skin="png.comp.blank" x="0" y="0" width="1402" height="890"/>
			  <Panel x="220" y="70" width="896" height="475" vScrollBarSkin="png.comp.vscroll" hScrollBarSkin="png.comp.hscroll" var="centerPanel">
			    <CenterView var="centerView" runtime="com.cyj.app.view.app.CenterView"/>
			  </Panel>
			  <TimeLine x="215" y="547" runtime="com.cyj.app.view.app.TimeLineView" var="timeLineView"/>
			  <Label text="应用界面" x="396" y="2" color="0xff9900" stroke="0" width="600" height="32" align="center" size="18" var="appName"/>
			  <Label text="日志" x="1" y="837" width="1402" height="49" color="0x33ff00" var="txtLog" wordWrap="true"/>
			  <Label text="made by cyj 2019.05.16" x="1268" y="869" color="0x666666"/>
			  <Image skin="png.guidecomp.购买类控件底_1" x="1114" y="67" width="280" height="729" sizeGrid="10,10,10,10,1"/>
			  <LeftView x="12" y="77" var="leftView" runtime="com.cyj.app.view.app.LeftView"/>
			</View>;
		public function AppMainUI(){}
		override protected function createChildren():void {
			viewClassMap["com.cyj.app.view.app.CenterView"] = CenterView;
			viewClassMap["com.cyj.app.view.app.LeftView"] = LeftView;
			viewClassMap["com.cyj.app.view.app.TimeLineView"] = TimeLineView;
			super.createChildren();
			createView(uiView);
		}
	}
}