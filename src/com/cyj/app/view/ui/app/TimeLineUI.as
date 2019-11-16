/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.app {
	import morn.core.components.*;
	import com.cyj.app.view.common.frame.FrameLine;
	public class TimeLineUI extends View {
		public var btnPlay:Button = null;
		public var panelFrameLine:Panel = null;
		public var listFrameLine:List = null;
		public var boxFrameTop:Box = null;
		public var arrow:Image = null;
		protected static var uiView:XML =
			<View width="896" height="250">
			  <Button label="!>" skin="png.comp.button" x="414" y="7" width="29" height="23" var="btnPlay"/>
			  <Panel x="-2" y="47" width="897" height="179" vScrollBarSkin="png.comp.vscroll" hScrollBarSkin="png.comp.hscroll" var="panelFrameLine">
			    <List repeatY="5" var="listFrameLine" x="4" y="-8">
			      <FrameLine name="render" runtime="com.cyj.app.view.common.frame.FrameLine" y="17"/>
			    </List>
			  </Panel>
			  <Box x="54" y="38" width="844" height="16" var="boxFrameTop">
			    <Image skin="png.guidecomp.img_arrow" var="arrow"/>
			  </Box>
			</View>;
		public function TimeLineUI(){}
		override protected function createChildren():void {
			viewClassMap["com.cyj.app.view.common.frame.FrameLine"] = FrameLine;
			super.createChildren();
			createView(uiView);
		}
	}
}