/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.app {
	import morn.core.components.*;
	import com.cyj.app.view.app.SetTweenItem;
	public class SetTweenViewUI extends View {
		public var bg:Image = null;
		public var txtTitle:Label = null;
		public var btnClose:Button = null;
		public var btnSave:Button = null;
		public var btnCancle:Button = null;
		public var listProp:List = null;
		protected static var uiView:XML =
			<View width="498" height="402">
			  <Image skin="png.guidecomp.通用面板_2" x="0" y="-1" width="498" height="402" sizeGrid="160,40,160,40,1" var="bg"/>
			  <Label text="设置缓动" x="127" y="7" width="247" height="18" align="center" color="0xccff00" stroke="0x0" var="txtTitle"/>
			  <Button skin="png.guidecomp.btn_关闭_1" x="469" y="15" var="btnClose"/>
			  <Button label="保存" skin="png.guidecomp.btn_四字常规_1" x="156" y="351" labelColors="0xc79a84,0xe0a98d,0x93827a" labelStroke="0x0" var="btnSave"/>
			  <Button label="取消" skin="png.guidecomp.btn_四字常规_1" x="281" y="350" labelColors="0xc79a84,0xe0a98d,0x93827a" labelStroke="0x0" var="btnCancle"/>
			  <List x="20" y="58" repeatY="7" width="466" height="283" spaceY="5" vScrollBarSkin="png.comp.vscroll" var="listProp">
			    <SetTweenItem name="render" runtime="com.cyj.app.view.app.SetTweenItem"/>
			  </List>
			</View>;
		public function SetTweenViewUI(){}
		override protected function createChildren():void {
			viewClassMap["com.cyj.app.view.app.SetTweenItem"] = SetTweenItem;
			super.createChildren();
			createView(uiView);
		}
	}
}