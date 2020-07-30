/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.app {
	import morn.core.components.*;
	import com.cyj.app.view.app.EffectItem;
	import com.cyj.app.view.app.FileItem;
	public class LeftViewUI extends View {
		public var bg:Image = null;
		public var treeEffect:Tree = null;
		public var listEffect:List = null;
		public var treeRole:Tree = null;
		public var btnAddEff:Button = null;
		public var btnRemoveEff:Button = null;
		public var inputId:TextInput = null;
		public var inputName:TextInput = null;
		protected static var uiView:XML =
			<View width="197" height="870">
			  <Image skin="png.guidecomp.购买类控件底_1" x="0" y="0" width="197" height="870" sizeGrid="10,10,10,10,1" var="bg"/>
			  <Label text="特效组列表" x="37" y="608" width="99" height="18" color="0x990000" align="center"/>
			  <Tree x="16" y="237" width="162" height="308" scrollBarSkin="png.comp.vscroll" spaceBottom="3" var="treeEffect">
			    <FileItem name="render" runtime="com.cyj.app.view.app.FileItem" x="10" y="10"/>
			  </Tree>
			  <List x="15" y="631" vScrollBarSkin="png.comp.vscroll" width="173" height="230" spaceY="2" var="listEffect">
			    <EffectItem name="render" runtime="com.cyj.app.view.app.EffectItem"/>
			  </List>
			  <Label text="特效资源列表" x="49" y="219" width="99" height="18" color="0x990000" align="center"/>
			  <Label text="角色资源列表" x="52.5" y="5" width="99" height="18" color="0x990000" align="center"/>
			  <Tree x="19" y="26" width="162" height="195" scrollBarSkin="png.comp.vscroll" spaceBottom="3" var="treeRole">
			    <FileItem name="render" runtime="com.cyj.app.view.app.FileItem" x="10" y="10"/>
			  </Tree>
			  <Button skin="png.guidecomp.btn_加号_1" x="133" y="607" var="btnAddEff" width="23" height="23"/>
			  <Button skin="png.guidecomp.btn_减号_1" x="156" y="607" var="btnRemoveEff"/>
			  <Label text="特效组ID：" x="19" y="556" color="0xff9900" stroke="0" height="19" align="right"/>
			  <TextInput text="0" skin="png.comp.textinput" x="84" y="555" color="0x0" var="inputId" width="65" height="22"/>
			  <Label text="特效组名字：" x="7" y="580" color="0xff9900" stroke="0" height="18" align="right"/>
			  <TextInput text="0" skin="png.comp.textinput" x="84" y="579" color="0x0" var="inputName" width="65" height="22"/>
			</View>;
		public function LeftViewUI(){}
		override protected function createChildren():void {
			viewClassMap["com.cyj.app.view.app.EffectItem"] = EffectItem;
			viewClassMap["com.cyj.app.view.app.FileItem"] = FileItem;
			super.createChildren();
			createView(uiView);
		}
	}
}