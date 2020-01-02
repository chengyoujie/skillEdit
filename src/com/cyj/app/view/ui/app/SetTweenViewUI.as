/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.app {
	import morn.core.components.*;
	import com.cyj.app.view.app.SetTweenItem;
	public class SetTweenViewUI extends View {
		public var bg:Image = null;
		public var txtTitle:Label = null;
		public var btnClose:Button = null;
		public var listProp:List = null;
		public var btnAddTween:Button = null;
		public var btnRemoveTween:Button = null;
		protected static var uiView:XML =
			<View width="498" height="402">
			  <Image skin="png.guidecomp.通用面板_2" x="0" y="-1" width="498" height="402" sizeGrid="160,40,160,40,1" var="bg"/>
			  <Label text="设置缓动" x="127" y="7" width="247" height="18" align="center" color="0xccff00" stroke="0x0" var="txtTitle"/>
			  <Button skin="png.guidecomp.btn_关闭_1" x="469" y="15" var="btnClose"/>
			  <List x="11" y="62" repeatY="7" width="469" height="327" spaceY="5" vScrollBarSkin="png.comp.vscroll" var="listProp">
			    <SetTweenItem name="render" runtime="com.cyj.app.view.app.SetTweenItem"/>
			  </List>
			  <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" var="btnAddTween" labelStroke="0" width="67" height="28" x="21" label="添加缓动" y="36"/>
			  <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" var="btnRemoveTween" labelStroke="0" width="67" height="28" x="90" label="删除缓动" y="35"/>
			</View>;
		public function SetTweenViewUI(){}
		override protected function createChildren():void {
			viewClassMap["com.cyj.app.view.app.SetTweenItem"] = SetTweenItem;
			super.createChildren();
			createView(uiView);
		}
	}
}