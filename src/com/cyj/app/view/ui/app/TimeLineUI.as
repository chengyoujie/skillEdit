/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.app {
	import morn.core.components.*;
	import com.cyj.app.view.common.frame.FrameLine;
	public class TimeLineUI extends View {
		public var btnPlay:Button = null;
		public var panelFrameLine:Panel = null;
		public var listFrameLine:List = null;
		public var boxFrameTop:Box = null;
		public var arrow:Box = null;
		public var inputSpeed:TextInput = null;
		public var inputFrame:TextInput = null;
		public var btnAddLayer:Button = null;
		public var btnRemoveLayer:Button = null;
		public var txtAvtName:Label = null;
		public var txtResPath:Label = null;
		protected static var uiView:XML =
			<View width="896" height="250">
			  <Button label="!>" skin="png.comp.button" x="411" y="5" width="29" height="23" var="btnPlay"/>
			  <Panel x="0" y="47" width="897" height="179" vScrollBarSkin="png.comp.vscroll" hScrollBarSkin="png.comp.hscroll" var="panelFrameLine">
			    <List repeatY="5" var="listFrameLine" x="0" y="17" spaceY="2">
			      <FrameLine name="render" runtime="com.cyj.app.view.common.frame.FrameLine"/>
			    </List>
			  </Panel>
			  <Box x="125" y="38" width="769" height="16" var="boxFrameTop">
			    <Box var="arrow" mouseChildren="false" x="0" y="0" width="15" height="16">
			      <Image skin="png.guidecomp.img_arrow"/>
			      <Image skin="png.guidecomp.line" x="9" y="10" rotation="90" width="150"/>
			    </Box>
			  </Box>
			  <Label text="帧频：" x="676" y="11" color="0x33ff"/>
			  <TextInput text="12" skin="png.comp.textinput" x="710" y="12" width="52" height="22" var="inputSpeed" restrict="12"/>
			  <Label text="当前帧:" x="773" y="14" color="0x33ff"/>
			  <TextInput text="12" skin="png.comp.textinput" x="818" y="12" width="52" height="22" restrict="0-9" var="inputFrame"/>
			  <Button label="+" skin="png.comp.button" x="132" y="4" width="23" height="23" var="btnAddLayer"/>
			  <Button label="-" skin="png.comp.button" x="159" y="3" width="23" height="23" var="btnRemoveLayer"/>
			  <Label text="名字" x="9" y="8" color="0x33ff" width="93" height="18" var="txtAvtName"/>
			  <Label text="路径" x="5" y="231" color="0x33ff" width="437" height="18" var="txtResPath"/>
			</View>;
		public function TimeLineUI(){}
		override protected function createChildren():void {
			viewClassMap["com.cyj.app.view.common.frame.FrameLine"] = FrameLine;
			super.createChildren();
			createView(uiView);
		}
	}
}